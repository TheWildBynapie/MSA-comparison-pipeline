import numpy as np
import matplotlib.pyplot as plt
from sklearn.manifold import MDS
import pandas as pd
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", help="The input csv file containing the pairwise distances between MSAs", required=False)
args = parser.parse_args()

if args.input:
    print("Input:", args.input)

# Read the CSV
if args.input:
    df = pd.read_csv(args.input)
else:
    print("No input file provided. Using default 'results/rusty-metal/rusty-metal.csv'.")
    df = pd.read_csv("results/rusty-metal/rusty-metal.csv")

# Strip everything before the final '/' from the filenames
df["msa_a"] = df["msa_a"].str.rsplit("/", n=1).str[-1].str.removesuffix(".fasta")
df["msa_b"] = df["msa_b"].str.rsplit("/", n=1).str[-1].str.removesuffix(".fasta")

# Get the complete set of MSAs
points = sorted(set(df["msa_a"]) | set(df["msa_b"]))

# Create an empty distance matrix
D = pd.DataFrame(
    0.0,
    index=points,
    columns=points
)

# Fill in the distances
for _, row in df.iterrows():
    a = row["msa_a"]
    b = row["msa_b"]
    distance = row["distance"]

    D.loc[a, b] = distance
    D.loc[b, a] = distance


# Convert pandas DataFrame to NumPy array for sklearn
D = D.to_numpy()

mds = MDS(
    n_components=2,
    metric="precomputed",
    random_state=42,
    init='classical_mds',
    max_iter=10,
)

coords = mds.fit_transform(D)
stress = mds.stress_
print(f"Stress: {stress}")


plt.scatter(coords[:, 0], coords[:, 1])

for msa, (x, y) in zip(points, coords):
    plt.annotate(msa, (x, y))

plt.savefig('MSA_distances.png', dpi=200)
plt.show()