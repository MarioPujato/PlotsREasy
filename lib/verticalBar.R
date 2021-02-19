dataTable = read.table( dataFile, header=T, sep="\t", check.names=F )
header    = colnames(dataTable)

# Create factors in dataframe to keep order of labels
dataTable[,1] = factor( dataTable[,1], levels=unique(dataTable[,1]) )
dataTable[,2] = factor( dataTable[,2], levels=unique(dataTable[,2]) )

# Main title and axis labels
mTitle     = gsub( ":n:", "\n", input$titleBAR )
mTitleSize = input$titleSizeBAR
legendSize = input$legendSizeBAR
labelSize  = input$labelSizeBAR
scaleSize  = input$scaleSizeBAR
groupSpace = input$groupSpaceBAR
barSpace   = input$barSpaceBAR
barWidth   = 1-barSpace
lineWidth  = input$lineWidthBAR
xAngle     = input$xAngleBAR
tickWidth  = lineWidth / 1.8
xVar       = input$xVarBAR
yVar       = input$yVarBAR
gVar       = input$gVarBAR

# Get colors for plot from multiple selection
colors  = valuesBAR$colors
nColors = length(unique(dataTable[,gVar]))
colors  = colorRampPalette(colors)( n=nColors )

bar = ggplot( data=dataTable, aes_string( x=xVar, y=yVar, fill=gVar ) ) +
labs( title=mTitle )

if( input$stackColumnsBAR ){
	if( input$normStackBAR ){
		bar = bar +
		geom_bar( stat="identity", position=position_fill(), width=barWidth ) +
		labs( y="frequency" )
	}else{
		bar = bar +
		geom_bar( stat="identity", width=barWidth )
	}
}else{
	bar = bar +
	geom_bar( stat="identity", position=position_dodge(width=barSpace), width=barWidth )
}

bar = bar +
scale_fill_manual( values=as.vector(colors) ) +
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

print(bar)

write( paste("[BAR |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
