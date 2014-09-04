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


## Variables ##
###FS (Field Separator)###

The FS variable is a system variable that can be initialized to set the field separator 

Example:
```BEGIN { FS = ","} ```

If **FS** set to a string of 2 chars or more, it is interpreted as a regular expression

Example: Use either quote, colon or tab as a field delimeter
``` FS = "[':\t']"```

###OFS (Output Field Separator)###
- Separates the fields during output


###NF (number of fields for the current record)###
Example: print the number of fields in the current record
```
awk '{print NF}'
```

###RS (Record Separator)###
- default value is newline
- when this is set to "" it stands for a blank line


###ORS (Output Record Separator)###
- default value is newline

###NR###
- Number of the current record from all input

###FNR###
- Current record number relative to current file

**NOTE** :  If given more than one file argument, the NR variable will keep track of the current record over all files, (i.e. when encountering the first record of the 2nd file, the value of NR will be Total number of records in first file + 1)

###FILENAME###
- Current filename



## Operators ##
In Awk, the space is the string concatenation operator
```
Z = "hello " "world"
```

The tilde (~) operator allows for testing of a regular expression against a field

Example: print 1st and 6th fields if the 5th field matches /TU/
```
$5 ~ /TU/ { print $1, $6}
```

## Command line Arguments##
Pass arguments before the input file but after the awk script file
``` awk -f scripts/args.awk high=100 data/proc.txt```
**NOTE:** Arguments passed via the command line are **NOT** available during the BEGIN section of a script

## Programming Constructs ##

### Normal ###
- if 
- else
- else if
- ? :
- while
- for
- break
- continue

### Different ###
- in (e.g. for element IN array)
- in (testing for membership - if needle IN haystack - TESTS for the presences of the KEY only, not the value)
- split(string, array, separator)
- delete array[subscript]

### Special ###
- next
- exit (Immediately passes control to the END rule)

## Arrays ##
Arrays are one-based

## System Variables ##
- ARGV (This array is 0 based)
- ARGC
- ENVIRON

## String Functions ##

| Name                            | Description     |
| -------------                   | -------------   |
| gsub(regex,replacement,input)   | globally substitute all instances of regex with replacement in input           |
| index(needle, haystack)         | returns position of substring t in string s or zero if not present             |
| length(s)                       | returns length of string s                                                     |
| match(s,r)                      | returns either the position in s where the regex r begins or 0 if none found   |
| split(string,array,separator)   | split string into array using separator and returns the number of elements     |
| sprintf("fmt",input)            | returns printf formatfor input                                                 |
| sub(regex,replacement,input)    | substitute first instances of regex with replacement in input, return 1 if success 0 otherwise |
| substr(input,start,length  )    | return substring of input starting at start with given length                  |
| tolower(s)                      | returns s as lowercase                                                         |
| toupper(s)                      | returns s as upperrcase                                                        |

**NOTE** remember awk arrays are 1-based so returning 0 makes sense for when a substring is not found
