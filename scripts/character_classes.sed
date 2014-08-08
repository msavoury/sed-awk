#This file is an example of using character classes

s/[[:lower:]]/X/

# Replaces the 3rd uppercase letter on the line with a @ symbol.
# Remember that the replacement 'X' on the previous command will
# count towards the 3 uppercase letter limit
s/[[:upper:]]/@/3
