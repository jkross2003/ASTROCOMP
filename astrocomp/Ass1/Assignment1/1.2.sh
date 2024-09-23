#!/bin/bash
# 1.2.1 Display the path to the home directory
echo "Home Directory: $HOME"
# Display user name
echo "Username: $(whoami)"

# 1.2.2 Define a variable called nonsense
nonsense='This is such a nonsense!'
# Print the content of the new variable nonsense
echo $nonsense

# 1.2.3 Redirect the content of the variable nonsense to nonsense.txt
echo $nonsense > nonsense.txt
# Print confirmation message
echo "File nonsense.txt was just created/overwritten."

# 1.2.4 Replace spaces with underscores and append to the second line of the file
echo ${nonsense// /_} >> nonsense.txt

# 1.2.5 Replace 'such a' with 'not' and add 'It's Bash' to the end
not_nonsense="${nonsense/such a/not} It's Bash"
# Append the modified string to nonsense.txt
echo $not_nonsense >> nonsense.txt

# 1.2.7 Print the home directory with all the slashes removed
echo $HOME | tr -d '/'