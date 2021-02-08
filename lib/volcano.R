#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Plotting volcano using file:",dataFile), file=stderr())

# Load data
iData = read.table( dataFile, header = T, sep = "\t", check.names = F )

# Get colors for plot from multiple selection
colors  = valuesVLC$colors

write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Colors:",colors), file=stderr())

# Cutoffs
lfcCutoff  = input$lfcCutoffVLC # Left  (negative)
rfcCutoff  = input$rfcCutoffVLC # Right (positive)
fdrCutoff  = input$fdrCutoffVLC
lfcCutoffH = input$lfcCutoffHVLC # Left  (negative)
rfcCutoffH = input$rfcCutoffHVLC # Right (positive)
fdrCutoffH = input$fdrCutoffHVLC

write( paste("[VLC_volcano |",curDate,"|",sessionId,"] logFC cutoff:",lfcCutoff,"and",rfcCutoff), file=stderr())

# Apply FDR saturation to values
if( !is.na(input$fdrSaturationVLC) && input$fdrSaturationVLC > 0 ){
	fdrSat = input$fdrSaturationVLC
	iData[,3][iData[,3]>fdrSat] <- fdrSat
	write( paste("[VLC_volcano |",curDate,"|",sessionId,"] FDR saturation applied:",fdrSat), file=stderr())
}

# Main title
mTitle     = gsub( ":n:", "\n", input$titleVLC )
mTitleSize = input$titleSizeVLC
# Y label
yLabel     = gsub( ":n:", "\n", input$yLabelVLC )
if( yLabel == "" ){ yLabel = '-log10(FDR)' }
# X label
xLabel     = gsub( ":n:", "\n", input$xLabelVLC )
if( xLabel == "" ){ xLabel = 'log2(Fold Change)' }
labelSize  = input$labelSizeVLC

# Find min and max Lof2FC
xmin = min( as.numeric( iData[,2] ))
xmax = max( as.numeric( iData[,2] ))
ymin = min( as.numeric( iData[,3] ))
ymax = max( as.numeric( iData[,3] ))

# Set plot limits (defaults to min and max values of X and Y axis)
if( !is.na(input$xMinVLC) ){ xmin = input$xMinVLC }
if( !is.na(input$xMaxVLC) ){ xmax = input$xMaxVLC }
if( !is.na(input$yMinVLC) ){ ymin = input$yMinVLC }
if( !is.na(input$yMaxVLC) ){ ymax = input$yMaxVLC }

# Scale text and line
sSize     = input$scaleSizeVLC
lineWidth = input$lineWidthVLC
tickWidth = lineWidth / 1.8

# Symbol size
symbolSize = input$symbolSizeVLC

# Highlight genes
hGenes  = input$hGenesVLC
hpSize  = input$hPointSizeVLC
hLabels = input$hLabelsVLC
hlSize  = input$hLabelSizeVLC

#library('stringr')
# Gene list from text area for highlighting
geneStr  = input$lGenesVLC
geneStr  = gsub( "\\s+", " ", geneStr, perl=T )
geneStr  = gsub( "\\,+", ",", geneStr, perl=T )
geneList = unlist(strsplit( geneStr, "\\,| " ))

# Gene list from selection for highlighting
geneList = unique(c( geneList, input$geneNamesVLC ))
#geneList = input$geneNamesVLC
#write( paste("GENES:",geneList), file=stderr())

# Apply cutoffs to data
write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Apply highlight cutoffs:",fdrCutoff,"+",lfcCutoff,"+",rfcCutoff), file=stderr())
lData = iData[iData[,3]>=fdrCutoff & iData[,2]<=lfcCutoff,]
rData = iData[iData[,3]>=fdrCutoff & iData[,2]>=rfcCutoff,]
gData = iData[iData[,3]<fdrCutoff  | iData[,2]<rfcCutoff | iData[,2]>lfcCutoff,]

