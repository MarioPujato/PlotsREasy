data_table = read.table( dataFile, header = T, sep = "\t", check.names = F )

# Extract data
x_data  = as.vector( data_table[,1] )
ncol1   = 2
y_error = 0

if( input$errorSwitchSCA ){
	# Extract data with error bars
	ncol2   = ncol( data_table ) / 2 + 1
	ncol3   = ncol2 + 1
	ncol4   = ncol( data_table ) + 1
	y_data  = as.matrix( data_table[,ncol1:ncol2] )
	y_error = as.matrix( data_table[,ncol3:ncol4] )
	legend  = colnames( y_data )
}else{
	# Extract data without error bars
	ncol2   = ncol( data_table )
	y_data  = as.matrix( data_table[,ncol1:ncol2] )
	legend  = colnames( y_data )
}

# Get colors for plot from multiple selection
colors = valuesSCA$colors

nColors = length(legend)
if( nColors>1 ){ colors = colorRampPalette(colors)( n=nColors ) }

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarSCA,
		input$leftMarSCA,
		input$upperMarSCA,
		input$rightMarSCA
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Removes the 4% space added to each side of x axis
	yaxs    = "i", # Removes the 4% space added to each side of y axis
	xlog    = TRUE,
	ylog    = TRUE,
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
title   = gsub( ":n:", "\n", input$titleSCA )
y_label = gsub( ":n:", "\n", input$yLabelSCA )
x_label = gsub( ":n:", "\n", input$xLabelSCA )

# Symbol type (1:open circle, 0:open square, 19:filled circle, 15:filled square)
symbols = c(input$symbolTypeSCA)
if( input$seqSymbolsSCA ){ symbols = seq(input$symbolTypeSCA,25,1) }
# Line types
lines = c(input$lineTypeSCA)
if( input$seqLinesSCA ){ lines = seq(input$lineTypeSCA,6,1) }

# Set plot limits (defaults to min and max values of X and Y axis)
xmin   = min( x_data, na.rm = T )
xmax   = max( x_data, na.rm = T )
ymin   = min( y_data - y_error, na.rm = T )
ymax   = max( y_data + y_error, na.rm = T )

# Add 5% of the range to each side in both dimensions
xrange = xmax - xmin
yrange = ymax - ymin
xmin   = xmin - xrange * 0.05
xmax   = xmax + xrange * 0.05
ymin   = ymin - yrange * 0.05
ymax   = ymax + yrange * 0.05

# Set min and max values from the web form
if( !is.na(input$xMinSCA) ){ xmin = input$xMinSCA }
if( !is.na(input$xMaxSCA) ){ xmax = input$xMaxSCA }
if( !is.na(input$yMinSCA) ){ ymin = input$yMinSCA }
if( !is.na(input$yMaxSCA) ){ ymax = input$yMaxSCA }

par( xpd = F )

logScale = ""
if( input$yLogSCA ){ logScale = "y" }
if( input$xLogSCA ){ logScale = "x" }
if( input$yLogSCA & input$xLogSCA ){ logScale = "xy" }

# Graph multiple line and/or symbol scatter plot
matplot(
	x_data,
	y_data,
	col       = colors, # Line and symbol colors
	axes      = F,
	main      = title,
	type      = types[input$plotTypeSCA],
	pch       = symbols,
	lty       = lines,
	lwd       = input$line2WidthSCA,
	cex       = input$symbolSizeSCA,
	cex.main  = input$titleSizeSCA,
	xlab      = NA,
	ylab      = NA,
	log       = logScale,
	xlim      = c( xmin, xmax ),
	ylim      = c( ymin, ymax )
)

par( xpd = F )

# Plot axes

# X axis
axis(
	1,
	lwd      = input$line1WidthSCA,
	padj     = input$xScalePosSCA,
	cex.axis = input$scaleSizeSCA
)
# Y axis
axis(
	2,
	lwd      =  input$line1WidthSCA,
#	padj     = -input$yScalePosSCA,
	las      = 2,
	cex.axis =  input$scaleSizeSCA
)

par( xpd = NA )

# X-axis labels
text(
	grconvertX( 0.50, from = "npc", to = "user" ),
	grconvertY( input$xXlabelSCA, from = "ndc", to = "user" ),
	adj   = c(0.5,0),
	label = x_label,
	srt   = 0,
	cex   = input$xLabelSizeSCA
)

# Y-axis label
text(
	grconvertX( input$yYlabelSCA, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label,
	srt   = 90,
	cex   = input$yLabelSizeSCA
)

# Add box around plot
# "o" (the default), "l", "7", "c", "u", or "]"
# "n" suppresses the box
boxtypes = c('n','o','l','7','c','u',']')
boxtype  = boxtypes[input$boxTypeSCA+1]

if( input$boxSwitchSCA ){
	box(
		which = 'plot',
		bty   = boxtype,
		lwd   = input$line1WidthSCA
	)
}

# Error bars
if( input$errorSwitchSCA ){
	arrows(
		x_data,
		y_data + y_error,
		x_data,
		y_data - y_error,
		angle  = 90,
		code   = 3,
		length = input$errorLengthSCA,
		lwd    = input$errorWidthSCA
	)
}

# Add legend to have extra control
if( input$legendSwitchSCA ){
	legend(
		grconvertX( input$xLegendSCA, from = "ndc", to = "user" ),
		grconvertY( input$yLegendSCA, from = "ndc", to = "user" ),
		legend,
		horiz     = input$legendTypeSCA, # T: horizontal, F: vertical
		fill      = colors,
		bty       = 'n',              # No box
		cex       = input$legendSizeSCA, # Text size multiplier
		x.intersp = 0.5,              # Horizontal spacing
		y.intersp = 0.9               # Vertical spacing
	)
}
