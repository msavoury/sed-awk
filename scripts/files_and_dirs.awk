#Quick script that determines the number of files vs the number of directories in an 
# ls -l output

/^-/ {
#	print $9 " is a file"
	++files
}
/^d/ {
#	print $9 " is a directory"
	++dirs
}

END { print "There are " files " files and " dirs " directories"}
