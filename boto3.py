import boto3

# Read the text file
file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines()

for line in lines:
    # Use strip to remove leading and trailing whitespaces
     original_line = line 
     cleaned_line = line.strip()
     print(f"original line is:'{original_line}'")
     print(f"cleaned line is:'{cleaned_line}'")
