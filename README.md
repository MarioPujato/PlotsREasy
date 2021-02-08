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
