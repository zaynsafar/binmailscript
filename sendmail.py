import sys
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

email = 'sweetybhora@gmail.com'
password = 'sweetyjain7272'
send_to_email = 'voraagora9@gmail.com'
subject = 'My World'
message = 'Hello World'

msg = MIMEMultipart()
msg['sweetybhora@gmail.com'] = email
msg['voraagora@gmail.com'] = send_to_email
msg['My World'] = subject

msg.attach(MIMEText(message, 'plain'))

server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(email, password)
text = msg.as_string()
server.sendmail('sweetybhora@gmail.com', 'voraagora9@gmail.com', 'msg.as_string')
server.quit()
