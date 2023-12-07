import numpy as np

# Specify the path to your text file
file_path = 'warm_blooded.txt'

# Read the content from the text file
with open(file_path, 'r') as file:
    # Read until the first occurrence of '//\n\n'
    content = file.read().split('//\n\n')[0]

# Ensure the content length is not greater than 20,000
content = content[:20000]

# Create a dictionary to map characters to values
char_to_value = {'a': 50, 'c': 100, 'g': 150, 't': 200}

# Convert each character to its corresponding value
sequence_values = [char_to_value[char] for char in content.lower()]

# Determine the number of rows needed in the matrix
num_rows = (len(sequence_values) + 199) // 200

# Create a matrix filled with zeros
matrix = np.zeros((num_rows, 200), dtype=int)

# Assign the sequence values to the matrix row-wise
for i in range(len(sequence_values)):
    matrix[i // 200, i % 200] = sequence_values[i]

# Print the resulting matrix
print(matrix)

# Specify the path to the output text file
output_file_path = 'output_matrix.txt'

# Save the matrix to the text file
np.savetxt(output_file_path, matrix, fmt='%d', delimiter='\t')
