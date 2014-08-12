#This file demonstrates grouping commands for one line
# as well as the insert and append commands

# Wrap each line within a --- heading 
/^.*$/{ i\
---
a\
---
}
