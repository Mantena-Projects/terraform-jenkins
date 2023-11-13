import boto3

# Read the text file
file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines()
    line=lines.strip()
    print(line)

# Iterate over lines in the file
#for line in lines:
    #print(line)
