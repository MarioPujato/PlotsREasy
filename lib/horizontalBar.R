dataTable = read.table( dataFile, header = T, sep = "\t", check.names = F )
names     = colnames( dataTable )

# Extract data
Ylabels = as.vector( dataTable[,1] )
Ylabels = gsub( ":n:", "\n", Ylabels )
legend  = Ylabels
ncol1   = 2
xError  = 0

if( input$errorPresentHOR ){
	# Extract data with error bars
	ncol2  = ncol( dataTable ) / 2 + 1
	ncol3  = ncol2 + 1
	ncol4  = ncol( dataTable ) + 1
	xData  = as.matrix( dataTable[,ncol1:ncol2] )
	xError = as.matrix( dataTable[,ncol3:ncol4] )
}else{
	# Extract data without error bars
	ncol2  = ncol( dataTable )
	xData  = as.matrix( dataTable[,ncol1:ncol2] )
	ncols  = ncol2-ncol1+1
	xError = matrix( rep( 0, ncols ), nrow = nrow(xData), ncol = ncols )
}
xDataOff = xData

# Apply offset
if( !is.na(input$XOffsetHOR) ){
	xDataOff[xDataOff>=0] = xDataOff[xDataOff>=0] - input$XOffsetHOR
	xDataOff[xDataOff<0]  = xDataOff[xDataOff<0]  + input$XOffsetHOR
}

# Get colors for plot from multiple selection
colors = valuesHOR$colors

nColors = length(legend)
colors  = colorRampPalette(colors)( n=nColors )

# Write group Y labels instead of Y labels for each bar
if( input$groupSwitchHOR || input$stackColumnsHOR ){
	Ylabels = names[ncol1:ncol2]
}

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarHOR,
		input$leftMarHOR,
		input$upperMarHOR,
		input$rightMarHOR
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Style of X axis. "r": adds 4% spacing to each side; "i": no spacing added
	xpd     = NA
)

# Titles all around the plot
title   = gsub( ":n:", "\n", input$titleHOR )
x_label = gsub( ":n:", "\n", input$XLabelHOR )

border_color  = NA
if( input$barBordersHOR ){
	border_color = '#000000'
}

# Set plot limits (defaults to min and max values of X and Y axis)
stacked = 1
if( input$stackColumnsHOR ){
	stacked  = 0
	xStacked = c()

	for( j in 1:ncol( xDataOff )){
		x_prev = 0
		for( i in 1:nrow( xDataOff )){
			xStacked = c( xStacked, xDataOff[i,j] + x_prev + xError[i,j] )
			x_prev = x_prev + xDataOff[i,j]
		}
	}
	xmax = max( xStacked, na.rm = T )
	xmin = 0
}else{
	xdata = c()

	for( i in 1:nrow( xDataOff )){
		for( j in 1:ncol( xDataOff )){
			test = xDataOff[i,j]

			if( is.na( test )){
				test = 0
			}
			if( test >= 0 ){
				xdata = c( xdata, xDataOff[i,j] + xError[i,j] )
			}else{
				xdata = c( xdata, xDataOff[i,j] - xError[i,j] )
			}
		}
	}
	xmax = max( xdata, na.rm = T )
	xmin = min( xdata, na.rm = T )
}

# Add 5% of the range to each side in both dimensions
xrange = xmax - xmin
xmax   = xmax + xrange * 0.05

# Set ymin to zero if all bars have positive values
if( xmin >= 0 ){
	xmin = 0
}else{
	xmin = xmin - xrange * 0.05
}

if( !is.na(input$xMinHOR) ){
	xmin = input$xMinHOR
}
if( !is.na(input$xMaxHOR) ){
	xmax = input$xMaxHOR
}

# Graph bar plot
bar = barplot(
	xDataOff,
	axes      = F,  # Activate/deactivate axis
	axisnames = F,
	beside    = stacked,  # 1: Grouped columns, 0: Stacked columns
	border    = border_color,   # Bar borders
	col       = colors,         # Bar colors
	horiz     = 1, # Activate horizontal bars
	main      = title,
	xpd       = F,
	cex.main  = input$titleSizeHOR,
	space     = c( input$barSpaceHOR, input$groupSpaceHOR ),
	xlim      = c( xmin, xmax )
)

# Plot axes
# X-axis
XLabPos   = pretty( c( xmin + input$XOffsetHOR, xmax + input$XOffsetHOR ) )
Xlabels   = XLabPos
XPositive = XLabPos[XLabPos>=input$XOffsetHOR]
XNegative = rev(-XLabPos[XLabPos>input$XOffsetHOR])
Xlabels   = tail( c( XNegative, XPositive ), length(XLabPos) )

par( xpd = F )
axis(
	1,
	lwd      = input$lineWidthHOR,
	at       = XLabPos - input$XOffsetHOR,
	labels   = Xlabels,
	las      = 0,
	cex.axis = input$scaleSizeHOR
)
par( xpd = NA )

# Y-axis
# Calculate group bar means to position the group labels
barPos    = bar
bar_means = c()

if( !input$stackColumnsHOR ){
	if( input$groupSwitchHOR ){
		for( j in 1:ncol( bar )){
			bar_means = c( bar_means, mean( bar[,j] ) )
		}
		barPos = bar_means
	}else{
		for( j in 1:length( bar )){
			bar_means = c( bar_means, mean( bar[j] ) )
		}
		barPos = bar_means
	}
}

