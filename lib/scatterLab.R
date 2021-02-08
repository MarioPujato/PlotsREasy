#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# SCL plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

write( paste("[SCL |",curDate,"|",sessionId,"] ScatterLab plot"), file=stderr() )

inData     = read.delim( dataFile, row.names=1, header=T, check.names=F )
numSamples = ncol(inData)
cData      = factor( tail( colnames(inData), -1 ))

# Label points from text area
lString1  = input$lList1SCL
lString1  = unlist(strsplit( lString1, "\\,| |\\n", perl=T ))
# Create search string
search    = paste("(?<![\\w-])(",paste(lString1, collapse="|"),")(?![\\w-])", sep="")
# Search string in genes database
lList1  = c()
if( !grepl("\\(\\)", search) ){ lList1 = grep( search, rownames(inData), ignore.case=T, perl=T, value=T ) }
lNames1 = inData[lList1,]
lNames1 = data.frame( X=lNames1[,1], Y=lNames1[,2] )

lString2  = input$lList2SCL
lString2  = unlist(strsplit( lString2, "\\,| |\\n", perl=T ))
# Create search string
search    = paste("(?<![\\w-])(",paste(lString2, collapse="|"),")(?![\\w-])", sep="")
# Search string in genes database
lList2  = c()
if( !grepl("\\(\\)", search) ){ lList2 = grep( search, rownames(inData), ignore.case=T, perl=T, value=T ) }
lNames2 = inData[lList2,]
lNames2 = data.frame( X=lNames2[,1], Y=lNames2[,2] )

# Highlight points from text area
hString1  = input$hList1SCL
hString1  = unlist(strsplit( hString1, "\\,| |\\n", perl=T ))
# Create search string
search    = paste("(?<![\\w-])(",paste(hString1, collapse="|"),")(?![\\w-])", sep="")
# Search string in genes database
hList1  = c()
if( !grepl("\\(\\)", search) ){ hList1 = grep( search, rownames(inData), ignore.case=T, perl=T, value=T ) }
hNames1 = inData[hList1,]
hNames1 = data.frame( X=hNames1[,1], Y=hNames1[,2] )

# Highlight points from text area
hString2  = input$hList2SCL
hString2  = unlist(strsplit( hString2, "\\,| |\\n", perl=T ))
# Create search string
search    = paste("(?<![\\w-])(",paste(hString2, collapse="|"),")(?![\\w-])", sep="")
# Search string in genes database
hList2 = c()
if( !grepl("\\(\\)", search) ){ hList2 = grep( search, rownames(inData), ignore.case=T, perl=T, value=T ) }
hNames2 = inData[hList2,]
hNames2 = data.frame( X=hNames2[,1], Y=hNames2[,2] )

# Highlight points from text area
hString3  = input$hList3SCL
hString3  = unlist(strsplit( hString3, "\\,| |\\n", perl=T ))
# Create search string
search    = paste("(?<![\\w-])(",paste(hString3, collapse="|"),")(?![\\w-])", sep="")
# Search string in genes database
hList3 = c()
if( !grepl("\\(\\)", search) ){ hList3 = grep( search, rownames(inData), ignore.case=T, perl=T, value=T ) }
hNames3 = inData[hList3,]
hNames3 = data.frame( X=hNames3[,1], Y=hNames3[,2] )

# Get colors for plot from multiple selection
colors = valuesSCL$colors
# Get colors for plot (last colors is for linear regression)
if( length(colors) < 4 ){
	colors = colorRampPalette( colors )( n=4 )
}
g3Color = colors[length(colors)]
colors  = colors[-length(colors)]
g2Color = colors[length(colors)]
colors  = colors[-length(colors)]
g1Color = colors[length(colors)]
colors  = colors[-length(colors)]
#cmax    = length(cData)
#palette = colorRampPalette( colors )( n=cmax )

sclData = data.frame( X=inData[,1], Y=inData[,2], Labels=rownames(inData) )
#row.names(sclData) <- rownames(inData)

