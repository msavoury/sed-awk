# sed-awk #

Use the -f option to specify a file 
```sed -f scriptfile inputfile```

## Character classes: ##
=================
[:alnum:] Printable chars (includes whitespace)

[:alpha:] Alphabetic chars

[:blank:] Space and tab chars

[:cntrl:] Control chars

[:digit:] Numeric chars

[:graph:] Printable and visible (non-space) chars

[:lower:] Lowercase chars

[:print:] Printable chars

[:punct:] Punctuation chars

[:space:] Whitespace chars

[:upper:] Uppercase chars

[:xdigit:] hexadecimal chars


# sed #

The ```-e``` option is only necessary when specifying more than one instruction via the command line

It's also possible to separate instructions with the use of a semicolon
```sed 's/ MA/Mass'; s/PA/Penn'```

The ```-n``` option is used to suppress the output 

## Ranges ##
With *grep* - escape the brackets: ```grep  '10\{1,3\}1' one_zero.txt ``` 

With *egrep* - escaping is not needed: ```egrep  '10{1,3}1' one_zero.txt ```


# awk #
The ```-F``` option is used to specify a different field separator

Awk variables are initialized to an empty string
