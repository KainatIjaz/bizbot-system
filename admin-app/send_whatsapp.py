from playwright.sync_api import sync_playwright
import time
import urllib.parse
import os

# Session folder path (don't delete this between runs)
SESSION_PATH = "whatsapp_session"

# Format message from dictionary
def format_message(data):
    # Split items and prepare formatted lines
    items_raw = [item.strip() for item in data['Products Purchased'].split(',')]
    
    formatted_items = ""
    for item in items_raw:
        # Try to split item name and quantity-price part (e.g. "Fruit Snacks (x5 @ 38.93)")
        if "(" in item and ")" in item:
            name, detail = item.split("(", 1)
            detail = "(" + detail  # add the bracket back
        else:
            name = item
            detail = ""
        formatted_items += f"• {name.strip():<25} {detail.strip()}\n"

    return (
        f"🧾 *Invoice *\n"
        f"──────────────────────\n"
        f"👤 *Customer:* {data['Customer Name']}\n"
        f"🏢 *Branch:* {data['Branch Name']}\n"
        f"📅 *Date:* {data['Date']}\n"
        f"──────────────────────\n"
        f"🛒 *Items Purchased:*\n{formatted_items}"
        f"──────────────────────\n"
        f"💰 *Total Amount:* Rs. {data['Total Price']:.2f}\n"
        f"──────────────────────\n"
        f"🙏 Thank you for shopping with us!\n"
        f"We hope to see you again. 😊"
    )

# Main function to send WhatsApp messages
def send_whatsapp_message(contacts_dict):
    with sync_playwright() as p:
        # Use persistent context to retain login session
        browser = p.chromium.launch_persistent_context(
            SESSION_PATH,
            headless=False,
            args=["--start-maximized"]
        )
        page = browser.pages[0] if browser.pages else browser.new_page()

        # Open WhatsApp Web
        page.goto("https://web.whatsapp.com")

        # Wait for WhatsApp to load by checking for chat input box
        try:
            print("⏳ Waiting for WhatsApp to load or login...")
            page.wait_for_selector("div[contenteditable='true'][data-tab]", timeout=60000)
            print("✅ WhatsApp is ready to send messages.")
        except Exception:
            print("⚠️ WhatsApp not ready yet. Waiting longer (maybe QR scan needed)...")
            page.wait_for_selector("div[contenteditable='true'][data-tab]", timeout=300000)
            print("✅ WhatsApp is now ready.")

        # Loop through each contact and send the formatted message
        for number, data in contacts_dict.items():
            message = format_message(data)
            phone_number = number.replace("+", "").replace(" ", "")
            encoded_message = urllib.parse.quote(message)

            # Navigate to chat URL with pre-filled message
            page.goto(f"https://web.whatsapp.com/send?phone={phone_number}&text={encoded_message}")
            time.sleep(7)  # Wait for chat page to load

            try:
                # Wait for message input box to appear and then send
                page.wait_for_selector("footer div[contenteditable='true']", timeout=20000)
                page.keyboard.press("Enter")

                # ⏳ Wait to give time for message to deliver (helpful on slow networks)
                time.sleep(5)

                print(f"✅ Message sent to {number}")
            except Exception as e:
                print(f"❌ Failed to send message to {number}: {e}")

            time.sleep(3)  # Short pause before next message

        print("🎉 All messages have been processed.")
        # Optional: close browser after work is done
        # browser.close()

# Example data
contacts_dict = {
    '+92 3212425949': {
        'Customer Name': 'Kainat',
        'Branch Name': 'Johar Town',
        'Date': '2025-01-06',
        'Products Purchased': 'Chips (x5 @ Rs 50), Chocolates (x5 @ Rs 30), Cold Drinks (x5 @ Rs 100)',
        'Total Price': 900
    }
}

# Run the function
send_whatsapp_message(contacts_dict)






'''''''''''

# Database connection
conn = psycopg2.connect(
    dbname="Bizbot",
    user="postgres",
    host="localhost",
)
cursor = conn.cursor()

# Querying for contact details and sales data
cursor.execute("""
SELECT
    c.customer_name AS "Customer Name",
    c.phone AS "Customer Phone Number",
    b.branch_name AS "Branch Name",
    s."Date" AS "Date",
    STRING_AGG(p.product_name || ' (x' || s."Quantity" || ' @ ' || p.price || ')', ', ') AS "Products Purchased",
    SUM(s."Quantity" * p.price) AS "Total Price"
FROM
    sales s
JOIN
    product p ON s."Product ID" = p.product_id
JOIN
    customer c ON s.customer_id = c.customer_id
JOIN
    branch b ON s."Branch ID" = b.branch_id
GROUP BY
    c.customer_name, c.phone, b.branch_name, s."Date";
""")
sales_data = cursor.fetchall()
conn.close()
import csv

# Formatting function for the invoice
def format_invoice(data):
    return (
        f"Hello {data['Customer Name']},\n\n"
        f"Thank you for your recent purchase from BizBot!\n\n"
        f"Here are the details of your purchased items:\n{data['Products Purchased']}\n\n"
        f"Total Amount: Rs. {data['Total Price']}\n\n"
        f"We appreciate your business and hope to see you again!"
    )

# Populating sales_dict from fetched sales_data
sales_dict = {}
for row in sales_data:
    phone_number = row[1] # Assuming phone number is at index 1
    products_purchased = row[2] # Assuming products purchased is at index 2
    total_price = row[3] # Assuming total price is at index 3
    customer_name = row[0] # Assuming customer name is at index 0, based on format_invoice usage
    sales_dict[phone_number] = {
        'Customer Name': customer_name,
        'Products Purchased': products_purchased,
        'Total Price': total_price
    }

# Path for the CSV file
csv_file_path = 'customer_invoices.csv'

# Writing data to the CSV file
with open(csv_file_path, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)

    # Writing the header
    writer.writerow(['Phone Number', 'Invoice'])

    # Writing the data from the dictionary
    for number, data in sales_dict.items():
        invoice = format_invoice(data) # Calling format_invoice function
        writer.writerow([number, invoice])

print(f"Data successfully written to {csv_file_path}")
'''''''''