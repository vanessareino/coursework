#!/bin/bash
 
# filter original 1gram file googlebooks-eng-all-1gram-20120701-1.gz to only lines where the ngram exactly matches a year (18xx, 19xx, or 20xx, where x is a digit)
#   decompress the first using gunzip, zless, zcat or similar
#   then filter out rows that match using grep -E, egrep, awk, or similar
#   write results to year_counts.tsv
 
#zcat birdwatch-public-data-2025-06-16-notes.gz > birdwatch-public-data-2025-06-16-notes.tsv
 
 
#!/bin/bash
 
START_MILLI=1611360000000 #jan 23 2021 12:00:00 AM
END_MILLI=1627775999000 # july 31 2021 23:59:59 PM
OUTPUT_FILE="notes.tsv"
INPUT_FILE="C:\Users\ds3\Desktop\coursework\week4\project\vanessa\data\birdwatch-public-data-2025-06-16-notes.gz"
#1627696800000
#end time gmt 1627732799000
 
#1611360000000 gmt start time
# Copy header
zcat "$INPUT_FILE" | head -n 1 > "$OUTPUT_FILE"
 
# Filter by createdAtMillis (column 3)
zcat "$INPUT_FILE" | tail -n +2 | awk -F '\t' -v min="$START_MILLI" -v max="$END_MILLI" '{if ($3 >= min && $3 <= max) print $0;}' >> "$OUTPUT_FILE"