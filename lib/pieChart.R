#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# PIE CHART plot
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

# Get colors for plot from multiple selection
colors = valuesPIE$colors

write( paste("[PIE |",curDate,"|",sessionId,"] Plotting pie chart using file:",dataFile), file=stderr() )

# Margins
par(
	mar  = c( 0.1, 0.1, 0.1, 0.1 ),
	lend = 2,
	xaxs = 'i',
	xpd  = 0
)

# Get pie title
pieTitle  = gsub( ":n:", "\n", input$titlePIE )
titleSize = input$titleSizePIE
y_title   = 0.99

dataTable = read.table(
	dataFile,
	header = TRUE,
	sep    = "\t"
)
sectionNames = as.vector( dataTable[,1] )
sectionData  = as.vector( dataTable[,2] )

# Define colors for pie chart
#colors = c('#6B0C22','#F4CB89','#588C8C')
paletteColors = colorRampPalette( colors )( n=length(sectionNames) )

plot.new()

x_circle   = input$xCirclePIE
y_circle   = input$yCirclePIE
r_circle   = input$rCirclePIE
i_circle   = input$iCirclePIE
exploded   = input$explodePIE
legendSize = input$legendSizePIE
columns    = input$columnsPIE

if( is.null(x_circle)   ){ x_circle=0.5 }
if( is.null(y_circle)   ){ y_circle=0.5 }
if( is.null(r_circle)   ){ r_circle=0.35 }
if( is.null(i_circle)   ){ i_circle=0 }
if( is.null(exploded)   ){ exploded=0 }
if( is.null(legendSize) ){ legendSize=1.8 }
if( is.null(columns)    ){ columns=1 }

output = floating.pie(
	x_circle,
	y_circle,
	sectionData,
	edges      = 200,
	radius     = r_circle,
	startpos   = 0,
	col        = paletteColors,
	border     = NA,
	explode    = exploded
)

# Inner white circle
draw.circle(
	x_circle,
	y_circle,
	i_circle,
	nv      = 100,
	border  = NA,
	col     = '#FFFFFF',
	lty     = 1,
	density = NULL,
	angle   = 45,
	lwd     = 1
)

# Add title to pie chart
text(
	x_circle,
	y_title,
	labels = pieTitle,
	adj    = c(0.5,1),
	font   = 2,
	cex    = titleSize
)

legend(
	"bottom",
	y = NULL,
	sectionNames,
	paletteColors,
	cex       = legendSize,
	ncol      = columns,
	bg        = 'transparent',
	bty       = 'n',
	border    = paletteColors,
	x.intersp = 0.3,
	y.intersp = 0.8
)

write( paste("[PIE |",curDate,"|",sessionId,"] DONE"), file=stderr() )
