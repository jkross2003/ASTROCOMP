#!/bin/bash
# 1.3.1 Loop through numbers 1 to 20
for i in {1..20}
do
    # Print each number on a new line
    echo "$i"
done

# 1.3.2 Initialise an empty string to hold the numbers
numbers=""

#Loop throgh numbers 1 to 20
for i in {1..20}
do
    # Append each number followed by a space to the string
    numbers="$numbers$i "
done
# Print the final string
echo "$numbers"

# 1.3.3 Initialise an empty string to hold the numbers
numbers=""
for i in {1..20}
do
    # Format the number with leading zero and append '. ' to it
    numbers="${numbers}$(printf "%02d, " $i)"
done
# Print the final string
echo $numbers

# 1.3.4 Initialise an empty string to hold the numbers
numbers=""
# Loop through numbers 1 to 20
for i in {1..20}
do
    # If it's the last number, don't add ", "
    if [ $i -eq 20 ]; then
        numbers="${numbers}$(printf "%02d" $i)"
    else
        numbers="${numbers}$(printf "%02d, " $i)"
    fi
done
# Print the final string
echo $numbers

# 1.5.5 Loop through each item in the root directory
for item in /*
do
    # Print the item with the prefix
    echo "Listing item in root: $item"
done