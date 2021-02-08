#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
write( paste("[WCL_wordCloud |",curDate,"|",sessionId,"] Plotting wordCloud using file:",dataFile), file=stderr())

dataTable = read.table( dataFile, header = T, sep = "\t", check.names = F )

# Get colors for plot from multiple selection
colors    = valuesWCL$colors

colorDown = colors[1]
colorUp   = colors[2]
colorCen  = colors[3]

if( is.na(colorDown) ){
	colorDown = '#17193D'
}
if( is.na(colorUp) ){
	colorUp   = '#FBBC22'
}
if( is.na(colorCen) ){
	colorCen  = '#202020'
}

# Find out middle color between colorUp and colorDown
palette3 = colorRampPalette( c(colorUp, colorDown) )( n = 3 )
colorMed = palette3[2]

# Change colorMed to a whittish color if fading is requested
if( input$fadingWCL ){
	colorMed = '#FFFCF5'
}

# Construct color sets
posColors = c(colorUp,  colorMed)
negColors = c(colorMed, colorDown)

# Sort dataTable by values in the second column (descending)
#write(dataTable$ABSVAL,file=stderr())
dataTable = dataTable[ order(-dataTable[,2]), ]
#write(dataTable$ABSVAL,file=stderr())

# Separate positive, zero and negative values
posValues = dataTable[,2][dataTable[,2]>0]
zerValues = dataTable[,2][dataTable[,2]==0]
negValues = dataTable[,2][dataTable[,2]<0]

palette = c()

# Normalize positive and negative values
if( length(posValues) > 0 ){
	posN      = length(posValues)
	posMin    = min(posValues)
	posMax    = max(posValues)
	if( posMax == posMin ){
		posValues = rep( 1, posN )
		zerValues = rep( 1, length(zerValues) ) # Zeroes take a value of 1 (the middle value)
		palette   = c(palette, colorUp)
	}else{
		posValues = round( 1 + ((100-1) * (posValues-posMin)) / (posMax-posMin), digits = 0 )
		zerValues = rep( 100, length(zerValues) ) # Zeroes take a value of 100 (the middle value)
		palette   = c(palette, colorRampPalette( c(colorMed, colorUp) )( n = 100 ))
	}
}

if( length(negValues) > 0 ){
	negN      = length(negValues)
	negMin    = min(negValues)
	negMax    = max(negValues)
	if( negMax == negMin ){
		negValues = rep( 2, negN )
		zerValues = rep( 1, length(zerValues) ) # Zeroes take a value of 1 (the middle value)
		palette   = c(palette, colorDown)
	}else{
		negValues = round( 1 + ((100-1) * (negValues-negMin)) / (negMax-negMin), digits = 0 )
		negValues = 201 - negValues # Invert range and transform to range 101-200
		zerValues = rep( 100, length(zerValues) ) # Zeroes take a value of 100 (the middle value)
		palette   = c(palette, colorRampPalette( c(colorMed, colorDown) )( n = 100 ))
	}
}

# Build vector of normalized values
dataTable$NVALUE = c(posValues, zerValues, negValues)

# Add color by matching normalized values
dataTable$COLOR  = unlist( palette[dataTable$NVALUE] )

# Generate absolute values from weights to size words
dataTable$ABSVAL = abs(dataTable[,2])

# Add center color to center words (words with an original value of zero)
dataTable$COLOR[dataTable[,2]==0] <- colorCen

# Change the original value of zero to input$centerValueWCL
valueCen = input$centerValueWCL
if( is.na(input$centerValueWCL) || input$centerValueWCL == 0 ){
	valueCen = 3
}
dataTable$ABSVAL[dataTable[,2]==0] = valueCen

# Control plot margins and spacing between text lines
par(
	mai = c(
		input$bottomMarWCL,
		input$leftMarWCL,
		input$upperMarWCL,
		input$rightMarWCL
	),
	lheight = 0.8, # Inter-line spacing
	ljoin   = 1,   # Square lines
	lend    = 2,   # Square ends in lines
	xaxs    = "i", # Removes the 4% space added to each side of x axis
	yaxs    = "i", # Removes the 4% space added to each side of y axis
	xpd     = NA
)

sizeMin = input$minSizeWCL #0.7
sizeMax = input$maxSizeWCL #2.5

boldFont = 1
if( input$boldFontWCL ){
	boldFont = 2
}

wordcloud(
	dataTable[,1],
	dataTable$ABSVAL,
	min.freq       = 0,
	scale          = c( sizeMax, sizeMin ),
	random.order   = F,
	font           = boldFont, # 2: Bold font
	ordered.colors = T,
	colors         = dataTable$COLOR
)

# Title
title = gsub( ":n:", "\n", input$titleWCL )
text(
	grconvertX( 0.50, from = "ndc", to = "user" ),
	grconvertY( input$yTitleWCL, from = "ndc", to = "user" ),
	adj   = c(0.5,1),
	label = title,
	cex   = input$titleSizeWCL
)

write( paste("[WCL_wordCloud |",curDate,"|",sessionId,"] DONE"), file=stderr())
