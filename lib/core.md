#### COLOR FILE:
The colors must be specified in #HEX format (one per line)  
The format looks like the following example:

```
Red       #9F252C
Whitish   #FFFCF5
Yellow    #FBBC22
LightBlue #BED4EC
```

The first field contains a name and the second the hex code.  
The columns must be TAB-separated.  
Colors are used from top to bottom. To ingnore any color, just add a '#' at the
beginning of the line.    
  
#### TITLES AND LABELS:
New line characters within titles and labels can be added by introducing the
sequence :n: in the desired position. For example, 'X:n:label' will be printed
in the plot as:

```
  X
label
```
