import argparse
import csv
from Bio import SeqIO

def filter_fasta_by_blast(csv_file, min_id, max_id, min_cov, max_cov, query_length):
    # Infer FASTA filename from CSV base name (e.g., "results.csv" -> "results.fasta")
    base_name = csv_file.rsplit('.', 1)[0]
    fasta_file = f"{base_name}.fasta"
    output_file = f"{base_name}_filtered.fasta"

    # 1. Collect valid accession IDs based on criteria
    valid_ids = set()
    print(f"Reading {csv_file} and applying filters...")
    
    with open(csv_file, mode="r") as infile:
        reader = csv.reader(infile)
        for row in reader:
            # Adjust column indices based on your BLAST CSV output format:
            # Typically: [0] Accession/Subject ID, [2] % Identity, [3] Alignment Length
            try:
                accession = row[1]
                percent_identity = float(row[2])
                alignment_length = float(row[3])
            except (ValueError, IndexError):
                continue  # Skip header rows or malformed lines

            # Approximate query coverage
            coverage = (alignment_length / query_length) * 100.0

            # Check if values fall within specified ranges
            if (min_id <= percent_identity <= max_id) and (min_cov <= coverage <= max_cov):
                valid_ids.add(accession)

    print(f"Found {len(valid_ids)} sequences matching criteria. Filtering {fasta_file}...")

    # 2. Stream through FASTA and write out matching records
    filtered_records = []
    for record in SeqIO.parse(fasta_file, "fasta"):
        # Match against record id or description depending on how headers are formatted
        if record.id in valid_ids or any(acc in record.description for acc in valid_ids):
            filtered_records.append(record)

    SeqIO.write(filtered_records, output_file, "fasta")
    print(f"Successfully wrote {len(filtered_records)} sequences to {output_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Filter FASTA sequences using a BLAST CSV hit table.")
    parser.add_argument("-i", "--csv", required=True, help="Input BLAST CSV hit table file")
    parser.add_argument("-mid", "--min-id", type=float, default=0.0, help="Minimum percent identity")
    parser.add_argument("-mad", "--max-id", type=float, default=100.0, help="Maximum percent identity")
    parser.add_argument("-mic", "--min-cov", type=float, default=0.0, help="Minimum query coverage percentage (0-100)")
    parser.add_argument("-mac", "--max-cov", type=float, default=100.0, help="Maximum query coverage percentage (0-100)")
    parser.add_argument("-qlen", "--qlen", type=float, required=True, help="Query sequence length in amino acids/nucleotides")

    args = parser.parse_args()

    filter_fasta_by_blast(
        csv_file=args.csv,
        min_id=args.min_id,
        max_id=args.max_id,
        min_cov=args.min_cov,
        max_cov=args.max_cov,
        query_length=args.qlen
    )
    
#python non-nextflow/filter_fasta.py -i data/cox1/ricecox1blastp5000eukaOnly.csv -mid 50.0 -mad 60.0 -mic 50.0 -qlen 525