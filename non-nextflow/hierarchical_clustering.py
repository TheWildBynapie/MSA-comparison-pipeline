import argparse
import numpy as np
import matplotlib.pyplot as plt

from scipy.cluster.hierarchy import linkage, dendrogram
from scipy.spatial.distance import squareform



def hierarchical_and_plot(distance_matrix, points):

    # Convert square distance matrix to SciPy's condensed format
    condensed_D = squareform(distance_matrix)

    # Hierarchical agglomerative clustering
    Z = linkage(
        condensed_D,
        method="average"
    )

    # Plot dendrogram
    plt.figure(figsize=(10, 6))

    dendrogram(
        Z,
        labels=points
    )   

    plt.ylabel("Distance")
    plt.tight_layout()

    plt.savefig("MSA_hierarchical.png", dpi=200)
    plt.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
    "-i", "--input",
    help="Input .npz distance matrix",
    required=True
    )
    parser.add_argument(
        "-o", "--output",
        help="Output dendrogram",
        default="MSA_dendrogram.png"
    )
    args = parser.parse_args()


    # Load distance matrix
    data = np.load(args.input)

    D = data["D"]
    points = data["points"]
    
    hierarchical(D, points)
    
    