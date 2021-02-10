## PlotsREasy
PlotsREasy allows you to obtain publication-ready plots of scientific data.  
Graphics and statistics are performed with R packages and the output is readily available to download in PDF format, which is easily imported by the most common vector-based graphics packages like Illustrator (MACOS, Windows), CorelDraw (Windows) and Inkscape (MACOS, Windows, Linux).

### Installation
To install you need to download and install Rstudio IDE:  
https://rstudio.com/products/rstudio/download  

#### Installing dependencies:

Some packages need to be installed from github and other from Bioconductor.  

```
# Install 'devtools' for github packages
install.packages('devtools')

# Install bioconductor
install.packages("BiocManager")

# Load libraries needed to install packages:
library('devtools')

devtools::install_github("kassambara/easyGgplot2")
devtools::install_github("rlbarter/superheat")
BiocManager::install("EnrichedHeatmap")
BiocManager::install("DESeq2")
install.packages('shiny')
install.packages('shiny')
install.packages('shinyjs')
install.packages('shinythemes')
install.packages('gridExtra')
install.packages('ggrepel')
install.packages('beeswarm')
install.packages('plotrix')
install.packages('wordcloud')
install.packages('methods')
install.packages('plyr')
install.packages('VennDiagram')
install.packages('cowplot')
install.packages('grid')
install.packages('ggplot2')
install.packages('gplots')
install.packages('Matrix')
```


### Recreate app.R after you make changes

If you make changes to .mod files or to the app.template file, you would need to recreate the app.R file.  
It's simple, run buildApp like this:  

```
./buildApp -t app.template -m mod_files.txt
```

mod_files.txt contains a list of the .mod files you want to include in the app.  
For example:  
```
lib/beeRandom.mod
lib/beeSwarm.mod
lib/boxPlot.mod
lib/cTree.mod
lib/corMatrix.mod
lib/heatMap.mod
lib/histogram.mod
```

This program inserts UI and SRV portions of code from the .mod files into the UIPLOT:mod and RVPLOT:mod tags in app.template.  

#### Mod files:
.mod files contain UI and SRV code corresponding to a single plot.  
The UI portion is delimited between the [START UIPLOT] and [END UIPLOT] tag lines. This means the UI code needs to start and end with those respective tags.  
The SRV portion is delimited between the [START SRVPLOT] and [END SRVPLOT] tag lines.  


### Running from Rstudio

In MAC OS, type:  
```
library('shiny')
options( browser = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome")
runApp("/Users/YOURNAME/ShinyApps/PlotsREasy/app.R", launch.browser=T )
```
This will tell Rstudio to open the app in your browser of choice, in this case: google chrome.  

###### NOTE:
File downloads don't work in Rstudio's built-in browser.  
