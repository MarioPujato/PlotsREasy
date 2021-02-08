[START UIPLOT]
		tabPanel( "Scatter",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabSCA")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileSCA",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileSCA" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleSCA", "Load example file", value = F ),
							br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsSCA"),
							br(),
							fileInput( "colorFileSCA", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileSCA" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorSCA")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthSCA",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightSCA", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"","",""
							),
							br(),hr(),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarSCA", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarSCA",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarSCA",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarSCA",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							textInput( "titleSCA",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelSCA", NULL, placeholder = "X label here" ),
							textInput( "yLabelSCA", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeSCA",  "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "xLabelSizeSCA", "Xlab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yLabelSizeSCA", "Ylab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "scaleSizeSCA",  "Scale size", value = 2.0, min = 0.5, max = 10, step = 0.1 )
							),
							splitLayout(
								numericInput( "xXlabelSCA",   "Xlab pos",   value = 0.02, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "yYlabelSCA",   "Ylab pos",   value = 0.01, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "xScalePosSCA", "XScale pos", value = 0.3,  min = -10, max = 10, step = 0.01 ),
								numericInput( "yScalePosSCA", "YScale pos", value = 0.0,  min = -10, max = 10, step = 0.01 )
							),
							br(),hr(),
							h4("Scales:"),
							splitLayout(
								numericInput( "xMinSCA", "X min", value = "NULL", step = 0.01 ),
								numericInput( "xMaxSCA", "X max", value = "NULL", step = 0.01 ),
								numericInput( "yMinSCA", "Y min", value = "NULL", step = 0.01 ),
								numericInput( "yMaxSCA", "Y max", value = "NULL", step = 0.01 )
							),
							splitLayout(
								checkboxInput( "xLogSCA", "Log X", value = F ),
								checkboxInput( "yLogSCA", "Log X", value = F ),
								"",""
							),
							br(),hr(),
							h4("Options:"),
							splitLayout(
								checkboxInput( "boxSwitchSCA",  "Box",        value = T ),
								numericInput(  "boxTypeSCA",    "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								numericInput(  "line1WidthSCA", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								""
							),
							splitLayout(
								numericInput( "plotTypeSCA", "Plot type", value = 1, min = 1, max = 7, step = 1 ),
								"","",""
							),
							splitLayout(
								numericInput(  "symbolTypeSCA", "Symbol type", value = 19, min = 0,   max = 25, step = 1 ),
								numericInput(  "symbolSizeSCA", "Size",        value = 4,  min = 0.5, max = 10, step = 0.1 ),
								checkboxInput( "seqSymbolsSCA", "Sequential" ),
								""
							),
							splitLayout(
								numericInput( "lineTypeSCA",   "Line Type", value = 1, min = 0,   max = 6,  step = 1 ),
								numericInput( "line2WidthSCA", "Width",     value = 4, min = 0.5, max = 10, step = 0.1 ),
								checkboxInput( "seqLinesSCA",  "Sequential" ),
								""
							),
							h4("Legend:"),
							splitLayout(
								checkboxInput( "legendSwitchSCA", "Legend" ),
								checkboxInput( "legendTypeSCA",   "Horizontal" ),
								"",""
							),
							splitLayout(
								numericInput( "legendSizeSCA", "Size",  value = 1.5,  min = 0.1, max = 2, step = 0.05 ),
								numericInput( "xLegendSCA",    "X pos", value = 0.35, min = 0,   max = 1, step = 0.01 ),
								numericInput( "yLegendSCA",    "Y pos", value = 0.05, min = 0,   max = 1, step = 0.01 ),
								""
							),
							br(),hr(),
							h4("Error bars"),
							splitLayout(
								checkboxInput( "errorSwitchSCA", "Error Bars", value = F ),
								"","",""
							),
							splitLayout(
								numericInput( "errorWidthSCA",  "Thickness", value = 2.5, min = 1.0,  max = 10, step = 0.1 ),
								numericInput( "errorLengthSCA", "Width",      value = 0.1, min = 0.01, max = 1,  step = 0.02 ),
								"",""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "/srv/shiny-server/PlotsREasy/lib/core.md" ),
							br(),
							includeMarkdown( "/srv/shiny-server/PlotsREasy/lib/scatter.md" )
						)
					)
				),
				mainPanel(
					tags$style(HTML("#plotSCA{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonSCA", "Plot"),
									downloadButton( "downloadPlotSCA", "Save Plot")
								),
								hr(),
								uiOutput("plotSCA")
							),
							tabPanel( "Log",
								br(),
								"Nothing to display"
							)
						)
					)
				)
			)
		)
[END UIPLOT]

[START SRVPLOT]

	valuesSCA = reactiveValues()

	output$tabSCA  = renderText({ input$plotTab })

	output$plotSCA = renderUI({
		plotOutput(
			"plotOutSCA",
			width  = input$widthSCA,
			height = input$heightSCA
		)
	})

	output$plotColorsSCA = renderUI({
		plotOutput(
			"plotOutColorsSCA",
			width  = paletteWidthSCA(),
			height = paletteHeightSCA()
		)
	})

	output$paletteSelectorSCA = renderUI({
		colorData1 = read.table( "/srv/shiny-server/PlotsREasy/lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileSCA) ){
			colorData2 = read.table( input$colorFileSCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteSCA",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutSCA = renderPlot({
		input$goButtonSCA
		isolate({
			# Plot data or example
			colorFile = input$colorFileSCA
			if( is.null( input$dataFileSCA )){
				if( input$exampleSCA ){
					dataFile = "/srv/shiny-server/PlotsREasy/lib/examples/SCA.txt"
					source("/srv/shiny-server/PlotsREasy/lib/scatter.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileSCA$datapath
				source("/srv/shiny-server/PlotsREasy/lib/scatter.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthSCA = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightSCA = function(){
		colorFile = input$colorFileSCA
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileSCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteSCA )){
			for( pattern in input$paletteSCA ){
				iColors = readLines( "/srv/shiny-server/PlotsREasy/lib/defaultPalettes.txt" )
				iColors = iColors[grep( paste("^", pattern, "\t", sep=""), iColors )]
				iColors = as.vector( unlist( strsplit( iColors, "\t" )))
				iColors = iColors[2:length(iColors)]
				colors  = c( colors, iColors )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows    = ceiling( length( colors ) / numColumns )
		factor     = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotOutColorsSCA = renderPlot({
		colorFile = input$colorFileSCA
		palette   = input$paletteSCA
		source("/srv/shiny-server/PlotsREasy/lib/colorPalette.R", local = TRUE)
		valuesSCA$colors = colors
	})

	output$downloadPlotSCA <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileSCA )){
				outFile = gsub( ".*/", "", input$dataFileSCA )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthSCA  / 72,
				height = input$heightSCA / 72
			)
			dataFile = "/srv/shiny-server/PlotsREasy/lib/examples/SCA.txt"
			if( !is.null( input$dataFileSCA )){
				dataFile = input$dataFileSCA$datapath
			}
			sourcePlot( "/srv/shiny-server/PlotsREasy/lib/scatter.R", dataFile, input$colorFileSCA, input$paletteSCA )
			dev.off()
		}
	)
[END SRVPLOT]
