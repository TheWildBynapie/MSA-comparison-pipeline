import argparse
import numpy as np
import matplotlib.pyplot as plt
from sklearn.manifold import MDS

#Function to calculate and display MDS
def mds_and_plot(distance_matrix, points):
    # Perform MDS
    mds = MDS(
        n_components=2,
        metric="precomputed",
        random_state=42,
        init="classical_mds",
        max_iter=10,
    )

    coords = mds.fit_transform(distance_matrix)

    print(f"Stress: {mds.stress_}")

    # Plot
    plt.scatter(coords[:, 0], coords[:, 1])

    for msa, (x, y) in zip(points, coords):
        plt.annotate(msa, (x, y))

    plt.savefig('MSA_distances.png', dpi=200)
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
        help="Output graph",
        default="MSA_distances.png"
    )   
    args = parser.parse_args()

    # Load distance matrix
    data = np.load(args.input)

    D = data["D"]
    points = data["points"]

    mds_and_plot(D, points)
