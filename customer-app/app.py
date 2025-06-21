import streamlit as st
import psycopg2

# --- Database Functions (from your original code) ---
def get_connection():
    try:
        return psycopg2.connect("dbname=Bizbot user=postgres password=1234")
    except psycopg2.Error as e:
        st.error(f" Database connection error: {e}")
        return None

def execute_sql_query(query, params=None):
    try:
        connection = get_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(query, params)
            connection.commit()

            if query.strip().upper().startswith("SELECT"):
                results = cursor.fetchall()
            else:
                results = None

            cursor.close()
            connection.close()
            return results, None
        else:
            return None, "Connection Failed"
    except psycopg2.Error as e:
        return None, e

def check_product_availability(product_name, quantity):
    query = """
        SELECT b.branch_name, b.location, b.phone_number, i.quantity
        FROM inventory i
        JOIN branch b ON i.branch_id = b.branch_id
        JOIN product p ON i.product_id = p.product_id
        WHERE p.product_name ILIKE %s AND i.quantity >= %s
    """
    results, error = execute_sql_query(query, (product_name, quantity))
    return results, error

def store_contact_details(product_name, email, whatsapp, quantity):
    query = """
        INSERT INTO restock_notifications (product_name, email, whatsapp, requested_quantity)
        VALUES (%s, %s, %s, %s)
    """
    results, error = execute_sql_query(query, (product_name, email, whatsapp, quantity))
    return results, error

def store_complaint(email, complaint):
    query = """
        INSERT INTO complaints (email, complaint_text)
        VALUES (%s, %s)
    """
    results, error = execute_sql_query(query, (email, complaint))
    return results, error

# --- Streamlit UI Setup ---

import base64

st.set_page_config(page_title="BizBot Customer Support")

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

set_background("b.jpg")  # 👈 Add your image path here

# --- Session State Initialization ---
if "current_view" not in st.session_state:
    st.session_state.current_view = "main_menu"

# --- Back Arrow + Title in Same Line ---
# --- Back Arrow and Title Aligned Horizontally with Flexbox ---
# --- Back Arrow and Title Aligned with st.columns ---
if st.session_state.current_view != "main_menu":
    col1, col2 = st.columns([0.08, 0.92])  # Adjust the ratio for better alignment

    with col1:
        st.markdown("""
            <style>
            .stButton > button {
                background-color: #f63366;
                color: white;
                font-weight: bold;
                font-size: 18px;
                border-radius: 8px;
                padding: 8px 16px;
            }
            </style>
        """, unsafe_allow_html=True)
        if st.button("←", key="back_arrow"):
            for key in list(st.session_state.keys()):
                del st.session_state[key]
            st.session_state.current_view = "main_menu"
            st.rerun()

    with col2:
        st.title("🤖 BizBot: Customer Support")

else:
    st.title("🤖 BizBot: Customer Support")




if "contact_submitted" not in st.session_state:
    st.session_state.contact_submitted = False

if "show_contact_form" not in st.session_state:
    st.session_state.show_contact_form = False

# --- Menu Options ---
menu_options = [
    "Branch Timings ⏰",
    "Live Sales/Discount 🏷️",
    "Product Detail 🛒",
    "Product Location 📍",
    "Product Availability 🏬",
    "Our Products 📦",
    "File a Complaint 📝"
]

# --- Functions for displaying views ---

def show_main_menu():
    st.markdown("## How can I assist you today? Select an option below:")
    cols = st.columns(3) # Display options in columns for a cleaner look
    for i, option in enumerate(menu_options):
        with cols[i % 3]: # Distribute buttons across columns
            if st.button(option, key=f"menu_option_{option}"):
                st.session_state.current_view = option
                st.rerun() # Rerun to switch view

def show_branch_timings():
    st.subheader("⏰ Branch Timings")
    branch_names_query = "SELECT branch_name FROM branch"
    branch_names_results, error = execute_sql_query(branch_names_query)

    if error:
        st.error(f"Database error: {error}")
    elif branch_names_results:
        branch_names = [row[0] for row in branch_names_results]
        selected_branch = st.selectbox("Select a branch:", branch_names)

        if st.button("Get Timings 🕒"):
            timings_query = """
                SELECT branch_timing
                FROM branch
                WHERE branch_name = %s
            """
            timings_results, error = execute_sql_query(timings_query, (selected_branch,))
            if error:
                st.error(f"Database error: {error}")
            elif timings_results:
                timings = timings_results[0][0]
                st.success(f"🕒 Timings for **{selected_branch}**: {timings}")
            else:
                st.warning("Could not retrieve timings for this branch.")
    else:
        st.warning(" No branches found in the database.")

