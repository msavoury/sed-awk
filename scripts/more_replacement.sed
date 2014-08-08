#More example of pattern in replacement string
# Use on data/swap_me.txt (don't forget -r flag)

s/([^:#]*)([:#])(.*)/\3\2\1/
