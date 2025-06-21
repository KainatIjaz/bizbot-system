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
    '+92 3214486172': {
        'Customer Name': 'Asiya',
        'Branch Name': 'Johar Town',
        'Date': '2025-01-06',
        'Products Purchased': 'Chips (x5 @ Rs 50), Chocolates (x5 @ Rs 30), Cold Drinks (x5 @ Rs 100)',
        'Total Price': 900
    }
}

# Run the function
send_whatsapp_message(contacts_dict)