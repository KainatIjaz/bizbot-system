import random
import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import psycopg2
from sklearn.metrics import mean_squared_error  # For evaluation
import streamlit.components.v1 as components
from prophet import Prophet
from transformers import AutoTokenizer, GPT2LMHeadModel, pipeline
from langchain_community.llms import HuggingFacePipeline
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain
import os
import base64
import subprocess


# --- Streamlit Page Configuration ---
st.set_page_config(page_title="🤖 Bizbot Admin Support", layout="wide")

def set_background(image_path):
    with open(image_path, "rb") as img_file:
        encoded = base64.b64encode(img_file.read()).decode()

    page_bg_img = f"""
    <style>
    .stApp {{
        background-image: url("data:image/jpg;base64,{encoded}");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
    }}
    </style>
    """
    st.markdown(page_bg_img, unsafe_allow_html=True)

set_background("b.jpg")  

st.sidebar.title("🤖 BizBot: Admin Support")
menu_option = st.sidebar.radio("Select an Option", [
    "Analysis", "Prediction", "Send Invoices", "AI Recommendation"
])
DB_NAME = "Bizbot"  # Replace with your actual database name
DB_USER = "postgres"  # Replace with your actual username
DB_PASSWORD = "1234"  # Replace with your actual password

# ----------------------------
# Database and Prediction Functions (unchanged, but ensuring correct placement)
# ----------------------------
def fetch_sales_data():
    conn = psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
    )
    query = """
    SELECT "Date", "Time", "Quantity", "Sale Price"
    FROM sales
    ORDER BY "Date", "Time";
    """
    df = pd.read_sql(query, conn)
    conn.close()
    df['Date'] = pd.to_datetime(df['Date'])
    return df

def prepare_daily_data(df):
    df['Revenue'] = df['Quantity'] * df['Sale Price']
    daily = df.groupby('Date')['Revenue'].sum().reset_index()
    daily = daily.rename(columns={'Date': 'ds', 'Revenue': 'y'})
    return daily

def predict_sales(data, periods, freq):
    model = Prophet()
    model.fit(data)
    future = model.make_future_dataframe(periods=periods, freq=freq)
    forecast = model.predict(future)
    return forecast
import plotly.graph_objects as go

def plot_sales_streamlit(historical, forecast, title):
    import numpy as np

    # Only last 12 days of historical data
    historical = historical.tail(12)

    # Get only future forecasted dates
    future_dates = forecast.loc[forecast['ds'] > historical['ds'].max()]

    # Consistent date formatting for all x-axis labels (e.g., 21 Jun)
    hist_x = historical['ds'].dt.strftime('%d %b')
    future_x = future_dates['ds'].dt.strftime('%d %b')

    fig = go.Figure()

    # Historical bars
    fig.add_trace(go.Bar(
        x=hist_x,
        y=historical['y'],
        name='Historical Sales',
        marker_color='#003637',
        hovertemplate='Date: %{x}<br>Revenue: %{y:,.2f}<extra></extra>'
    ))

    # Forecast bars
    fig.add_trace(go.Bar(
        x=future_x,
        y=future_dates['yhat'],
        name='Predicted Sales',
        marker_color='#00B8B0',
        hovertemplate='Date: %{x}<br>Predicted Revenue: %{y:,.2f}<extra></extra>'
    ))

    # Layout settings
    fig.update_layout(
        title=title,
        xaxis_title='Date',
        yaxis_title='Sales Revenue (in Rs)',
        barmode='group',
        legend_title_text='Legend',
        hovermode='x',
        xaxis_tickangle=-45,
        plot_bgcolor='white'
    )

    fig.update_yaxes(showgrid=True, gridwidth=0.5, gridcolor='lightgray')

    st.plotly_chart(fig, use_container_width=True)

# -----------------------------
# Module Logic based on Sidebar Selection
# -----------------------------

