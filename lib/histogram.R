data_table = read.table( dataFile, header = T, sep = "\t", check.names = F )
legend     = colnames( data_table )
# Format data into matrix
m_data     = as.matrix( data_table )

# Get colors for plot from multiple selection
colors = valuesHIS$colors
colors = colors[1:length(legend)]

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarHIS,
		input$leftMarHIS,
		input$upperMarHIS,
		input$rightMarHIS
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Style of X axis. "r": adds 4% spacing to each side; "i": no spacing added
	yaxs    = "i", # Style of Y axis. "r": adds 4% spacing to each side; "i": no spacing added
	xpd     = NA
)

# Titles all around the plot
title   = gsub( ":n:", "\n", input$titleHIS )
y_label = gsub( ":n:", "\n", input$yLabelHIS )
x_label = gsub( ":n:", "\n", input$xLabelHIS )

border_color = NA

if( input$barBordersHIS ){
	border_color = '#000000'
}

# Get xmin and max values in both dimensions

histogram = hist(
	m_data,
	breaks = input$numBinsHIS,
	plot   = F
)

xmin = min( histogram$breaks )
xmax = max( histogram$breaks )
ymin = 0
if( input$normalizeHIS ){	
	ymax = max( histogram$density )
}else{
	ymax = max( histogram$counts )
}

if( !is.na(input$xMinHIS) ){
	xmin = input$xMinHIS
}
if( !is.na(input$xMaxHIS) ){
	xmax = input$xMaxHIS
}
if( !is.na(input$yMinHIS) ){
	ymin = input$yMinHIS
}
if( !is.na(input$yMaxHIS) ){
	ymax = input$yMaxHIS
}

# Graph histogram
par( xpd  = F )

hist(
	m_data,
	breaks   = input$numBinsHIS,
	freq     = !input$normalizeHIS,  # F: histogram has area of 1
	axes     = F,
	main     = title,
	cex.main = input$titleSizeHIS,
	col      = colors,
	border   = border_color,
	ylab     = NA,
	xlab     = NA,
	xlim     = c( xmin, xmax ),
	ylim     = c( ymin, ymax )
)

# Plot X axes
axis(
	1,
	lwd      =  input$lineWidthHIS,
	padj     =  input$xScalePosHIS,
	cex.axis =  input$scaleSizeHIS
)

# Plot Y axes
axis(
	2,
	lwd      =  input$lineWidthHIS,
#	padj     = -input$yScalePosHIS,
	las      = 2,
	cex.axis =  input$scaleSizeHIS
)

# Y-axis label
text(
	grconvertX( input$yYlabelHIS, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label,
	xpd   = NA,
	srt   = 90,
	cex   = input$yLabelSizeHIS
)

# X-axis label
text(
	grconvertX( 0.50, from = "npc", to = "user" ),
	grconvertY( input$xXlabelHIS, from = "ndc", to = "user" ),
	adj   = c(0.5,0),
	label = x_label,
	xpd   = NA,
	cex   = input$xLabelSizeHIS
)

# Add box around plot
# "o" (the default), "l", "7", "c", "u", or "]"
# "n" suppresses the box
boxtypes = c('n','o','l','7','c','u',']')
boxtype  = boxtypes[input$boxTypeHIS+1]

box(
	which = "plot",
	bty   = boxtype,
	lwd   = input$lineWidthHIS
)
