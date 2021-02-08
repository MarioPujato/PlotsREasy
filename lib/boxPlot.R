write( paste("[BOX |",curDate,"|",sessionId,"] Plotting boxplot using file:",dataFile), file=stderr())

dataTable = read.table( dataFile, header=T, sep="\t", check.names=F )
header    = colnames( dataTable )

# Shiny variables
mTitle     = gsub( ":n:", "\n", input$titleBOX )
whiskers   = input$whiskersBOX
mTitleSize = input$titleSizeBOX
lineWidth  = input$lineWidthBOX
tickWidth  = lineWidth / 1.8
notch      = input$notchBOX
labelSize  = input$labelSizeBOX
legendSize = input$legendSizeBOX
scaleSize  = input$scaleSizeBOX
xAngle     = input$xAngleBOX
xVar       = input$xVarBOX
yVar       = input$yVarBOX
gVar       = input$gVarBOX

# Get colors for plot from multiple selection
colors  = valuesBOX$colors
nColors = length(unique(dataTable[,gVar]))
colors  = colorRampPalette(colors)( n=nColors )

box = ggplot( data=dataTable, aes_string( x=xVar, y=yVar, fill=gVar) ) +
labs( title=mTitle ) +
scale_fill_manual( values=as.vector(colors) ) +
geom_boxplot( position=position_dodge(1) )

box = box +
theme(
	legend.title      = element_text( size=legendSize*1.2 ),
	legend.text       = element_text( size=legendSize ),
	legend.background = element_blank(),
	legend.key        = element_blank(),
	panel.background  = element_blank(),
	axis.text         = element_text( size=scaleSize, face=1, hjust=0.5 ),
	plot.title        = element_text( size=mTitleSize, face=2, hjust=0.5 ),
	axis.title        = element_text( size=labelSize,  face=1, hjust=0.5 ),
	axis.text.x       = element_text( angle=xAngle, hjust=1, vjust=0.5 ),
	panel.border      = element_rect( size=lineWidth, color="black", fill="transparent" ),
	axis.ticks.length = unit( tickWidth/8, "cm" ),
	axis.ticks        = element_line( size=tickWidth ),
	plot.margin       = unit( c(0.2,0.1,0.1,0.1), "in" )
)

print(box)
write( paste("[BOX |",curDate,"|",sessionId,"] DONE"), file=stderr())