# Start plot
#-------------------------------------------------------------------------------
write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Start plot"), file=stderr())
volcano = ggplot( gData, aes(x=gData[,2], y=gData[,3]) ) +
	geom_point( col=colors[1], size=symbolSize ) +
	xlim(xmin, xmax) +
	ylim(ymin, ymax) +
	ggtitle( mTitle ) +
	xlab( xLabel ) +
	ylab( yLabel ) +
	geom_vline( xintercept=lfcCutoff, linetype=2, size=lineWidth/4 ) +
	geom_vline( xintercept=rfcCutoff, linetype=2, size=lineWidth/4 ) +
	geom_hline( yintercept=fdrCutoff, linetype=2, size=lineWidth/4) +
	theme(
		panel.background  = element_blank(),
		axis.text         = element_text( size=sSize,      face=1, hjust=0.5 ),
		plot.title        = element_text( size=mTitleSize, face=2, hjust=0.5 ),
		axis.title        = element_text( size=labelSize,  face=1, hjust=0.5 ),
		panel.border      = element_rect( size=lineWidth,  color="black", fill="transparent" ),
		axis.ticks.length = unit( tickWidth/8, "cm" ),
		axis.ticks        = element_line( size=tickWidth ),
		plot.margin       = unit( c(0.1,0.1,0.1,0.1), "in" )
	)

# Highlight points with first color
write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Highliting points with first color"), file=stderr())
volcano = volcano +
	geom_point( data=lData, aes(x=lData[,2], y=lData[,3]), col=colors[2], size=hpSize ) +
	geom_point( data=rData, aes(x=rData[,2], y=rData[,3]), col=colors[2], size=hpSize )

# Highlight points with second color (for labeling)
if( hGenes ){
	write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Highliting points for labeling"), file=stderr())
	lDataH = iData[iData[,3]>=fdrCutoffH & iData[,2]<=lfcCutoffH,]
	rDataH = iData[iData[,3]>=fdrCutoffH & iData[,2]>=rfcCutoffH,]
	if( exists("geneList") && length(geneList) > 0 ){
#		write( paste("[VLC_volcano |",curDate,"|",sessionId,"]   Using gene list:",geneList), file=stderr())
		lDataH = iData[iData[,2]<=0 & iData[,1] %in% geneList,]
		rDataH = iData[iData[,2]>0  & iData[,1] %in% geneList,]
	}else{
		write( paste("[VLC_volcano |",curDate,"|",sessionId,"]   Using cutoffs:",fdrCutoffH,"+",lfcCutoffH,"+",rfcCutoffH), file=stderr())
	}

	# Highlight points
	volcano = volcano +
		geom_point( data=lDataH, aes(x=lDataH[,2], y=lDataH[,3]), col=colors[3], size=hpSize ) +
		geom_point( data=rDataH, aes(x=rDataH[,2], y=rDataH[,3]), col=colors[3], size=hpSize )

	# Label highlighted points
	if( hLabels ){
		numHGenes = 100
		lNudgeX   = 1
		rNudgeX   = 1
		if( !is.na(input$lNudgeXVLC) ){ lNudgeX = input$lNudgeXVLC }
		if( !is.na(input$rNudgeXVLC) ){ rNudgeX = input$rNudgeXVLC }
		lMin      = min(lDataH[,2],0)
		rMax      = max(rDataH[,2],0)
		numPoints = length(lDataH[,2]) + length(rDataH[,2])

		if( numPoints <= numHGenes ){
			write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Label highlighted points"), file=stderr())
			volcano = volcano +
				geom_text_repel( data=lDataH, aes(x=lDataH[,2], y=lDataH[,3], label=lDataH[,1]),
					nudge_x       = lMin - lNudgeX - lDataH[,2],
					direction     = "y",
					segment.color = colors[3],
					segment.size  = 0.2,
					hjust         = 1,
					size          = hlSize
				) +
				geom_text_repel( data=rDataH, aes(x=rDataH[,2], y=rDataH[,3], label=rDataH[,1]),
					nudge_x       = (rMax + rNudgeX) - rDataH[,2],
					direction     = "y",
					segment.color = colors[3],
					segment.size  = 0.2,
					hjust         = 0,
					size          = hlSize
				)
		}else{
			write( paste("[VLC_volcano |",curDate,"|",sessionId,"] Too many points to highlight:",numPoints), file=stderr())
		}
	}
}

# Print plot
print(volcano)
