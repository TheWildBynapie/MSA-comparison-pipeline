import argparse
import numpy as np
import matplotlib.pyplot as plt
from sklearn.manifold import MDS

#Function to calculate and display MDS
def mds_and_plot(distance_matrix, points, output_file='MSA_distances.png',
                  output_file_nolines='MSA_distances_nolines.png'):
    # Perform MDS
    mds = MDS(
        n_components=2,
        metric="precomputed",
        random_state=42,
        init="classical_mds",
        max_iter=10,
    )

    coords = mds.fit_transform(distance_matrix)
    stress = mds.stress_

    # Plot setup
    plt.figure(figsize=(10, 8))

    # Plot points
    plt.scatter(coords[:, 0], coords[:, 1], zorder=3)

    # Annotate point labels
    for msa, (x, y) in zip(points, coords):
        plt.annotate(msa, (x, y), textcoords="offset points", xytext=(0, 5), ha='center', zorder=4)

    # Save the no-lines version first, before any distance lines are added
    plt.savefig(output_file_nolines, dpi=200, bbox_inches='tight')

    # Draw edges to the 3 closest points based on original distance matrix D
    for i, (x, y) in enumerate(coords):
        # Get distances from point i to all other points, sort them, and pick top 3 (skip index 0 which is self)
        closest_indices = np.argsort(distance_matrix[i])[1:4]

        for j in closest_indices:
            x_near, y_near = coords[j]
            dist_val = distance_matrix[i][j]

            # Draw a light dashed line between the points
            plt.plot([x, x_near], [y, y_near], 'k--', alpha=0.2, linewidth=1)

            # Optional: Add distance label near the midpoint of the line
            plt.text(
                (x + x_near) / 2, (y + y_near) / 2,
                f"{dist_val:.3f}",
                fontsize=7, color='blue', alpha=0.7,
                ha='center', va='center'
            )

    plt.savefig(output_file, dpi=200, bbox_inches='tight')
    plt.close()

    return stress


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
    parser.add_argument(
        "-on", "--output-nolines",
        help="Output graph without distance lines",
        default="MSA_distances_nolines.png"
    )
    args = parser.parse_args()

    # Load distance matrix
    data = np.load(args.input)

    D = data["D"]
    points = data["points"]

    mds_and_plot(D, points, output_file=args.output, output_file_nolines=args.output_nolines)