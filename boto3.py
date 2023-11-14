import re

file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines()

pattern = re.compile(r'^public_ip\d* = "(.*)"$')

# Create a list to store matched IP addresses
matched_ips = []

# Iterate through the lines and match the pattern
for line in lines:
    match = pattern.match(line.strip())
    if match:
        # Access the matched IP address using group(1)
        ip_address = match.group(1)
        matched_ips.append(ip_address)

# Now, matched_ips contains the extracted IP addresses
print("Matched IP Addresses:")
for ip in matched_ips:
    print(ip)
