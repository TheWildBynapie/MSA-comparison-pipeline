import argparse
import pandas as pd


def average_dpos(input_files, output_file):
    dfs = [pd.read_csv(f) for f in input_files]
    combined = pd.concat(dfs, ignore_index=True)

    # Normalize pair order so (A,B) and (B,A) are treated as the same pair
    combined["pair"] = combined.apply(
        lambda row: tuple(sorted([row["msa_a"], row["msa_b"]])), axis=1
    )
    combined[["msa_a", "msa_b"]] = pd.DataFrame(
        combined["pair"].tolist(), index=combined.index
    )
    combined = combined.drop(columns="pair")

    n_runs = len(input_files)
    grouped = combined.groupby(["msa_a", "msa_b"])["distance"]

    averaged = grouped.mean().reset_index()
    counts = grouped.count().reset_index(name="n_observed")

    # Flag any pair that wasn't present in every run (e.g. a tool failed partway)
    missing = counts[counts["n_observed"] < n_runs]
    if not missing.empty:
        print(f"WARNING: {len(missing)} pair(s) missing from some runs:")
        print(missing.to_string(index=False))

    averaged.to_csv(output_file, index=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--inputs", nargs="+", required=True,
                         help="Multiple rusty-metal CSV files to average")
    parser.add_argument("-o", "--output", default="rusty-metal-average.csv")
    args = parser.parse_args()

    average_dpos(args.inputs, args.output)