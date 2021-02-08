# Get colors from multiple selection
colors       = c()
dispColors   = c()
squareBorder = c()
# Max number of columns set to 8
numColumns   = 8

if( !is.null(palette) ){
	iColorFile = "lib/defaultPalettes.txt"

	for( pattern in palette ){
		iColorLines = readLines( iColorFile )
		iColor      = iColorLines[grep( paste("^", pattern, "\t", sep=""), iColorLines )]
		iColor      = as.vector( unlist( strsplit( iColor, "\t" )))
		iColor      = iColor[2]
		colors      = c( colors, iColor )

		if(!is.null(colorFile) ){
			jColorFile  = colorFile$datapath
			jColorLines = readLines( jColorFile )
			jColor      = jColorLines[grep( paste("^", pattern, "\t", sep=""), jColorLines )]
			jColor      = as.vector( unlist( strsplit( jColor, "\t" )))
			jColor      = jColor[2]
			colors      = c( colors, jColor )
		}
	}
}
if( length(colors)==0 ){
	colors = c('#6B0C22','#F4CB89','#588C8C')
}

numRows      = ceiling( length(colors) / numColumns )
squareBorder = c( squareBorder, rep( '#DCDCDC', length(colors)))
# Saturate missing colors with background color
dispColors   = c( colors,       rep( '#F8F4F0', numColumns ))
squareBorder = c( squareBorder, rep( '#F8F4F0', numColumns ))

xPositions =  c(1:numColumns)
yPositions = -c(1:numRows)

par(
	mar   = c(0,0,0,0),
	bg    = '#F8F4F0',
	bty   = 'n',
	lend  = 2,
	ljoin = 1
)

xMin = min(xPositions)
xMax = max(xPositions) + 1
yMin = max(yPositions) + 1
yMax = min(yPositions)

plot(
	c( xMin, xMax ),
	c( yMin, yMax ),
	axes = F,  # Activate/deactivate axis
	type = "n",
	xlab = "",
	ylab = ""
)

borderWidth = 0.08
k = 1

for( j in 1:numRows ){
	for( i in 1:numColumns ){
		xLeft   = xPositions[i] + borderWidth
		xRight  = xPositions[i] - borderWidth + 1
		yBottom = yPositions[j] + borderWidth
		yTop    = yPositions[j] - borderWidth + 1

		rect(
			xLeft,
			yBottom,
			xRight,
			yTop,
			col    = dispColors[k],
			border = squareBorder[k],
			lwd    = 1
		)
		k = k + 1
	}
}
