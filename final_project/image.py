import numpy as np
import matplotlib.pyplot as plt

# Your matrix (replace this with your actual matrix)
matrix = np.zeros((100, 200), dtype=int)

# Assuming you already have the matrix created

# Display the matrix as a grayscale image
plt.imshow(matrix, cmap='gray', interpolation='nearest')
plt.title('DNA Sequence Grayscale Image')
plt.xlabel('Column')
plt.ylabel('Row')
plt.colorbar()
plt.show()