if menu_option == "AI Recommendation":
    st.title("🧠 AI Recommendation Engine")
    st.markdown("Ask me anything! Type your message below.")

    # --- Hugging Face Model ID ---
    # Use your Hugging Face Hub model ID here
    model_id_on_hub = "KainatIjaz/my-finetuned-gpt2-model" # <--- REPLACE WITH YOUR ACTUAL MODEL ID

    # --- Model Loading and Pipeline Setup (Cached for efficiency) ---
    # Use st.cache_resource to load the model and tokenizer only once
    # when the app starts, even across reruns.
    @st.cache_resource
    def load_model_and_pipeline(model_id):
        """
        Loads the GPT-2 model and tokenizer from Hugging Face Hub
        and sets up the text generation pipeline.
        """
        try:
            tokenizer = AutoTokenizer.from_pretrained(model_id)
            model = GPT2LMHeadModel.from_pretrained(model_id)
            # Removed st.success messages for loading progress
        except Exception as e:
            st.error(f"Error loading model or tokenizer from Hugging Face Hub {model_id}: {e}")
            st.error("Please ensure your model ID is correct and publicly accessible, or you are logged in if it's private.")
            st.stop() # Stop the app if model loading fails

        # Set pad_token if it's None (common for GPT-2)
        if tokenizer.pad_token is None:
            tokenizer.pad_token = tokenizer.eos_token
            # Removed st.info message for tokenizer pad_token
        
        # Configure the text generation pipeline
        generator = pipeline(
            "text-generation",
            model=model,
            tokenizer=tokenizer,
            max_length=512,
            pad_token_id=tokenizer.eos_token_id,
            truncation=True,
            do_sample=True,
            temperature=0.7,
            top_k=50,
            top_p=0.95
        )
        # Removed st.success message for pipeline configuration
        return generator, tokenizer

    # Load the generator and tokenizer
    generator, tokenizer = load_model_and_pipeline(model_id_on_hub)

    # --- LangChain Setup ---
    # Use st.cache_resource for LangChain components as well
    @st.cache_resource
    def setup_langchain_chain(_generator): # Corrected: Added underscore
        """
        Sets up the LangChain LLM and chain.
        """
        llm = HuggingFacePipeline(pipeline=_generator) # Corrected: Used underscored name
        prompt_template = PromptTemplate(
            input_variables=["user_input"],
            template="User said: {user_input}\nAssistant:"
        )
        chain = LLMChain(llm=llm, prompt=prompt_template)
        # Removed st.success message for LangChain initialization
        return chain

    # Initialize the LangChain chain
    chain = setup_langchain_chain(generator)

    # --- Chat History Management ---
    # Initialize chat history in session state if not already present
    if "messages" not in st.session_state:
        st.session_state.messages = []
        st.session_state.messages.append({"role": "assistant", "content": "Hi! How can I help you today?"})

    # --- "Start Over" Button ---
    if st.button("Start Over"):
        st.session_state.messages = [] # Clear messages
        st.session_state.messages.append({"role": "assistant", "content": "Hi! How can I help you today?"}) # Add initial message
        st.rerun() # Rerun the app to update the chat

    # --- Display Chat Messages ---
    # Iterate through the chat history and display messages
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    # --- User Input and Response Generation ---
    # Get user input from the chat input box
    user_input = st.chat_input("Type your message here...")

    if user_input:
        # Add user message to chat history
        st.session_state.messages.append({"role": "user", "content": user_input})
        # Display user message
        with st.chat_message("user"):
            st.markdown(user_input)

        # Generate response
        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                response = chain.run(user_input)

                # --- Response Cleaning Logic (adapted for Streamlit) ---
                if isinstance(response, str):
                    response = response.strip()

                    full_prompt_echo = f"User said: {user_input}"

                    # Remove the echoed prompt from the beginning of the response
                    if response.lower().startswith(full_prompt_echo.lower()):
                        response = response[len(full_prompt_echo):].strip()
                        response = response.lstrip(":? .\n").strip()

                    # Remove common chatbot prefixes that the model might generate
                    for prefix in ["Assistant:", "User:", "Bot:", "user:", "bot:", "You:"]:
                        while response.lower().startswith(prefix.lower()):
                            response = response[len(prefix):].strip()
                            response = response.lstrip(":? .\n").strip()

                    # Clean up lines and prevent generating new "User:" turns
                    lines = response.splitlines()
                    cleaned_lines = []
                    for line in lines:
                        s = line.strip()
                        # Stop if a line ends with '?' and is not part of the original input
                        # and if there's already some content, to prevent truncated questions
                        if s.endswith('?') and user_input.lower() not in s.lower() and len(cleaned_lines) > 0:
                            break
                        # Stop if a new turn (User:, Bot:) is detected
                        if s.lower().startswith(("user:", "bot:", "you:", "assistant:")):
                            break
                        if s: # Only add non-empty lines
                            cleaned_lines.append(s)

                    response = '\n'.join(cleaned_lines).strip()

                    # Capitalize the first letter of the response if it exists
                    if response:
                        response = response[0].upper() + response[1:]
                    else:
                        response = "I'm sorry, I couldn't generate a clear response." # Fallback for empty response

                st.markdown(response)
                st.session_state.messages.append({"role": "assistant", "content": response})

elif menu_option == "Analysis":
    st.title("📈 Analysis")
    components.iframe(
        "https://app.powerbi.com/view?r=eyJrIjoiOWRlYjJkZDYtOTBkZi00N2VjLWI4MmUtZWUwMGVmZTM2MTJmIiwidCI6IjEyYjIyMWIzLTA0NjQtNDIyMy04OWU1LTg4ODgzNTc3OGI1OCIsImMiOjl9",
        width=1300,
        height=600,
        scrolling=True
    )

elif menu_option == "Prediction":
    st.title("🔮 Predictive Analysis")
    
    # Allow user to select number of days to forecast (limited to 7 here)
    num_days = st.sidebar.slider("Select number of days to forecast:", min_value=1, max_value=7, value=3)
    
    try:
        df = fetch_sales_data()
        daily_data = prepare_daily_data(df)
        daily_forecast = predict_sales(daily_data, periods=num_days, freq='D')
        
        plot_sales_streamlit(daily_data, daily_forecast, f"Daily Sales Revenue: Next {num_days} Days Prediction")
    
    except psycopg2.Error as e:
        st.error(f"Error connecting to or querying the database: {e}")
    except Exception as e:
        st.error(f"An unexpected error occurred: {e}")

elif menu_option == "Send Invoices":
    st.title("📲 WhatsApp Sender Launcher")

    if st.button("🚀 Send WhatsApp Messages"):
        st.info("⏳ Launching message sender script... please check browser.")
        subprocess.Popen(["python", "send_whatsapp.py"])
        st.success(" Message sender started.")
