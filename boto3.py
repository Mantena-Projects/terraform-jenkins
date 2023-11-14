file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines()

cleaned_ips = []

for line in lines:
    # Use strip to remove leading and trailing whitespaces
    cleaned_line = line.strip()
    #print(f"cleaned line is: '{cleaned_line}'")
    # Check if the line starts with "public_ip ="
    if cleaned_line.startswith('public_ip ='):
        # Split the line to extract the IP address
        ip_address = cleaned_line.split('"')[1]
        cleaned_ips.append(ip_address)

print("Extracted IP Addresses:")
for ip in cleaned_ips:
    print(ip)

    
