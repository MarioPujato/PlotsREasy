#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# SCA plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

write( paste("[SCA |",curDate,"|",sessionId,"] Scatter plot"), file=stderr() )

dataTable = read.delim( dataFile, header=T, check.names=F )
header    = colnames(dataTable) 
gVar      = header[1]
lVar      = header[2]
xVar      = header[3]
yVar      = header[4]
write( paste("vars:",c(gVar,lVar,xVar,yVar)), file=stderr() )

# Get colors for plot from multiple selection
colors     = valuesSCA$colors
fitColor   = tail(colors,n=1)
colors     = head(colors,n=length(colors)-1)
# Get colors for plot (last colors is for linear regression)
nColors    = length(unique(dataTable[,gVar]))
palette    = colorRampPalette( colors )( n=nColors )
write( paste("Palette:",palette), file=stderr() )

# Main title and axis labels
mTitle     = gsub( ":n:", "\n", input$titleSCA )
xLabel     = gsub( ":n:", "\n", input$xLabelSCA )
yLabel     = gsub( ":n:", "\n", input$yLabelSCA )
mTitleSize = input$titleSizeSCA
legendSize = input$legendSizeSCA
labelSize  = input$labelSizeSCA
pointSize  = input$pointSizeSCA
scaleSize  = input$scaleSizeSCA
textSize   = input$textSizeSCA/3
lineWidth  = input$lineWidthSCA
tickWidth  = lineWidth / 1.8

sca = ggplot( dataTable, aes_string( x=xVar, y=yVar, color=gVar ) ) +
geom_point( size=pointSize ) +
scale_color_manual( values=palette ) +
labs(
	title = mTitle
)

# Add lines
#geom_vline( xintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +
#geom_hline( yintercept=0, linetype=2, size=lineWidth/4, color="grey50" ) +

# Show labels
if( input$showLabelsSCA ){
	sca = sca +
	geom_text_repel( aes_string( label=lVar ), colour="black", size=textsize )
}

# Log scales
if( input$xLogSCA ){
	sca = sca +
	scale_x_continuous( trans='log10' )
}
if( input$yLogSCA ){
	sca = sca +
	scale_y_continuous( trans='log10' )
}

# Legend
if( input$showLegendSCA ){
	sca = sca +
	theme(
		legend.position = "right",
		legend.title    = element_text( size=legendSize*1.2 )
	)
}else{
	sca = sca +
	theme(
		legend.position ="none",
		legend.title    = element_blank()
	)
}

# Linear fit
write( paste("[SCA |",curDate,"|",sessionId,"] Linear fit"), file=stderr() )
if( input$showLinearFitSCA ){
	eqSize = 6
	xPosEq = 0
	yPosEq = 0
	if( input$xPosEqSCA ){ xPosEq = input$xPosEqSCA }
	if( input$yPosEqSCA ){ yPosEq = input$yPosEqSCA }
#	if( input$eqSizeSCA ){ eqSize = input$eqSizeSCA }

	m = lm( as.formula(paste( yVar, "~", xVar )), data=dataTable )
	equation = substitute(
		target == a + b %.% input*";"~~r^2~"="~r2*";"~~p~"="~pvalue, 
		list(
			target = yVar,
			input  = xVar,
			a      = format(as.vector(coef(m)[1]), digits = 2),
			b      = format(as.vector(coef(m)[2]), digits = 2),
			r2     = format(summary(m)$r.squared,  digits = 3),
			# Getting the pvalue is painful
			pvalue = format(summary(m)$coefficients[2,'Pr(>|t|)'], digits=1)
		)
	)
	equation = as.character(as.expression(equation))

	sca = sca +
	geom_text( x=xPosEq, y=yPosEq, label=equation, parse=T, hjust=0, size=eqSize, check_overlap=T, colour=fitColor ) +
	geom_smooth( method=lm, colour=fitColor )
}

# Add theme
sca = sca +
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

print(sca)

write( paste("[SCA |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr() )
