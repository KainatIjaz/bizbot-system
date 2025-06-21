# 📦 BizBot System

Welcome to **BizBot**, a dual-module platform that empowers businesses with:
- A **Customer Support Portal** to handle queries, complaints, and product availability.
- An **Admin Dashboard** to manage insights, AI recommendations, WhatsApp invoices, and forecasting.

---

## 📁 Repository Structure

**GitHub:** [BizBot GitHub Repository](https://github.com/KainatIjaz/bizbot-system)

bizbot-system/
├── admin_app/
│ ├── app.py # Admin Dashboard
│ ├── send_whatsapp.py # Script for sending WhatsApp invoices
│ └── b.jpg # Background image
├── customer_app/
│ ├── app.py # Customer Interface
│ └── b.jpg # Background image
├── requirements.txt # Python dependencies
├── README.md # Documentation
├── database_schema.sql # SQL for creating tables

yaml
Copy
Edit

---

## ✅ Pre-Requisites
- Python 3.9+
- Git
- PostgreSQL (running with an empty database created)

---

## 🚀 Installation & Setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/KainatIjaz/bizbot-system.git
cd bizbot-system
Step 2: Create & Activate Virtual Environment
bash
Copy
Edit
python -m venv venv
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate
Step 3: Install Dependencies
bash
Copy
Edit
pip install -r requirements.txt
Step 4: Setup Database
Create a PostgreSQL database named Bizbot.

Run the schema:

bash
Copy
Edit
psql -U postgres -d Bizbot -f database_schema.sql
Step 5: Configure Database Access
Update these lines in both admin_app/app.py and customer_app/app.py:

python
Copy
Edit
psycopg2.connect("dbname=Bizbot user=postgres password=1234")
Step 6: Run Applications
Customer App:

bash
Copy
Edit
cd customer_app
streamlit run app.py
Admin App (in another terminal):

bash
Copy
Edit
cd admin_app
streamlit run app.py
🧠 Admin Dashboard Manual
🔍 Overview
BizBot's Admin Panel offers:

AI-powered Sales Recommendations

Sales Forecasting with Prophet

Visual Insights via Power BI

WhatsApp-based Invoice Sending (via send_whatsapp.py)

💻 System Requirements
Python 3.9+

PostgreSQL

Required libraries: streamlit, psycopg2, prophet, transformers, langchain, pandas, plotly

🧩 Modules & Features
1. Analysis
View interactive Power BI dashboards.

Analyze KPIs, trends, and performance metrics.

2. Prediction
Forecast daily sales (1 to 7 days) using Prophet.

View historical and future sales in grouped bar charts.

3. Send Invoices
Launches WhatsApp Web with pre-filled invoice text.

Calls send_whatsapp.py to automate browser script launch.

Admin manually sends it to customers.

4. AI Recommendation
Uses a fine-tuned GPT-2 model (KainatIjaz/my-finetuned-gpt2-model) via HuggingFace + LangChain.

Admin can ask sales or business-related queries.

🔗 Data & Model Setup
Sales Table must include: Date, Time, Quantity, Sale Price

Model must be public or accessed via token from HuggingFace.

⚠ Troubleshooting
Model Error: Verify model ID/token.

DB Error: Check credentials or if PostgreSQL is running.

No Forecast: Ensure data isn’t empty.

🔄 Maintenance
Periodically update the GPT-2 model.

Backup dashboards.

Keep database cleaned and updated.

🤖 Customer Portal Manual
🧭 Getting Started
On launch, users are welcomed and asked to choose from 7 service modules.

💡 Modules & Features
1. Branch Timings ⏰
Get operating hours by selecting a branch.

2. Live Sales/Discount Info 🏷️
View active promotions per branch.

3. Product Availability 🏬
Enter product name + quantity.

View which branches have stock.

If unavailable, user can submit contact info for restock alerts.

4. Product Location 📍
Search for product placement within branches.

5. Product Detail 🛒
View product name, price, category, and description.

6. Our Products 📦
Explore products by category.

7. File a Complaint 📝
Submit complaints using email and description.



⚠ Notes
Email/phone fields are mandatory for contact features.

Input must match existing records for accurate queries.

Background image b.jpg should be present in both app folders for consistent UI.


Contributions are welcome via pull requests!



Thank you for using BizBot!