# Y-axis label 1
xYlab_usr = grconvertX( input$xYLabel1HOR, from = "ndc", to = "user" )
# horizontal adj
x_adj = 0.5
y_adj = 1

# Vertical adj
if( input$YLabDirHOR == 0 ){
	x_adj = 1
	y_adj = 0.5

	if( xYlab_usr > xmin ){
		x_adj = 0
	}
}
ylab_adj = c(x_adj,y_adj)

text(
	xYlab_usr,
	barPos,
	adj   = ylab_adj,
	label = Ylabels,
	srt   = input$YLabDirHOR,
	cex   = input$YLabelSizeHOR
)

# Y-axis label 2
y_label2 = gsub( ":n:", "\n", input$YLabelHOR )
text(
	grconvertX( input$xYLabel2HOR, from = "ndc", to = "user" ),
	grconvertY( 0.50, from = "npc", to = "user" ),
	adj   = c(0.5,1),
	label = y_label2,
	srt   = 90,
	cex   = input$XLabelSizeHOR
)

# X-axis label
text(
	grconvertX( 0.50, from = "npc", to = "user" ),
	grconvertY( input$yXLabelHOR, from = "ndc", to = "user" ),
	adj   = c(0.5,0),
	label = x_label,
	srt   = 0,
	cex   = input$XLabelSizeHOR
)

# Add box around plot
# "o" (the default), "l", "7", "c", "u", or "]"
# "n" suppresses the box
boxtypes = c('n','o','l','7','c','u',']')
boxtype  = boxtypes[input$boxTypeHOR+1]

if( input$boxSwitchHOR ){
	box(
		which = "plot",
		bty   = boxtype,
		lwd   = input$lineWidthHOR
	)
}

# Error bars
if( input$errorUpHOR || input$errorDownHOR ){
	par( xpd = F )
	if( stacked == 0 )	{
		for( j in 1:ncol( xDataOff )){
			y_prev = 0

			for( i in 1:nrow( xDataOff )){
				errorUp   = 0
				errorDown = 0
				codeUp    = 0
				codeDown  = 0

				if( input$errorUpHOR ){
					errorUp   = xError[i,j]
					codeUp    = 1
				}
				if( input$errorDownHOR ){
					errorDown = xError[i,j]
					codeDown  = 2
				}
				errorCode = codeUp + codeDown

				arrows(
					xDataOff[i,j] + y_prev + errorUp,
					bar[j],
					xDataOff[i,j] + y_prev - errorDown,
					bar[j],
					angle  = 90,
					code   = errorCode,
					length = input$errorLengthHOR,
					lwd    = input$errorWidthHOR
				)
				y_prev = y_prev + xDataOff[i,j]
			}
		}
	}else{
		k = 1
		for( j in 1:ncol( xDataOff )){
			for( i in 1:nrow( xDataOff )){
				if( xDataOff[i,j] >= 0 ){
					errorUp   = 0
					errorDown = 0
					codeUp    = 0
					codeDown  = 0

					if( input$errorUpHOR ){
						errorUp   = xError[i,j]
						codeUp    = 1
					}
					if( input$errorDownHOR ){
						errorDown = xError[i,j]
						codeDown  = 2
					}
					errorCode = codeUp + codeDown

					arrows(
						xDataOff[i,j] + errorUp,
						bar[k],
						xDataOff[i,j] - errorDown,
						bar[k],
						angle  = 90,
						code   = errorCode,
						length = input$errorLengthHOR,
						lwd    = input$errorWidthHOR
					)
				}else{
					errorUp   = 0
					errorDown = 0
					codeUp    = 0
					codeDown  = 0

					if( input$errorUpHOR ){
						errorUp   = xError[i,j]
						codeUp    = 2
					}
					if( input$errorDownHOR ){
						errorDown = xError[i,j]
						codeDown  = 1
					}
					errorCode = codeUp + codeDown

					arrows(
						xDataOff[i,j] + errorDown,
						bar[k],
						xDataOff[i,j] - errorUp,
						bar[k],
						angle  = 90,
						code   = errorCode,
						length = input$errorLengthHOR,
						lwd    = input$errorWidthHOR
					)
				}
				k = k+1
			}
		}
	}
	par( xpd = NA )
}

# Add legend to have extra control
if( input$legendSwitchHOR ){
	legend(
		grconvertX( input$xLegendHOR, from = "ndc", to = "user" ),
		grconvertY( input$yLegendHOR, from = "ndc", to = "user" ),
		legend,
		horiz     = input$legendTypeHOR, # T: horizontal, F: vertical
		fill      = colors,
		bty       = 'n',              # No box
		cex       = input$legendSizeHOR, # Text size multiplier
		x.intersp = 0.5,              # Horizontal spacing
		y.intersp = 0.9               # Vertical spacing
	)
}

par( xpd = F )

# Add vertical line to plot
if( input$switchLineHOR ){
	abline(
		v   = input$linePositionHOR,
		lwd = input$line2WidthHOR, # Line width
		lty = input$lineTypeHOR    # Line type
	)
}
