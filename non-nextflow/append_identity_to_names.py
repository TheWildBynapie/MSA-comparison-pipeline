import argparse
import re
from pathlib import Path

#python3 append_identity_to_names.py /path/to/parent_dir --dry-run
def main():
    parser = argparse.ArgumentParser(
        description="Append average %identity to directory/file names across "
                     "MSA_graphs, MSA_outputs, and rusty-metal, based on each "
                     "*_average_identity.txt file in MSA_graphs."
    )
    parser.add_argument("parent_dir", help="Parent directory containing MSA_graphs, MSA_outputs, rusty-metal")
    parser.add_argument("--dry-run", action="store_true", help="Show renames without applying them")
    parser.add_argument("--dirs-only", action="store_true",
                         help="Only rename directories (skip the rusty-metal CSV and the identity .txt file itself)")
    args = parser.parse_args()

    parent = Path(args.parent_dir)
    graphs_dir = parent / "MSA_graphs"
    outputs_dir = parent / "MSA_outputs"
    rusty_dir = parent / "rusty-metal"

    identity_files = sorted(graphs_dir.glob("*_average_identity.txt"))

    if not identity_files:
        print(f"No *_average_identity.txt files found in {graphs_dir}")
        return

    for identity_file in identity_files:
        text = identity_file.read_text()
        match = re.search(r"Average identity across \d+ alignments:\s*([\d.]+)%", text)
        if not match:
            print(f"WARNING: couldn't parse identity value from {identity_file.name}, skipping")
            continue
        pct = match.group(1)

        # Strip "_average_identity.txt", then an optional trailing "_<n>seq"
        # e.g. "corglcox1_PID50to70_50seq_average_identity.txt" -> "corglcox1_PID50to70"
        base = identity_file.name.removesuffix("_average_identity.txt")
        base = re.sub(r"_\d+seq$", "", base)

        renames = []

        graph_subdir = graphs_dir / base
        if graph_subdir.is_dir():
            renames.append((graph_subdir, graphs_dir / f"{base}_{pct}"))

        output_subdir = outputs_dir / base
        if output_subdir.is_dir():
            renames.append((output_subdir, outputs_dir / f"{base}_{pct}"))

        if not args.dirs_only:
            rusty_file = rusty_dir / f"rusty_metal_{base}.csv"
            if rusty_file.exists():
                renames.append((rusty_file, rusty_dir / f"rusty_metal_{base}_{pct}.csv"))

            new_identity_name = identity_file.name.removesuffix(".txt") + f"_{pct}.txt"
            renames.append((identity_file, identity_file.with_name(new_identity_name)))

        if not renames:
            print(f"No matching items found for base '{base}' (from {identity_file.name})")

        for src, dst in renames:
            if args.dry_run:
                print(f"[dry run] {src} -> {dst}")
            else:
                print(f"{src} -> {dst}")
                src.rename(dst)


if __name__ == "__main__":
    main()
