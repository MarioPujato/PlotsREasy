#===============================================================================
# PlotsREasy - VIOLIN
#===============================================================================
# Load data
#-------------------------------------------------------------------------------
write( paste("[Violin |",curDate,"|",sessionId,"] Plotting violin using file:",dataFile), file=stderr())
dataTable = read.table( dataFile, header=T, sep="\t", check.names=F )
colNames  = colnames( dataTable )
write( paste("HERE!",colNames), file=stderr() )

# Create factors in dataframe to keep order of labels
dataTable[,1] = factor( dataTable[,1], levels=unique(dataTable[,1]) )
dataTable[,2] = factor( dataTable[,2], levels=unique(dataTable[,2]) )

# Variables
mTitle     = gsub( ":n:", "\n", input$titleVIO )
mTitleSize = input$titleSizeVIO
legendSize = input$legendSizeVIO
lineWidth  = input$lineWidthVIO
tickWidth  = lineWidth/1.8
labelSize  = input$labelSizeVIO
scaleSize  = input$scaleSizeVIO
xAngle     = input$xAngleVIO
xVar       = input$xVarVIO
yVar       = input$yVarVIO
gVar       = input$gVarVIO

# Get colors for plot from multiple selection
colors  = valuesVIO$colors
nColors = length(unique(dataTable[,gVar]))
colors  = colorRampPalette(colors)( n=nColors )


# Drawing violin
violin = ggplot( dataTable, aes_string( x=xVar, y=yVar, fill=gVar ) ) +
geom_violin( scale='width', na.rm=T, trim=F ) +
scale_fill_manual( values=as.vector(colors) ) +
labs( title=mTitle ) +
theme(
	axis.text.x       = element_text( angle=xAngle, vjust=0.5, hjust=1 ),
	legend.text       = element_text( size=legendSize ),
	legend.title      = element_text( size=legendSize*1.2 ),
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

if( ! input$legendSwitchVIO ){
	violin = violin +
	theme( legend.position = "none" )
}

print(violin)
write( paste("[Violin |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
