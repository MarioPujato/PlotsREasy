#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[BRN_beeRandom |",curDate,"|",sessionId,"] Plotting beeRandom using file:",dataFile), file=stderr())

set.seed(5)
y_data = as.matrix( read.table( dataFile, header = T, sep = "\t", check.names = F ))
labels = colnames( y_data )

# Color transparency
trCode = c( "00", "03", "05", "08", "0A", "0D", "0F", "12", "14", "17", "1A", "1C", "1F", "21", "24", "26", "29", "2B", "2E", "30", "33", "36", "38", "3B", "3D", "40", "42", "45", "47", "4A", "4D", "4F", "52", "54", "57", "59", "5C", "5E", "61", "63", "66", "69", "6B", "6E", "70", "73", "75", "78", "7A", "7D", "80", "82", "85", "87", "8A", "8C", "8F", "91", "94", "96", "99", "9C", "9E", "A1", "A3", "A6", "A8", "AB", "AD", "B0", "B3", "B5", "B8", "BA", "BD", "BF", "C2", "C4", "C7", "C9", "CC", "CF", "D1", "D4", "D6", "D9", "DB", "DE", "E0", "E3", "E6", "E8", "EB", "ED", "F0", "F2", "F5", "F7", "FA", "FC", "FF" )

# Get transparency code based on picked number
trPick = trCode[input$trPickBRN + 1]

# Get colors for plot from multiple selection
colors  = valuesBRN$colors

nColors = length(labels)
if( nColors>1 ){ colors = colorRampPalette(colors)( n=nColors ) }

# Add transparency to colors
colors = paste0( colors, trPick )

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarBRN,
		input$leftMarBRN,
		input$upperMarBRN,
		input$rightMarBRN
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Removes the 4% space added to each side of x axis
	yaxs    = "i", # Removes the 4% space added to each side of y axis
	xpd     = NA
)

## Scatter plot parameters
# 1: "p" for points
# 2: "l" for lines
# 3: "b" for both points and lines
# 4: "c" for empty points joined by lines
# 5: "o" for overplotted points and lines
# 6: "s" and "S" for stair steps
# 7: "h" for histogram-like vertical lines
types = c('p','l','b','c','o','s','h')

# Titles all around the plot
title   = gsub( ":n:", "\n", input$titleBRN )
y_label = gsub( ":n:", "\n", input$yLabelBRN )
x_label = gsub( ":n:", "\n", input$xLabelBRN )

par( xpd = F )

# Generate x values randomly from a normal distribution for each y_data column
sdval     = input$distWidthBRN
x_data    = rnorm( nrow( y_data ), mean = 1, sd = sdval )
tickmarks = c(1)

for( i in 2:ncol( y_data )-1 ){
	x_data    = cbind( x_data, rnorm( nrow( y_data ), mean = i+1, sd = sdval ) )
	tickmarks = cbind( tickmarks, i+1 )
}

# Set plot limits (defaults to min and max values of X and Y axis)
xmin   = min( x_data, na.rm = T )
xmax   = max( x_data, na.rm = T )
ymin   = min( y_data, na.rm = T )
ymax   = max( y_data, na.rm = T )
write( paste("here:",xmin,xmax,ymin,ymax), file=stderr())

# Add 5% of the range to each side in both dimensions
xrange = xmax - xmin
yrange = ymax - ymin
xmin   = xmin - xrange * 0.05
xmax   = xmax + xrange * 0.05
ymin   = ymin - yrange * 0.05
ymax   = ymax + yrange * 0.05

if( !is.na(input$xMinBRN) ){
	xmin = input$xMinBRN
}
if( !is.na(input$xMaxBRN) ){
	xmax = input$xMaxBRN
}
if( !is.na(input$yMinBRN) ){
	ymin = input$yMinBRN
}
if( !is.na(input$yMaxBRN) ){
	ymax = input$yMaxBRN
}

# Graph multiple line and/or symbol scatter plot
matplot(
	x_data,
	y_data,
	col       = 'NA',
	bg        = colors, # Line and symbol colors
	axes      = F,
	main      = title,
	type      = 'p',
	pch       = 21,
	cex       = input$symbolSizeBRN,
	cex.main  = input$titleSizeBRN,
	xlab      = NA,
	ylab      = NA,
	xlim      = c(xmin, xmax),
	ylim      = c(ymin, ymax)
)

par( xpd = NA )

# Plot axes
# X axis
axis(
	1,
	lwd      =  input$lineWidthBRN,
	labels   = F,
	cex.axis =  input$scaleSizeBRN
)
# Y axis
axis(
	2,
	lwd      =  input$lineWidthBRN,
	las      = 2,
	cex.axis =  input$scaleSizeBRN
)

# X-axis labels (from data header)
xlab_pos_usr = grconvertY( input$xXlabelBRN, from = "ndc", to = "user" )
# horizontal adj
y_adj = 0.5
x_adj = 0

# Vertical adj
if( input$xLabDirBRN == 90 ){
	y_adj = 1
	x_adj = 0.5

	if( xlab_pos_usr > ymin ){
		y_adj = 0
	}
}
xlab_adj = c(y_adj,x_adj)

x_scale = seq( 1, ncol(x_data), by = 1 )
text(
	x_scale,
	xlab_pos_usr,
	adj   = xlab_adj,
	label = labels,
	srt   = input$xLabDirBRN,
	cex   = input$xLabelSizeBRN
)

# X-axis label
#text(
#	grconvertX( 0.50, from = "npc", to = "user" ),
#	grconvertY( input$xXlabelBRN, from = "ndc", to = "user" ),
#	adj   = c(0.5,0),
#	label = x_label,
#	srt   = 0,
#	cex   = input$xLabelSizeBRN
#)

# Y-axis label
text(
	grconvertX( input$yYlabelBRN, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label,
	srt   = 90,
	cex   = input$yLabelSizeBRN
)

# Add box around plot
# "o" (the default), "l", "7", "c", "u", or "]"
# "n" suppresses the box
boxtypes = c('n','o','l','7','c','u',']')
boxtype  = boxtypes[input$boxTypeBRN+1]

if( input$boxSwitchBRN ){
	box(
		which = "plot",
		bty   = boxtype,
		lwd   = input$lineWidthBRN
	)
}

par( xpd = F )

# Add horizontal line to plot
if( input$switchLineBRN ){
	abline(
		h    = input$linePositionBRN,
		lwd  = input$line2WidthBRN, # Line width
		lty  = input$lineTypeBRN    # Line type
	)
}

write( paste("[BRN_beeRandom |",curDate,"|",sessionId,"] DONE"), file=stderr())
