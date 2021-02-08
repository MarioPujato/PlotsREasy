[START UIPLOT]
		tabPanel( "Histogram",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabHIS")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileHIS",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileHIS" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleHIS", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsHIS"),
							br(),
							fileInput( "colorFileHIS", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileHIS" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorHIS")
						),
						tabPanel( "Options",
							br(),
							splitLayout(
								h4("Dimensions:"),
								numericInput( "widthHIS",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightHIS", "Height", value = 600, min = 300, max = 2400, step = 50 )
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarHIS", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarHIS",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarHIS",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarHIS",  "Right" , value = 0.3, min = 0, max = 10, step = 0.05 )
							),
							h4("Main title and labels:"),
							textInput( "titleHIS",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelHIS", NULL, placeholder = "X label here" ),
							textInput( "yLabelHIS", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeHIS",  "Title size", value = 3.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "xLabelSizeHIS", "Xlab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yLabelSizeHIS", "Ylab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "scaleSizeHIS",  "Scale size", value = 2.0, min = 0.5, max = 10, step = 0.1 )
							),
							splitLayout(
								numericInput( "xXlabelHIS",   "Xlab pos",   value = 0.01, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "yYlabelHIS",   "Ylab pos",   value = 0.01, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "xScalePosHIS", "XScale pos", value = 0.3,  min = -10, max = 10, step = 0.02 ),
								numericInput( "yScalePosHIS", "YScale pos", value = 0.0,  min = -10, max = 10, step = 0.02 )
							),
							splitLayout(
								numericInput( "xMinHIS", "X min", value = "NULL" ),
								numericInput( "xMaxHIS", "X max", value = "NULL" ),
								numericInput( "yMinHIS", "Y min", value = "NULL" ),
								numericInput( "yMaxHIS", "Y max", value = "NULL" )
							),
							h4("Options:"),
							splitLayout(
								checkboxInput( "barBordersHIS", "Bar borders",    value = F ),
								checkboxInput( "normalizeHIS",  "Normalize area", value = F ),
								"",
								""
							),
							splitLayout(
								numericInput( "numBinsHIS",   "Number of Bins", value = 20, min = 3,   max = 1000, step = 1   ),
								numericInput( "lineWidthHIS", "Line width",     value = 4,  min = 0.5, max = 10,   step = 0.1 ),
								numericInput( "boxTypeHIS",   "Box type",       value = 1,  min = 0,   max = 6,    step = 1   ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/histogram.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotHIS{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonHIS", "Plot"),
									downloadButton( "downloadPlotHIS", "Save Plot")
								),
								hr(),
								uiOutput("plotHIS")
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
	observeEvent( input$homeButtonHIS, {
		showNotification( "Histogram button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Histogram")
	})

	valuesHIS = reactiveValues()

	output$tabHIS = renderText({ input$plotTab })

	output$plotHIS = renderUI({
		plotOutput(
			"plotOutHIS",
			width  = input$widthHIS,
			height = input$heightHIS
		)
	})

	output$plotColorsHIS = renderUI({
		plotOutput(
			"plotOutColorsHIS",
			width  = paletteWidthHIS(),
			height = paletteHeightHIS()
		)
	})

	output$paletteSelectorHIS = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileHIS) ){
			colorData2 = read.table( input$colorFileHIS$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteHIS",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutHIS = renderPlot({
		input$goButtonHIS
		isolate({
			# Plot data or example
			colorFile = input$colorFileHIS
			if( is.null( input$dataFileHIS )){
				if( input$exampleHIS ){
					dataFile = "lib/examples/HIS.txt"
					source("lib/histogram.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileHIS$datapath
				source("lib/histogram.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthHIS = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightHIS = function(){
		colorFile = input$colorFileHIS
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileHIS$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteHIS )){
			for( pattern in input$paletteHIS ){
				iColors = readLines( "lib/defaultPalettes.txt" )
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

	output$plotOutColorsHIS = renderPlot({
		colorFile = input$colorFileHIS
		palette   = input$paletteHIS
		source("lib/colorPalette.R", local = TRUE)
		valuesHIS$colors = colors
	})

	output$downloadPlotHIS <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileHIS )){
				outFile = gsub( ".*/", "", input$dataFileHIS )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthHIS  / 72,
				height = input$heightHIS / 72
			)
			dataFile = "lib/examples/HIS.txt"
			if( !is.null( input$dataFileHIS )){
				dataFile = input$dataFileHIS$datapath
			}
			sourcePlot( "lib/histogram.R", dataFile, input$colorFileHIS, input$paletteHIS )
			dev.off()
		}
	)
[END SRVPLOT]