# Main title and axis labels
mTitle     = gsub( ":n:", "\n", input$titleSCL )
xLabel     = gsub( ":n:", "\n", input$xLabelSCL )
yLabel     = gsub( ":n:", "\n", input$yLabelSCL )
mTitleSize = input$titleSizeSCL
legendSize = input$legendSizeSCL
labelSize  = input$labelSizeSCL
scaleSize  = input$scaleSizeSCL
textSize1  = input$hLabelSize1SCL
textSize2  = input$hLabelSize2SCL
nudgeX     = input$nudgeXSCL
nudgeY     = input$nudgeYSCL
lineWidth  = input$lineWidthSCL
tickWidth  = lineWidth / 1.8
pointSize  = input$pointSizeSCL
pointSize1 = input$hPointSize1SCL
pointSize2 = input$hPointSize2SCL
pointSize3 = input$hPointSize3SCL

scl = ggplot() +
geom_point( data=sclData, aes( X, Y ), col=colors, size=pointSize ) +
#ylim(ylow,yhigh) +
#xlim(xlow,xhigh) +
labs(
	title = mTitle,
	x     = xLabel,
	y     = yLabel
)

# Add lines
#geom_vline( xintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +
#geom_hline( yintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +
# Color points (up to 3 groups with different colors))
if( length(hList1) > 0 && input$hPoints1SCL ){
	scl = scl +
	geom_point( data=hNames1, aes( X, Y ), col=g1Color, size=pointSize1 )
}
if( length(hList2) > 0 && input$hPoints2SCL ){
	scl = scl +
	geom_point( data=hNames2, aes( X, Y ), col=g2Color, size=pointSize2 )
}
if( length(hList3) > 0 && input$hPoints3SCL ){
	scl = scl +
	geom_point( data=hNames3, aes( X, Y ), col=g3Color, size=pointSize3 )
}

# Label points with text
nudgeXval = nudgeX
if( input$applyNudgeXSCL ){ nudgeXval = nudgeX-lNames1$X }
if( length(lList1) > 0 && input$lPoints1SCL ){
	scl = scl +
	geom_text_repel( data=lNames1, aes( X, Y, label=lList1 ),
		nudge_x       = nudgeXval,
		direction     = "y",
		hjust         = 0,
		segment.size  = 0.2,
		size          = textSize1
	)
}
nudgeYval = nudgeY
if( input$applyNudgeYSCL ){ nudgeYval = nudgeY-lNames2$Y }
if( length(lList2) > 0 && input$lPoints2SCL ){
	scl = scl +
	geom_text_repel( data=lNames2, aes( X, Y, label=lList2 ),
		nudge_y       = nudgeYval,
		direction     = "x",
		angle         = 90,
		vjust         = 0,
		segment.size  = 0.2,
		size          = textSize2
	)
}

# Log scales
if( input$xLogSCL ){
	scl = scl +
	scale_x_continuous( trans='log10' )
}
if( input$yLogSCL ){
	scl = scl +
	scale_y_continuous( trans='log10' )
}

# Legend
#if( input$showLegendSCL ){
#	scl = scl +
#	theme( legend.position="right" )
#}else{
#	scl = scl +
#	theme( legend.position="none" )
#}

# Add theme
scl = scl +
theme(
#	legend.title      = element_text( size=legendSize*1.2 ),
	legend.title      = element_blank(),
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

print(scl)

write( paste("[SCL |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )

# Log scales
if( input$xLogSCL ){
	scl = scl +
	scale_x_continuous( trans='log10' )
}
if( input$yLogSCL ){
	scl = scl +
	scale_y_continuous( trans='log10' )
}

# Legend
#if( input$showLegendSCL ){
#	scl = scl +
#	theme( legend.position="right" )
#}else{
#	scl = scl +
#	theme( legend.position="none" )
#}

# Add theme
scl = scl +
theme(
#	legend.title      = element_text( size=legendSize*1.2 ),
	legend.title      = element_blank(),
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

print(scl)

write( paste("[SCL |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