def show_product_detail():
    st.subheader("🔍 View Product Details")
    product_name = st.text_input("Enter the product name to get details:")

    if st.button("Get Product Details 🔎"):
        if not product_name:
            st.error("❗ Please enter a product name.")
        else:
            detail_query = """
                SELECT product_name, price, description, category
                FROM product
                WHERE product_name ILIKE %s
            """
            detail_results, error = execute_sql_query(detail_query, (product_name,))
            if error:
                st.error(f"❌ Database error: {error}")
            elif detail_results:
                for name, price, description, category in detail_results:
                    st.markdown(f"### 🛍 {name}")
                    st.write(f"**Price: Rs. {int(price):,}**")
                    st.write(f"📝 **Description:** {description}")
                    st.write(f"📂 **Category:** {category}")
            else:
                st.warning("No product found with that name.")

def show_our_products():
    st.subheader("📦 Browse Available Products by Category")
    category_query = "SELECT DISTINCT category FROM product ORDER BY category"
    category_results, error = execute_sql_query(category_query)

    if error:
        st.error(f"Database error: {error}")
    elif category_results:
        categories = [row[0] for row in category_results]
        selected_category = st.selectbox("Select a category to view products:", categories)

        if selected_category:
            products_query = """
                SELECT product_name
                FROM product
                WHERE category = %s
            """
            product_results, error = execute_sql_query(products_query, (selected_category,))
            if error:
                st.error(f" Database error: {error}")
            elif product_results:
                st.markdown(f"### Products in category: {selected_category}")
                for (name,) in product_results:
                    st.markdown(f"- 🛒 {name}")
            else:
                st.info(f"ℹ️ No products found in category: {selected_category}")
    else:
        st.info("No categories found in the product table.")

def show_product_availability():
    st.subheader("🏬 Product Availability for a Specific Quantity")
    product_name = st.text_input("Enter the product name:")
    quantity = st.number_input("Enter the required quantity:", min_value=1, step=1)

    if st.button("Check Availability 🔍"):
        if not product_name:
            st.error("❗ Product name cannot be empty.")
        else:
            availability_results, error = check_product_availability(product_name, quantity)
            if error:
                st.error(f"❌ Error checking availability: {error}")
            elif availability_results:
                st.success("✅ Branch Availability:")
                for row in availability_results:
                    branch_name, location, phone_number, available_quantity = row
                    st.write(f"🏬 Branch: **{branch_name}**, 📍 Location: {location}, 📞 Phone: {phone_number}, 📦 Quantity Available: {available_quantity}")
            else:
                st.warning("⚠️ The requested quantity is not available for the product.")
                st.session_state.show_contact_form = True

    if st.session_state.show_contact_form:
        st.markdown("### 📝 Notify Me When Available")
        email = st.text_input("📧 Enter your email:", key="email_avail")
        whatsapp = st.text_input("📱 Enter your WhatsApp number:", key="whatsapp_avail")

        if st.button("Submit Contact Details ✉️", key="submit_contact_avail"):
            if email or whatsapp:
                results, error = store_contact_details(product_name, email, whatsapp, quantity)
                if error:
                    st.error(f"Error storing contact details: {error}")
                elif results is None:
                    st.success("✅ Your contact details have been recorded. We will notify you when the product is restocked.")
                    st.session_state.contact_submitted = True
                    st.session_state.show_contact_form = False
                else:
                    st.error("Failed to store contact details.")
            else:
                st.error("Email or WhatsApp number is required.")

    if st.session_state.contact_submitted:
        st.info("🙏 Thank you for submitting your contact details. You will be notified once the product is restocked.")


