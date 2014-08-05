sed-awk
=======

Use the -f option to specify a file 
```sed -f scriptfile inputfile```

character classes:
[:alpha:]

sed
===

The ```-e``` option is only necessary when specifying more than one instruction via the command line

It's also possible to separate instructions with the use of a semicolon
```sed 's/ MA/Mass'; s/PA/Penn'```

The ```-n``` option is used to suppress the output 

awk
===
The ```-F``` option is used to specify a different field separator

Awk variables are initialized to an empty string
