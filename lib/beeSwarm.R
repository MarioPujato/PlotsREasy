#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[BeeSwarm |",curDate,"|",sessionId,"] Plotting beeSwarm using file:",dataFile), file=stderr())

data_table = read.table( dataFile, header = T, sep = "\t", check.names = F )
x_label1   = colnames( data_table )
x_label1   = gsub( ":n:", "\n", x_label1 )
legend     = x_label1
# Format data into matrix
m_data     = as.matrix( data_table )

# Get colors for plot from multiple selection
colors  = valuesBSW$colors

nColors = length(legend)
colors  = colorRampPalette(colors)( n=nColors )

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarBSW,
		input$leftMarBSW,
		input$upperMarBSW,
		input$rightMarBSW
	),
	bg      = 'transparent',
	lheight = 0.8, # Inter-line spacing
	xaxs    = "i", # Removes the 4% space added to each side of x axis
	yaxs    = "i", # Removes the 4% space added to each side of y axis
	ljoin   = 1,   # Square lines
	lend    = 2    # Square ends in lines
)

# Titles all around the plot
title    = gsub( ":n:", "\n", input$titleBSW )
y_label  = gsub( ":n:", "\n", input$yLabelBSW )
x_label2 = gsub( ":n:", "\n", input$xLabelBSW )

# Symbol type (1:open circle, 0:open square, 19:filled circle, 15:filled square)
symbols = c(input$symbolTypeBSW)
if( input$seqSymbolsBSW ){
	symbols = seq(input$symbolTypeBSW,25,1)
}

# Set plot limits (defaults to min and max values of X and Y axis)
ymin = min( m_data, na.rm = T )
ymax = max( m_data, na.rm = T )

if( !is.na(input$yMinBSW) ){
	ymin = input$yMinBSW
}
if( !is.na(input$yMaxBSW) ){
	ymax = input$yMaxBSW
}

# Draw Beeswarm plot
# Beeswarm parameters
methods = c('swarm','center','hex','square')

# Graph multiple line and/or symbol scatter plot using beeswarm package
beeswarm(
	data_table,       # It only accepts a dataframe
	main     = title,
	cex.main = input$titleSizeBSW,
	col      = colors, # Line and symbol colors
	yaxt     = 'n',
	xaxt     = 'n',
	method   = methods[input$methodTypeBSW],
	pch      = symbols,
	cex      = input$symbolSizeBSW,
	ylab     = NA,
	xlab     = NA,
	bty      = "n",
	ylim     = c( ymin, ymax )
)

# Draw box plot on top
par( new = T )
boxPlot  = as.integer(input$boxBSW)
whiskers = as.integer(input$whiskersBSW)

boxp = boxplot(
	data_table,
#	col       = "#FFFFFF", # Line and symbol colors
	axes      = F,
	boxlty    = boxPlot,
	whisklty  = whiskers,
	staplelty = whiskers,
	notch     = input$notchBSW,
	outline   = F,      # No outliers
#	pch       = 19,     # Symbol type (1:open circle, 0:open square, 19:filled circle, 15:filled square)
#	lty       = 1,      # Line type
	lwd       = input$lineWidthBSW / 2, # Line width
#	cex       = 1.0,    # Symbol size
	ylim      = c( ymin, ymax ),
	ylab      = NA
)

par( xpd = NA )

# Y axis
axis(
	2,
	lwd      =  input$lineWidthBSW,
#	padj     = -input$yScalePosBSW,
	las      = 2,
	cex.axis =  input$scaleSizeBSW
)

# X-axis label 1
xlab_pos_usr = grconvertY( input$xXlabel1BSW, from = "ndc", to = "user" )
# horizontal adj
y_adj = 0.5
x_adj = 1

# Vertical adj
if( input$xLabDirBSW == 90 ){
	y_adj = 1
	x_adj = 0.5

	if( xlab_pos_usr > ymin ){
		y_adj = 0
	}
}
xlab_adj = c(y_adj,x_adj)

x_scale = seq( 1, ncol(m_data), by = 1 )
text(
	x_scale,
	xlab_pos_usr,
	adj   = xlab_adj,
	label = x_label1,
	srt   = input$xLabDirBSW,
	cex   = input$xLabelSizeBSW
)

# X-axis label 2
x_label2 = gsub( ":n:", "\n", input$xLabelBSW )
text(
	grconvertX( 0.50, from = "npc", to = "user" ),
	grconvertY( input$xXlabel2BSW, from = "ndc", to = "user" ),
	adj   = c(0.5,0),
	label = x_label2,
	srt   = 0,
	cex   = input$xLabelSizeBSW
)

# Y-axis label
text(
	grconvertX( input$yYlabelBSW, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label,
	srt   = 90,
	cex   = input$yLabelSizeBSW
)

# Add mean values as squares
#par( new = T )

# Calculate means
#x_data = c()
#y_data = c()

#for( i in 1:ncol( m_data )){
#	x_data = c( x_data, i )
#	y_data = c( y_data, mean( m_data[,i] ))
#}

# Graph multiple line and/or symbol scatter plot
#plot(
#	x_data,
#	y_data,
#	col = '#0B1C29',
#	axes = T,
#	main = NA,
#	type = 'p',
#	pch  = 15,
#	cex  = input$meanSizeBSW,
#	xlab = NA,
#	ylab = NA,
#)

# Add legend to have extra control
if( input$legendSwitchBSW ){
	legend(
		grconvertX( input$xLegendBSW, from = "ndc", to = "user" ),
		grconvertY( input$yLegendBSW, from = "ndc", to = "user" ),
		legend,
		horiz     = input$legendTypeBSW, # T: horizontal, F: vertical
		fill      = colors,
		bty       = 'n',              # No box
		cex       = input$legendSizeBSW, # Text size multiplier
		x.intersp = 0.5,              # Horizontal spacing
		y.intersp = 0.9               # Vertical spacing
	)
}

# Add box around plot
if( input$boxSwitchBSW ){
	# "o" (the default), "l", "7", "c", "u", or "]"
	# "n" suppresses the box
	boxtypes = c('n','o','l','7','c','u',']')
	boxtype  = boxtypes[input$boxTypeBSW+1]

	box(
		which = "plot",
		bty   = boxtype,
		lwd   = input$lineWidthBSW
	)
}

write( paste("[BeeSwarm |",curDate,"|",sessionId,"] DONE"), file=stderr())
