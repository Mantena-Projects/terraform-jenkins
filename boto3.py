import boto3

# Read the text file
file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines()

for line in lines:
    # Use strip to remove leading and trailing whitespaces
     original_line = line 
     cleaned_line = line.strip()
     print(original_line)
     print(cleaned_line)
