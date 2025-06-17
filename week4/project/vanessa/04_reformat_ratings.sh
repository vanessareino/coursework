#!/bin/bash
 
# Set start and end timestamps in milliseconds
start_milli=1611360000000  # Jan 23, 2021 00:00:00 UTC
end_milli=1627775999000    # July 31, 2021 23:59:59 UTC
 
# Directory paths
zip_dir="C:\Users\ds3\Desktop\coursework\week4\project\vanessa\data"  # Update with the correct path to your zip files
output_dir="filtered_data"  # Directory to store filtered files
mkdir -p "$output_dir"  # Create the output directory if it doesn't exist
 
# Loop through ratings files, extract and filter by createdAtMillis (column 3)
for i in $(seq -w 0 19); do
    unzip -p "$zip_dir/ratings-000${i}.zip" | awk -F'\t' -v min="$start_milli" -v max="$end_milli" \
    'NR == 1 || ($3 >= min && $3 <= max)' > "$output_dir/filtered_ratings_${i}.tsv"
done
 
# Merge filtered files, keeping the header from the first file only
head -n 1 "$output_dir/filtered_ratings_00.tsv" > complete_filtered_ratings.tsv
for i in $(seq -w 0 9); do
    tail -n +2 "$output_dir/filtered_ratings_0${i}.tsv" >> complete_filtered_ratings.tsv
done
 
echo "Merging complete. Final file: complete_filtered_ratings.tsv"
 