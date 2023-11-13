import boto3

# Read the text file
file_path = 'output.txt'  # Replace with your file path
with open(file_path, 'r') as file:
    lines = file.readlines().strip()
    print(lines)

# Iterate over lines in the file
#for line in lines:
    #valid_line = line.strip() 
    #print(valid_line)
