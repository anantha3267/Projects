import smtplib
import ssl
from OpenSSL import crypto
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime

# Path to your certificate file
CERT_FILE = '/path/to/your/certificate.crt'

# Email settings
SENDER_EMAIL = "your-email@example.com"
SENDER_PASSWORD = "your-email-password"
RECEIVER_EMAIL = "receiver-email@example.com"
SMTP_SERVER = "smtp.example.com"
SMTP_PORT = 465  # SSL port for email

# Check certificate expiry
def get_certificate_expiry(cert_file):
    with open(cert_file, "rt") as f:
        cert_data = f.read()

    # Load certificate
    cert = crypto.load_certificate(crypto.FILETYPE_PEM, cert_data)
    
    # Get expiration date and convert to datetime
    expiration_time = cert.get_notAfter().decode("utf-8")
    expiry_date = datetime.strptime(expiration_time, "%Y%m%d%H%M%SZ")
    
    return expiry_date

# Send email notification
def send_email(subject, body):
    message = MIMEMultipart()
    message["From"] = SENDER_EMAIL
    message["To"] = RECEIVER_EMAIL
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    context = ssl.create_default_context()

    with smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT, context=context) as server:
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECEIVER_EMAIL, message.as_string())

# Main logic to check certificate expiry
def check_cert_expiry():
    expiry_date = get_certificate_expiry(CERT_FILE)
    today = datetime.utcnow()
    days_until_expiry = (expiry_date - today).days

    # If less than 30 days until expiry, send a reminder email
    if days_until_expiry < 30:
        subject = "SSL Certificate Expiry Reminder"
        body = f"Warning: SSL certificate is expiring in {days_until_expiry} days. Please renew it soon."
        send_email(subject, body)
        print(f"Reminder sent: Certificate expires in {days_until_expiry} days.")
    else:
        print(f"Certificate is valid for {days_until_expiry} more days.")

# Run the check
if __name__ == "__main__":
    check_cert_expiry()
