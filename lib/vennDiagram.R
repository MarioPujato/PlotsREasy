#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# VENN DIAGRAM plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
futile.logger::flog.threshold(futile.logger::ERROR, name = "VennDiagramLogger")

# Get colors for plot from multiple selection
colors = valuesVEN$colors

write( paste("[VEN |",curDate,"|",sessionId,"] Plotting venn diagram using file:",dataFile), file=stderr() )

dataTable = read.table(
	dataFile,
	header = TRUE,
	sep    = "\t"
)
numSets = ncol(dataTable)
# Vector of labels
myNames = colnames(dataTable)
# List of vectors
myList  = list()
for( i in seq( from=1, to=numSets, by=1 ) ){
	myList[[i]] = as.vector( dataTable[,i] )
}

# Variables
labelPos   = input$labelPosVEN
mainTitle  = input$titleVEN
titleSize  = input$titleSizeVEN
legendSize = input$legendSizeVEN/10
numberSize = input$numberSizeVEN/10
dist1      = input$distance1VEN
dist2      = -input$distance2VEN

if( is.null(legendSize) ){ legendSize=2 }
if( is.null(numberSize) ){ numberSize=3 }
if( is.null(titleSize)  ){ titleSize=3  }
if( is.null(labelPos)   ){ labelPos=3   }
if( is.null(dist1)      ){ dist1=0.05   }
if( is.null(dist2)      ){ dist1=-0.05  }

# Get colors
myColors=colorRampPalette(colors)(n=numSets)

# Vector of label positions
positions = c(-labelPos,labelPos,180-labelPos,180+labelPos)
myPos     = positions[1:numSets]

# Vector of label distances
distances = c(dist1,dist1,dist2,dist2)
myDist    = distances[1:numSets]
#myDist    = rep(0.05, numSets)[1:numSets]

# Generate plot
#-------------------------------------------------------------------------------
write( paste("[VEN |",curDate,"|",sessionId,"] generating venn diagram"), file=stderr() )

venn = venn.diagram(
	myList,
	category.names  = myNames,
	na              = "remove",
	filename        = NULL,
	lty             = 'blank',
	fill            = myColors,
	fontfamily      = "sans",
	cat.fontfamily  = "sans",
	cex             = numberSize,
	cat.cex         = legendSize,
	cat.fontface    = "bold",
	cat.default.pos = "outer",
	cat.pos         = myPos,
	cat.dist        = myDist
)

main = textGrob( mainTitle, gp=gpar(fontsize=titleSize/10, font=3) )
grid.arrange(
	gTree(children=venn),
	top = textGrob( mainTitle, gp=gpar(fontsize=titleSize, fontface='bold') )
)
write( paste("[VEN |",curDate,"|",sessionId,"] DONE"), file=stderr() )
