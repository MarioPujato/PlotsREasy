#### DATA FORMAT:
Data must be in the following format:

```
NAME	VALUE
XBP1	0
ELK1	0
AAK1	-1.0
ABCA3	1.9
AGBL5	-1.6
ATP6V	1.4
BMP2K	1.5
BMS1P4	2.6
BTBD2	-1.5
```

The file must contain a header line.  
Each field must be tab separated.  
VALUE will determine the relative size of the words in the plot.  
A negative value could indicate for example downregulation.  
A positive value could indicate for example upregulation.  
A value of zero will position the word at the center of the plot.  
The size of the words are directly proportional to the absolute value of the VALUE.    
NOTE: The first 3 given colors are used in the plot.  
The first color is used for negative values.  
The second color is used for positive values.  
The third color is used for the central word (words with VALUE=0 in the file).
