#### DATA FORMAT:
Data must be in long format:

```
group   variable value error
GROUP1  CTRL     2.9   0.2
GROUP1  CONC1    4.7   0.6
GROUP1  CONC2    1.3   0.1
GROUP2  CTRL     1.5   0.3
GROUP2  CONC1    2.9   0.4
GROUP2  CONC2    4.1   0.2
```

Each field must be tab separated and contain a header line.  
For each group, there must be an error associated to it.  
If there are no associated errors, the fields must still be present and filled
with zeroes. In any case, errors can be supressed in the parameter file.    

The first column is used to fill the X labels for each individual bar.  
The GROUP# in the header are used as group X labels. For example, GROUP1 will
be the X label of the first 3 bars (values: 2.9, 4.7 and 1.3), whereas GROUP2
will be the X label of the second 3 bars (values: 1.5, 2.9 and 4.1).
