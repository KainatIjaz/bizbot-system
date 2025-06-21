# 📦 BizBot System

**BizBot** is a dual-module platform designed to empower businesses through:
- A **Customer Support Portal** to handle queries, complaints, and product availability.
- An **Admin Dashboard** to manage insights, AI recommendations, WhatsApp invoices, and forecasting.

---

## 📁 Repository Structure

```
bizbot-system/
├── admin_app/
│   ├── app.py              # Admin Dashboard
│   ├── send_whatsapp.py    # WhatsApp Invoice Script
│   └── b.jpg               # Background Image
├── customer_app/
│   ├── app.py              # Customer Portal
│   └── b.jpg               # Background Image
├── requirements.txt        # Python Dependencies
├── README.md               # Project Documentation
├── database_schema.sql     # PostgreSQL Schema
```

---

## ✅ Pre-Requisites

- Python 3.9+
- Git
- PostgreSQL (with a blank database created)

---

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/KainatIjaz/bizbot-system.git
cd bizbot-system
```

### Step 2: Create & Activate Virtual Environment

```bash
python -m venv venv

# Windows:
venv\Scripts\activate

# macOS/Linux:
source venv/bin/activate
```

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 4: Setup Database

Create a PostgreSQL database named `Bizbot`, then run the schema:

```bash
psql -U postgres -d Bizbot -f database_schema.sql
```

### Step 5: Configure Database Access

Update the DB connection line in both `admin_app/app.py` and `customer_app/app.py`:

```python
psycopg2.connect("dbname=Bizbot user=postgres password=1234")
```

### Step 6: Run Applications

#### Customer App

```bash
cd customer_app
streamlit run app.py
```

#### Admin Dashboard

```bash
cd admin_app
streamlit run app.py
```

---

## 🧠 Admin Dashboard Manual

### Overview

The Admin Dashboard provides:
- ✅ AI-Powered Sales Recommendations  
- 📈 Forecasting with Prophet  
- 📊 Power BI Insights  
- 📬 WhatsApp Invoice Sending  

### System Requirements

- Python 3.9+
- PostgreSQL
- Required Libraries:
  - `streamlit`
  - `psycopg2`
  - `prophet`
  - `transformers`
  - `langchain`
  - `pandas`
  - `plotly`

### Modules & Features

#### 🔹 Module 1: Analysis
- View interactive Power BI dashboards  
- Analyze KPIs, trends, and performance

#### 🔹 Module 2: Prediction
- Forecast sales (1–7 days) using Prophet  
- View historical + predicted data in grouped bar charts

#### 🔹 Module 3: Send Invoices
- Launch WhatsApp Web with pre-filled invoice  
- Uses `send_whatsapp.py` to open browser automation  
- Admin manually confirms send  

#### 🔹 Module 4: AI Recommendations
- Ask GPT-2 model (`KainatIjaz/my-finetuned-gpt2-model`) for business strategies  
- Integrated via HuggingFace + LangChain

### Data & Model Setup

- Required columns: `Date`, `Time`, `Quantity`, `Sale Price`
- Ensure model is public or accessible via token

### Troubleshooting

| Issue          | Fix                             |
|----------------|----------------------------------|
| Model error    | Verify HuggingFace ID/token     |
| DB connection  | Check credentials/PostgreSQL    |
| No forecasts   | Ensure the sales table has data |

### Maintenance Tips

- Keep GPT-2 model updated  
- Regularly back up dashboards  
- Clean database periodically

---

## 🤖 Customer Portal Manual

### Getting Started

On launch, users choose from 7 modules in an interactive menu.

### Modules & Features

#### 🔹 1. Branch Timings ⏰  
- Shows opening/closing hours by branch

#### 🔹 2. Live Sales/Discounts 🏷️  
- Displays active branch promotions

#### 🔹 3. Product Availability 🏬  
- Users enter product + quantity  
- Returns branch availability  
- Option to leave contact info if out of stock

#### 🔹 4. Product Location 📍  
- Find product placement in branches

#### 🔹 5. Product Detail 🛒  
- Shows name, category, price, and description

#### 🔹 6. Our Products 📦  
- Explore product listings by category

#### 🔹 7. File a Complaint 📝  
- Submit email + description of issue

### Notes

- Email/phone required for contact features  
- Inputs must match existing records  
- Ensure `b.jpg` image is present in both apps for UI consistency

---

## 📬 Support & Contributions

For issues, reach out via [GitHub Issues](https://github.com/KainatIjaz/bizbot-system/issues)  
Contributions welcome via pull requests!

---

---

**Thank you for using BizBot! 🚀**
