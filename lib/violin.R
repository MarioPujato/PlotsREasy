#===============================================================================
# PlotsREasy - VIOLIN
#===============================================================================
# Load data
#-------------------------------------------------------------------------------
write( paste("[Violin |",curDate,"|",sessionId,"] Plotting violin using file:",dataFile), file=stderr())
dataTable = read.table( dataFile, header=T, sep="\t", check.names=F )
colNames  = colnames( dataTable )

# Get colors for plot from multiple selection
colors  = valuesVIO$colors

nColors = length(colNames)
if( nColors>1 ){ colors = colorRampPalette(colors)( n=nColors ) }

# Variables
mainTitle  = gsub( ":n:", "\n", input$titleVIO )
mTitleSize = input$titleSizeVIO
#legendSize = input$legendSizeVIO
legendSize = 18
lineWidth  = input$lineWidthVIO
tickWidth  = lineWidth/1.8
labelSize  = input$labelSizeVIO
scaleSize  = input$scaleSizeVIO
axisFace   = input$axisFaceVIO
upMar      = 0.2
ymin       = 0
#ymax       = max(current_gene_data)

# Formatting data
write( paste("[Violin |",curDate,"|",sessionId,"]   Formatting  data for violin"), file=stderr())
vData  = c()
vNames = c()
for( i in 1:length(colNames) ){
	vData  = c( vData,  dataTable[,i] )
	vNames = c( vNames, colNames[i] )
}
vData = data.frame( values=vData, group=as.character(vNames) )


# Drawing violin
#write( paste("[Violin |",curDate,"|",sessionId,"]   Generating violin plot"), file=stderr())
violin = ggplot( vData, aes( x=group, y=values, fill=group, color=group ) ) +
geom_violin( scale='width', na.rm=T, trim=F ) +
#scale_fill_brewer(palette="Dark2") +
scale_fill_manual(  values=colors ) +
scale_color_manual( values=colors ) +
ggtitle( mainTitle ) +
theme(
#	legend.title      = element_blank(),
#	panel.background  = element_blank(),
#	axis.line.x       = element_line( size=lineWidth, color="black", lineend="square" ),
#	axis.text.x       = element_text( size=scaleSize, face="plain" ),
#	plot.title        = element_text( size=mTitleSize, face="bold",  hjust=0.5 ),
#	axis.title.x      = element_text( size=labelSize,   face="plain", hjust=0.5 ),
#	axis.title.y      = element_text( size=labelSize,   face="plain", hjust=0.5 ),
#	plot.margin       = unit( c(upMar,0.1,0.1,0.1), "in" )

#	axis.text.x       = element_text( angle=90, vjust=0.5, hjust=1 ),
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
#
#	# Toggle Y axis ON/OFF
#	if( toggleYaxis ){
#		violin = violin +
#		theme(
#			axis.ticks.length = unit( tickWidth/7, "cm" ),
#			axis.ticks.x      = element_line( size=tickWidth ),
#			axis.ticks.y      = element_line( size=tickWidth ),
#			axis.line.y       = element_line( size=lineWidth, color="black", lineend="square" ),
#			axis.text.y       = element_text( size=scaleSize, face='plain' )
#		)
#	}else{
#		violin = violin +
#		theme(
#			axis.ticks  = element_blank(),
#			axis.line.y = element_blank(),
#			axis.text.y = element_blank()
#		)
#	}
#
#	if( splitSample ){
#		violin = violin +
#		scale_fill_manual( values=splitColors )
#	}else{
#		violin = violin +
#		scale_fill_manual( values=c(clustColors,clustColors) )
#
#		# Color individual clusters with different color 
#		if( colorByCluster ){
#			g = g +
#			geom_violin( scale='width', mapping=aes( fill=scData$cluster ) )
#		}
#	}
#
#
print(violin)
write( paste("[Violin |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
