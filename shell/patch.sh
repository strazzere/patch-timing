#!/bin/bash
start_time=$(date +%s%N)

offset=$((0x200))
patched_file="randomblock"
bytes=$'\xd1\xff\xd1\xff'

echo -ne "$bytes" | dd of="$patched_file" bs=1 seek=$offset conv=notrunc status=noxfer

end_time=$(date +%s%N) 

elapsed_time=$((end_time - start_time))
elapsed_time_us=$((elapsed_time / 1000))

echo "Time taken: ${elapsed_time_us}µs"