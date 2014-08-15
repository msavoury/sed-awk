# sed-awk #
A github repo for the purpose of learning more of these 2 unix utilities

Use the **-f** option to specify a file 
```sed -f scriptfile inputfile```

# sed #
## Options##

**-e** - Use to specify multiple instructions on the command line

```sed -e 's/line/loan/' -e 's/word/wizard/' data/the_times.txt```

**-r** - allows use of extended regular expressions (|, ? , +, etc..)

**;** - separate instructions on command line ```sed 's/ MA/Mass; s/PA/Penn'```

**-n** - use to suppress output 

## Line Addressing ##
Sed commands can specify zero, one or two addresses. An address can be a regex, a line number, or a line addressing symbol (e.g. ^ and $)

- No address: command applied to each line
- One address: command applied to any line that matches address
- 2 comma separated addresses: command applied to all matching lines within range (inclusive)
- If an address is followed by an exclamation point (!) command applied to all non-matching lines

Example: Match (and print) the 3rd line
```
sed -n '3 p' data/the_times.txt
```

Example of a 2-address command
```
 sed -n '/3./,/7./s/[0-9]*/1/p' 1_to_100.txt 
```
If an address is followed by a (!) symbol, then the command will apply to all the lines that do **not** match the address

## Commands ##

### Substitution (s) ###
Syntax: 
``` [address]s/<pattern>/<replacement>/<flags> ```

Where &lt;flags&gt; can be:
- **n** - A number (up to 512) indicating replacement occur on nth pattern
- **g** - Make changes globally 
- **p** - Print contents of pattern space 
- **w (file)** - Write contents of pattern space to file 

#### Replacement characters ####
- **&** is used for the match made
- **\n** is for the nth match (based on pairs of parens in the pattern)

### Delete (d) ###
Takes an address and deletes pattern space if line matches address

Example: delete all lines that start with capital 'T'
```
sed '/^T/d' data/the_times.txt
```

### Append (a) / Change (c) / Insert (i) ###
- Each of these commands requires a backslash following it to escape the first end-of-line. Text must begin on the next line

Example: Prepend each line with an asterisk
```
sed '/^/i\
*' data/the_times.txt

```

### List (l) ###
Use to print non-printing characters as ASCII codes
- Tip: Use -n to suppress normal output
```
sed -n l data/*
```

### Transform (y) ###
Use to transform characters of one set to characters of a second set

- Tip: The length of both sets must be equal
Example: Change each letter 'a' to a '1' and each 'b' to a '2'
```
sed 'y/ab/12/' data/the_times.txt
```

### Next (n) ###
Reads the content of the pattern space then reads next line of input w/o returning to the top of the script
- Tip: This command is normally used in combination with other commands in a script

### Print (p) and Line Number (=)
The p command will print the matched line
- Tip: Use the p command when suppressing output to print matched lines 

Example: Print the first line twice (once as normal output, once for matching first line)
```
sed '1 p' data/the_times.txt
```
The (=) command prints the line number of the matched line

Example: Print line numbers of lines containing the word 'match'
```
sed '/match/=' data/the_times.txt
```

## Grouping Commands ##
Use curly brackets to group commands for a matched line
```
/This/{
    s/^Th/h/
    =   
    y/o/e/
}
```

## Misc ##
### Character classes: ###

| Character Class  | Purpose |
| ------------- | ------------- |
|[:alnum:]  | Printable chars |
|[:alnum:]| Printable chars (includes whitespace)|
|[:alpha:]| Alphabetic chars|
|[:blank:]| Space and tab chars|
|[:cntrl:]| Control chars|
|[:digit:]| Numeric chars|
|[:graph:]| Printable and visible (non-space) chars|
|[:lower:]| Lowercase chars|
|[:print:]| Printable chars|
|[:punct:]| Punctuation chars|
|[:space:]| Whitespace chars|
|[:upper:]| Uppercase chars|
|[:xdigit:]| hexadecimal chars|

**Example usage:** ``` sed 's/[[:lower:]]/X/' the_times.txt ```


# awk #
The ```-F``` option is used to specify a different field separator

Example: Use the colon as a field separator
```
awk -F: -f scripts/print_second.awk data/colon_data.txt
```

Awk variables are initialized to an empty string

BEGIN

The BEGIN pattern specifies actions that will be taken before the first line of input is read

The END pattern specifies actions that will be taken after the last line of input is read

``` awk 'BEGIN {print "This will be the first line"} {print $0} END {print "This will be printed last"}' data/list ```

FS

The FS variable is a system variable that can be initialized to set the field separator 

```BEGIN { FS = ","} ```


The tilde (~) operator allows for testing of a regular expression against a field

Example: print 1st and 6th fields if the 5th field matches /TU/
```
$5 ~ /TU/ { print $1, $6}
```
