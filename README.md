# sed-awk #

Use the **-f** option to specify a file 
```sed -f scriptfile inputfile```

## Character classes: ##

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

# sed #
## Options##

**-e** - necessary when specifying more than one instruction on the command line

**-r** - allows use of extended regular expressions (|, ? , +, etc..)

**;** - separate instructions on command line ```sed 's/ MA/Mass'; s/PA/Penn'```

**-n** - is used to suppress output 

## Ranges ##
With **grep** - escape the brackets: ```grep  '10\{1,3\}1' one_zero.txt ``` 

With **egrep** - escaping is not needed: ```egrep  '10{1,3}1' one_zero.txt ```

## Line Addressing ##
Sed commands can specify zero, one or two addresses. An address can be a regex, a line number, or a line addressing symbol (e.g. ^ and $)

- No address: command applied to each line
- One address: command applied to any line that matches address
- 2 comma separated addresses: command applied to all matching lines within range (inclusive)
- If an address is followed by an exclamation point (!) command applied to all non-matching lines

Example of 2 address command
```
 sed -n '/3./,/7./s/[0-9]*/1/p' 1_to_100.txt 
```
If an address is followed by a (!) symbol, then the command will apply to all the lines that do **not** match the address

## Commands ##

### Substitution ###
The pattern for substitution is:
``` [address]s/<pattern>/<replacement>/<flags> ```

Where &lt;flags&gt; can be:
- **n** - A number (up to 512) indicating replacement occur on nth pattern
- **g** - Make changes globally 
- **p** - Print contents of pattern space 
- **w (file)** - Write contents of pattern space to file 

### Replacement characters ###
- **&** is used for the match made
- **\n** is for the nth match (based on pairs of parens in the pattern)

### Other commands ###
- List
- Transfrom
- Next

# awk #
The ```-F``` option is used to specify a different field separator

Awk variables are initialized to an empty string
