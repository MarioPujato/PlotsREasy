#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[CTR_cTree |",curDate,"|",sessionId,"] Plotting cTree using file:",dataFile), file=stderr())

data_table = read.table( dataFile, header = T, sep = "\t", check.names = F )
p_labels   = round( -log2( data_table[,3] ) * 10 + 1, digits = 0 )
data_table$LOG2P = p_labels - min( p_labels ) + 1

# Get colors for plot from multiple selection
colors  = valuesCTR$colors

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarCTR,
		input$leftMarCTR,
		input$upperMarCTR,
		input$rightMarCTR
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Removes the 4% space added to each side of x axis
#	yaxs    = "i", # Removes the 4% space added to each side of y axis
	xpd     = NA
)

# Titles all around the plot
title   = gsub( ":n:", "\n", input$titleCTR )
y_label = gsub( ":n:", "\n", input$yLabelCTR )

range_plab = max( data_table$LOG2P ) - min( data_table$LOG2P ) + 1
palette    = colorRampPalette( colors ) ( n = range_plab )

# Add color by matching p_value
data_table$COLOR = unlist(palette[data_table$LOG2P])

gray = "#D0D0D0"

# Beeswarm parameters
methods = c('swarm','center','hex','square')

# Graph multiple line and/or symbol scatter plot using beeswarm package
bee  = beeswarm(
	data_table[,2],
	pch      = 19,
	pwcol    = data_table$COLOR, # Line and symbol color
	axes     = F,
	yaxt     = "n",
	method   = methods[input$methodCTR],
	priority = "random",
	cex      = input$symbolSizeCTR,    # Symbol size
	main     = title,
	cex.main = input$titleSizeCTR,
	xpd      = F
)

# Plot axes
# Y-axis
axis(
	2,
	lwd      =  input$lineWidthCTR,
	las      = 2,
	cex.axis =  input$scaleSizeCTR
)

# Y-axis label
text(
	grconvertX( input$yYlabelCTR, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label,
	srt   = 90,
	cex   = input$yLabelSizeCTR
)

# Add box around plot
# "o" (the default), "l", "7", "c", "u", or "]"
# "n" suppresses the box
boxtypes = c('n','o','l','7','c','u',']')
boxtype  = boxtypes[input$boxTypeCTR+1]

box(
	which = "plot",
	bty   = boxtype,
	lwd   = input$lineWidthCTR
)

# Wordcloud layout
text_size = 0.5
wlo = wordlayout(
	bee$x,
	bee$y,
	data_table[,1],
	cex = input$textSsizeCTR
)

text(
	wlo[,1] + wlo[,3] / 2,
	wlo[,2] + wlo[,4] / 2,
	data_table[,1],
	font = 2,
	xpd = NA,
	cex = input$textSizeCTR
)

# Add scale bar with color gradient
ymin   = par("usr")[3]
ymax   = par("usr")[4]
yrange = ymax - ymin
xmin   = 1
xmax   = max( bee$x )
xrange = xmax - xmin

grad_scale  = input$gradScaleCTR
grad_xpos   = input$gradXposCTR
grad_ypos   = input$gradYposCTR
grad_width  = grad_scale * 0.20
grad_height = grad_scale * 0.03
grad_tdist  = grad_scale * 0.01
grad_tsize  = grad_scale * 1.50

gradient.rect(
	grconvertX( input$gradXposCTR, from = "ndc", to = "user" ),
	grconvertY( input$gradYposCTR, from = "ndc", to = "user" ),
	grconvertX( input$gradXposCTR+grad_width,  from = "ndc", to = "user" ),
	grconvertY( input$gradYposCTR+grad_height, from = "ndc", to = "user" ),
	border = NA,
	col    = palette
)
pmin = min( data_table[,3] )
pmax = max( data_table[,3] )
text(
	c(
		grconvertX( input$gradXposCTR, from = "ndc", to = "user" ),
		grconvertX( input$gradXposCTR+grad_width, from = "ndc", to = "user" )
	),
	grconvertY( input$gradYposCTR-0.01, from = "ndc", to = "user" ),
	c(
		format( pmax, digits = 1 ),
		format( pmin, digits = 1 )
	), # labels
	adj = c(0.5,1),
	cex = 0.85 * grad_tsize
)
text(
	grconvertX( input$gradXposCTR+grad_width,       from = "ndc", to = "user" ),
	grconvertY( input$gradYposCTR+grad_height+0.01, from = "ndc", to = "user" ),
	"p-value range",
	adj  = c(1,0),
	cex  = grad_tsize
)

write( paste("[CTR_cTree |",curDate,"|",sessionId,"] DONE"), file=stderr())
