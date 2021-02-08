#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[Heatmap |",curDate,"|",sessionId,"] Plotting heatmap using file:",dataFile), file=stderr())

table = read.table( dataFile, header=T, sep="\t", check.names=F, blank.lines.skip=T, row.names=1 )
mData = as.matrix(table[rowSums(table[-1] != table[[1]], na.rm = TRUE) != 0,])

# Linear scaling function
rescaleRow = function( x, minRes=0, maxRes=1 ){
	minVal = min( x )
	maxVal = max( x )
	(maxRes - minRes) * (x - minVal) / (maxVal - minVal) + minRes
}

# Row normalized using z-scores
if( input$trZscoreHTM ){
	mData = t(scale(t(mData)))
}
# Row normalized using linear scaling from min to max
if( input$trLScaleHTM ){
	mData = t(apply( mData, 1, rescaleRow, minRes=input$minResHTM, maxRes=input$maxResHTM ))
}
# Not row-normalized log transformation
if( input$logScaleHTM ){
	mData = log( mData+1, input$logBaseHTM )
}
#mData      = apply(mData,2,rev)
#mData = t(scale( t(mData) ))
x_names    = colnames( mData )
y_names    = rownames( mData )

numRows = length(y_names)
numCols = length(x_names)

write( paste("[Heatmap |",curDate,"|",sessionId,"] Number of rows in matrix:",   numRows), file=stderr())
write( paste("[Heatmap |",curDate,"|",sessionId,"] Number of columns in matrix:",numCols), file=stderr())

# Get colors for plot from multiple selection
colors = valuesHTM$colors

# Last color reserved for grid color
gridColor = tail(colors,1)
colors    = colors[-length(colors)]

# Set min and max of scale
options(scipen=0)
minValue  = min(mData)
maxValue  = max(mData)
if( !is.na(input$minValueHTM) ){ minValue = input$minValueHTM }
if( !is.na(input$maxValueHTM) ){ maxValue = input$maxValueHTM }

midValue  = minValue + (maxValue-minValue) / 2
legBreaks = c( minValue, midValue, maxValue )

# Make min and max values symmetric
if( input$legSymmHTM ){
	maxValue = round( max(c(abs(minValue),abs(maxValue))), digits=2 )
	minValue = round( -maxValue, digits=2 )
}

# Activate X or Y labels
rowLabel = "none"
colLabel = "none"
if( input$labRowSwitchHTM ){ rowLabel = NULL }
if( input$labColSwitchHTM ){ colLabel = NULL }
# Label font sizes
colLabelSize  = input$xLabelSizeHTM
rowLabelSize  = input$yLabelSizeHTM
colLabelSpace = input$xLabelSpaceHTM
rowLabelSpace = input$yLabelSpaceHTM
if( is.na(input$xLabelSizeHTM) || input$xLabelSizeHTM <= 0 ){ colLabelSize = 15 }
if( is.na(input$xLabelSizeHTM) || input$yLabelSizeHTM <= 0 ){ colLabelSize = 15 }

# Main title of plot
title = gsub( ":n:", "\n", input$titleHTM )

# Add numbers within cells
cellData = NULL
if( input$cellDataHTM ){ cellData = mData }
rowOrder = rev(seq(1:length(y_names)))
if( input$rowDendroHTM || input$rowReorderHTM ){ rowOrder = NULL }

m = min(mData)
M = max(mData)

heatPalValues = NULL
#if( input$linearColorScaleHTM ){ heatPalValues = c(m,(M-m)/2+m,M) }
if( input$linearColorScaleHTM ){ heatPalValues = c(0,0.5,1) }
write( paste("[Heatmap]:",heatPalValues), file=stderr())
write( paste("[Heatmap] colors:",colors), file=stderr())

# Draw heatmap
superheat(
	mData,
	padding = 0.3,
	# Main title
	title             = title,
	title.size        = input$titleSizeHTM,
	# Add number within cells
	X.text            = cellData,
	# Color palette
	heat.pal          = colors,
	heat.pal.values   = heatPalValues,
	# Dendrogrtams and reordering
	pretty.order.rows = input$rowReorderHTM,
	pretty.order.cols = input$colReorderHTM,
	row.dendrogram    = input$rowDendroHTM,
	col.dendrogram    = input$colDendroHTM,
	order.rows        = rowOrder,
	# Grid lines in heatmap
	grid.hline.col    = gridColor,
	grid.vline.col    = gridColor,
	grid.hline.size   = input$gridHWidthHTM,
	grid.vline.size   = input$gridVWidthHTM,
	# Add min and max values (if values are <min or >max the boxes are greyed out)
	heat.lim = c(minValue, maxValue),
	# Left labels
	left.label                  = rowLabel,
	left.label.size             = rowLabelSpace,
	left.label.text.size        = rowLabelSize,
	left.label.col              = "white",
	left.label.text.alignment   = "right",
	force.left.label            = T,
	# Bottom labels
	bottom.label                = colLabel,
	bottom.label.size           = colLabelSpace,
	bottom.label.text.size      = colLabelSize,
	bottom.label.col            = "white",
	bottom.label.text.alignment = "right",
	bottom.label.text.angle     = 90,
	force.bottom.label          = T,
	# Legend
#	heat.pal.values  = c(midValue-abs(maxValue-minValue)/3,midValue+abs(maxValue-minValue)/3),
#	legend.breaks    = legBreaks,
	legend.vspace    = 0.01,
	legend.height    = input$legHeightHTM,
	legend.width     = input$legWidthHTM,
	legend.text.size = input$legSizeHTM
)

write( paste("[Heatmap |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr())
