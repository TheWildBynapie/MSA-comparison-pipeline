import numpy as np
import matplotlib.pyplot as plt
from sklearn.manifold import MDS
import pandas as pd
import argparse

#My modules
import mds, hierarchical_clustering

#Args
parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", help="The input csv file containing the pairwise distances between MSAs", required=False)
parser.add_argument("-n", "--np_intermediate", action="store_true", help="Creates a numpy .npz file with the distance matrix and points list, instead of running all graphs", required=False)
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

# Get the set of MSAs
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

# Convert pandas DataFrame to NumPy array for sklearn MDS, and scipy hierarchical clustering
D = D.to_numpy()

#If using the npz intermediate, create that
if args.np_intermediate:
    # Store matrix and labels together
    np.savez(
        "MSA_distances.npz",
        D=D,
        points=np.array(points)
    )
    print(f"Distance matrix saved to MSA_distances.npz")

#If doing everything in one go, do that
else:
    mds.mds_and_plot(D, points)
    hierarchical_clustering.hierarchical_and_plot(D, points)
    