def show_live_sales_discount_info():
    st.subheader("🏷️ Live Sales/Discount Information")
    branch_names_query = "SELECT branch_name FROM branch"
    branch_names_results, error = execute_sql_query(branch_names_query)

    if error:
        st.error(f"Database error: {error}")
    elif branch_names_results:
        branch_names = [row[0] for row in branch_names_results]
        selected_branch = st.selectbox("Select a branch to see live sales:", branch_names)

        if st.button("Get Info 🎁"):
            sales_query = """SELECT sale FROM branch WHERE branch_name = %s"""
            sales_results, error = execute_sql_query(sales_query, (selected_branch,))
            if error:
                st.error(f" Database error: {error}")
            elif sales_results:
                sale_info = sales_results[0][0]
                st.success(f"📈 Live Sales Information for **{selected_branch}**: {sale_info}")
            else:
                st.warning(f"⚠ No sales information found for {selected_branch}. Check if the 'sale' column exists and has data for this branch.")
    else:
        st.warning("⚠ No branches found in the database.")

def show_product_location():
    st.subheader("📍 Product Location in Inventory")
    product_name = st.text_input("Enter the product name:")

    branch_names_query = "SELECT branch_name FROM branch"
    branch_names_results, error = execute_sql_query(branch_names_query)
    branch_names = [row[0] for row in branch_names_results] if branch_names_results else []
    if error:
        st.error(f" Database error: {error}")
    elif branch_names:
        selected_branch = st.selectbox("Select a branch (optional):", ["All Branches"] + branch_names)
    else:
        st.warning("No branches found in the database.")
        selected_branch = None

    if st.button("Find Location 🔎"):
        if not product_name:
            st.error(" Please enter a product name.")
        elif selected_branch is None:
            st.error("No branches found in the database. Cannot search for product location.")
        else:
            location_query = """
                SELECT i.product_location, b.branch_name
                FROM inventory i
                JOIN product p ON i.product_id = p.product_id
                JOIN branch b ON i.branch_id = b.branch_id
                WHERE p.product_name ILIKE %s
            """
            query_params = [product_name]

            if selected_branch != "All Branches":
                location_query += " AND b.branch_name = %s"
                query_params.append(selected_branch)

            location_results, error = execute_sql_query(location_query, tuple(query_params))
            if error:
                st.error(f" Database error: {error}")
            elif location_results:
                st.success(f"📍 Locations for {product_name}:")
                for location, branch_name in location_results:
                    st.write(f"- 🏬 Branch: {branch_name}, 📦 Location: {location}")
            else:
                st.warning(f" Could not find {product_name} in the selected branch (or in any branch if 'All Branches' was selected). Check if the 'product_location' column exists and has data.")

def show_file_complaint():
    st.subheader("📝 File a Complaint")
    email = st.text_input("📧 Enter your email:", key="email_complaint")
    complaint = st.text_area("✍️ Enter your complaint:", key="complaint_text")

    if st.button("Submit Complaint 🚨", key="submit_complaint"):
        if not email:
            st.error("Email is required.")
        elif not complaint:
            st.error("Complaint is required.")
        else:
            results, error = store_complaint(email, complaint)
            if error:
                st.error(f" Error submitting complaint: {error}")
            elif results is None:
                st.success("✅ Your complaint has been submitted. We will get back to you soon.")
                # Clear inputs after successful submission
                st.session_state.email_complaint = "" # Reset key for text_input
                st.session_state.complaint_text = "" # Reset key for text_area
                # st.experimental_rerun() # No need to rerun, just clear inputs
            else:
                st.error("Failed to submit complaint.")

# --- Main App Logic ---

# Display the selected view based on session_state.current_view
if st.session_state.current_view == "main_menu":
    show_main_menu()
elif st.session_state.current_view == "Branch Timings ⏰":
    show_branch_timings()
elif st.session_state.current_view == "Product Availability 🏬":
    show_product_availability()
elif st.session_state.current_view == "Our Products 📦":
    show_our_products()
elif st.session_state.current_view == "Product Detail 🛒":
    show_product_detail()
elif st.session_state.current_view == "Live Sales/Discount 🏷️":
    show_live_sales_discount_info()
elif st.session_state.current_view == "Product Location 📍":
    show_product_location()
elif st.session_state.current_view == "File a Complaint 📝":
    show_file_complaint()

