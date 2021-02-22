#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# HIS plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

write( paste("[HIS |",curDate,"|",sessionId,"] Scatter plot"), file=stderr() )

dataTable = read.delim( dataFile, header=T, check.names=F )
header    = colnames(dataTable) 
gVar      = header[1]
xVar      = header[2]

# Get colors for plot from multiple selection
colors     = valuesHIS$colors
# Get colors for plot (last colors is for linear regression)
nColors    = length(unique(dataTable[,gVar]))
palette    = colorRampPalette( colors )( n=nColors )

# Main title and axis labels
mTitle     = gsub( ":n:", "\n", input$titleHIS )
xLabel     = gsub( ":n:", "\n", input$xLabelHIS )
yLabel     = gsub( ":n:", "\n", input$yLabelHIS )
mTitleSize = input$titleSizeHIS
legendSize = input$legendSizeHIS
labelSize  = input$labelSizeHIS
scaleSize  = input$scaleSizeHIS
textSize   = input$textSizeHIS/3
lineWidth  = input$lineWidthHIS
tickWidth  = lineWidth / 1.8
colorAlpha = input$alphaHIS
barBorder  = input$barBordersHIS
binWidth   = input$binWidthHIS

# Histogram with or without bar borders
if( input$barBordersHIS ){
	hist = ggplot( dataTable, aes_string( x=xVar, fill=gVar, color=gVar ))
}else{
	hist = ggplot( dataTable, aes_string( x=xVar, fill=gVar ))
}

hist = hist +
geom_histogram( aes( y=..density.. ), binwidth=binWidth, position="identity" ) +
scale_color_manual( values=palette ) +
scale_fill_manual( values=alpha(palette,colorAlpha) ) +
labs(
	title = mTitle
)

# Add lines
#geom_vline( xintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +
#geom_hline( yintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +

# Density area
if( input$densityHIS ){
	hist = hist +
	geom_density(alpha=colorAlpha*2/3)
}

# Legend
if( input$showLegendHIS ){
	hist = hist +
	theme(
		legend.position = "right",
		legend.title    = element_text( size=legendSize*1.2 )
	)
}else{
	hist = hist +
	theme(
		legend.position ="none",
		legend.title    = element_blank()
	)
}

# Add theme
hist = hist +
theme(
#	axis.text.x       = element_text( angle=90, vjust=0.5, hjust=1 ),
	legend.text       = element_text( size=legendSize ),
	legend.background = element_blank(),
	legend.key        = element_blank(),
	panel.background  = element_blank(),
	axis.text         = element_text( size=scaleSize, face=1, hjust=0.5 ),
	plot.title        = element_text( size=mTitleSize, face=2, hjust=0.5 ),
	axis.title        = element_text( size=labelSize,  face=1, hjust=0.5 ),
	panel.border      = element_rect( size=lineWidth, color="black", fill="transparent" ),
	axis.ticks.length = unit( tickWidth/8, "cm" ),
	axis.ticks        = element_line( size=tickWidth ),
	plot.margin       = unit( c(0.2,0.1,0.1,0.1), "in" )
)

print(hist)

write( paste("[HIS |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
