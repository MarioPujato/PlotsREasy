#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# CORRELATION MATRIX plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

# Get colors for plot from multiple selection
colors  = valuesCOR$colors

write( paste("[COR |",curDate,"|",sessionId,"] Computing correlation matrix"), file=stderr() )
readCounts = as.matrix( read.delim( dataFile, row.names=1, header=T, check.names=F ))
#write( paste("[HERE] ",readCounts), file=stderr() )
corMatrix  = cor( readCounts, method="pearson", use="complete.obs" )

#heatmap( x=corMatrix, col=colors, symm=T, show_heatmap_legend=T )
#legend( x="bottom", legend=c("0", "0.5", "1"), fill=colorRampPalette(colors)(250) )

# Add numbers within cells
cellData = NULL
if( input$cellDataCOR ){ cellData = round(corMatrix,2) }
rowLabelSpace = input$rowLabelSpaceCOR
colLabelSpace = input$colLabelSpaceCOR
rowLabelSize  = input$rowLabelSizeCOR
colLabelSize  = input$colLabelSizeCOR
cellTextSize  = input$cellTextSizeCOR

# Draw heatmap
superheat(
	corMatrix,
	padding = 0.3,
	# Main title
	title             = NULL,
	# Add number within cells
	X.text            = cellData,
	X.text.size       = cellTextSize,
	# Color palette
	heat.pal          = colors,
	# Dendrogrtams and reordering
	pretty.order.rows = T,
	pretty.order.cols = T,
	row.dendrogram    = T,
	col.dendrogram    = T,
	# Grid lines in heatmap
	grid.hline.col    = "#FFFFFF",
	grid.vline.col    = "#FFFFFF",
	grid.hline.size   = 0,
	grid.vline.size   = 0,
	# Left labels
#	left.label                  = rowLabel,
	left.label.size             = rowLabelSpace,
	left.label.text.size        = rowLabelSize,
	left.label.col              = "white",
	left.label.text.alignment   = "right",
	force.left.label            = T,
	# Bottom labels
#	bottom.label                = colLabel,
	bottom.label.size           = colLabelSpace,
	bottom.label.text.size      = colLabelSize,
	bottom.label.col            = "white",
	bottom.label.text.alignment = "right",
	bottom.label.text.angle     = 90,
	force.bottom.label          = T,
	# Legend
	heat.lim          = c(-1,1),
	heat.pal.values  = c(0,0.5,1),
	legend.breaks    = c(-1,0,1)
#	legend.vspace    = 0.01,
#	legend.height    = input$legHeightHTM,
#	legend.width     = input$legWidthHTM,
#	legend.text.size = input$legSizeHTM
)

write( paste("[COR |",curDate,"|",sessionId,"] DONE"), file=stderr() )
