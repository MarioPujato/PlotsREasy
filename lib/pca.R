#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# PCA plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

# Get colors for plot from multiple selection
colors = valuesPCA$colors

readCounts = as.matrix( read.delim( dataFile, row.names=1, header=T, check.names=F ))
numSamples = ncol(readCounts)
sampleNums = paste( seq( from=1, to=numSamples, by=1 ), collapse="," )
sampleText = paste( colnames(readCounts), collapse="\n" )
expGroups  = factor( unlist( strsplit( input$groupsPCA, split = "," )))

if( numSamples != length(expGroups) ){
	write( paste("[PCA |",curDate,"|",sessionId,"] ERROR: Groups do not match number of samples"), file=stderr() )
	pca = ggplot() +
	theme_void() +
	ggtitle( paste("Please match the number of samples (",numSamples,") in the \"Groups\" option\n\nExample: ",sampleNums,"\n\nSample names:\n",sampleText, sep='') ) +
	theme(
		panel.background  = element_blank(),
		plot.title        = element_text( size=16, face='plain', hjust=0.5 ),
		plot.margin       = unit( c(1,0.1,0.1,0.1), "in" )
	)

}else{
	colData = data.frame( row.names=colnames(readCounts), condition=expGroups )
	nTop    = input$nTopVarPCA

	if( input$deseq2PCA ){
		ddsMatrix  = DESeqDataSetFromMatrix( countData=readCounts, colData=colData, design=~condition )

		# Running DESeq2 and get normalized values
		write( paste("[PCA |",curDate,"|",sessionId,"] Running DESeq2"), file=stderr() )

		# Running DESeq2 and get normalized values
		bigSampleLimit = 1
		if( length(expGroups)>=bigSampleLimit ){
			write( paste("[PCA | ",curDate,"|",sessionId," ] Using vst transformation", sep=''), file=stderr() )
			dataRle = varianceStabilizingTransformation( ddsMatrix, blind = TRUE )
		}else{
			write( paste("[PCA | ",curDate,"|",sessionId," ] Using rlog transformation", sep=''), file=stderr() )
			dataRle = rlog( ddsMatrix, blind = TRUE )
		}
		dataRle = rlog( ddsMatrix, blind = TRUE )
		rVars   = rowVars( assay(dataRle) )
		select  = order( rVars, decreasing=TRUE )[seq_len(min(nTop,length(rVars)))]
		dataPca = prcomp( t(assay(dataRle)[select,]), center=TRUE )
	}else{
		dataRle = readCounts
		rVars   = rowVars( dataRle )
		select  = order( rVars, decreasing=TRUE )[seq_len(min(nTop,length(rVars)))]
		dataPca = prcomp( t(dataRle[select,]), center=TRUE )
	}
	summary  = summary( dataPca )
	write( paste("[runPCA |",curDate,"|",sessionId,"] DONE"), file=stderr() )

	percPC1 = summary$importance[2,1]
	percPC2 = summary$importance[2,2]

	write( paste("[runPCA |",curDate,"|",sessionId,"] Generating PCA plot"), file=stderr() )
	percentVar  = round( 100 * c(percPC1,percPC2) )

	x_data = as.vector(dataPca$x[,1])
	y_data = as.vector(dataPca$x[,2])
	c_data = paste("SG",expGroups, sep='' )
	l_data = rownames(dataPca$x)
	legend = unique( c_data )
	rows   = length(subset( c_data, c_data==1))
	cols   = length(unique(c_data))
#	ymin   = min(y_data)
#	ymax   = max(y_data)
#	yrange = abs(ymax-ymin)
#	ytotal = (percPC1/percPC2+1)*yrange
#	yhigh  = ymax + (ytotal-yrange)/2
#	ylow   = ymin - (ytotal-yrange)/2

	# Get colors for plot
	uniqGroups = unique( expGroups )
	#colors     = c( '#571845', '#C70039', '#FF5733', '#FFC300' )
	cmax       = length(uniqGroups)
	palette    = colorRampPalette( colors ) ( n = cmax )

	pcaData = data.frame( X=x_data, Y=y_data, Groups=c_data, Labels=l_data )

	# Main title
	mTitle     = gsub( ":n:", "\n", input$titlePCA )
	mTitleSize = input$titleSizePCA
	legendSize = input$legendSizePCA
	labelSize  = input$labelSizePCA
	scaleSize  = input$scaleSizePCA
	textSize   = input$textSizePCA/3
	lineWidth  = 4
	tickWidth  = lineWidth / 1.8

	pca = ggplot( pcaData, aes( X, Y, color=Groups ) ) +
	geom_point( size=8 ) +
	scale_color_manual( values=palette ) +
	geom_text_repel( aes( label=Labels ), colour="black", size=textSize ) +
	scale_fill_discrete( name=NULL, breaks=c_data, labels=c_data ) +
	labs(
		title = mTitle,
		x     = paste("PC1 (",percentVar[1],"% variation)", sep=''),
		y     = paste("PC2 (",percentVar[2],"% variation)", sep='')
	) +
	#theme_classic() +
	geom_vline( xintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +
	geom_hline( yintercept=0, linetype=2, size=lineWidth/4, color="grey50" )

	# Scale Y axis to show range proportional to PC2's percent variation
	if( input$scaleYPCA ){
		ymin   = min(y_data)
		ymax   = max(y_data)
		yrange = abs(ymax-ymin)
		ytotal = (percPC1/percPC2+1)*yrange
		yhigh  = ymax + (ytotal-yrange)/2
		ylow   = ymin - (ytotal-yrange)/2

		pca = pca +
		ylim(ylow,yhigh)
	}

	# Control theme variables
	pca = pca +
	theme(
		legend.title      = element_text( size=legendSize*1.2 ),
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
}

print(pca)
