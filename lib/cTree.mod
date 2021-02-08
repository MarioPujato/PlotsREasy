[START UIPLOT]
		tabPanel( "C-Tree",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabCTR")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileCTR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileCTR" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleCTR", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsCTR"),
							br(),
							fileInput( "colorFileCTR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileCTR" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorCTR")
						),
						tabPanel( "Options",
							br(),
							splitLayout(
								h4("Dimensions:"),
								numericInput( "widthCTR",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightCTR", "Height", value = 600, min = 300, max = 2400, step = 50 )
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarCTR", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarCTR",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarCTR",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarCTR",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							h4("Main title and labels:"),
							textInput( "titleCTR",  NULL, placeholder = "Main title here" ),
							textInput( "yLabelCTR", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeCTR",  "Title size", value = 3.0,  min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yLabelSizeCTR", "Ylab size",  value = 2.5,  min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yYlabelCTR",    "Ylab pos",   value = 0.01, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "scaleSizeCTR",  "Scale size", value = 2.0,  min = 0.5, max = 10, step = 0.1 )
							),
							h4("Options:"),
							splitLayout(
								numericInput( "methodCTR",     "Arrangement", value = 1,   min = 1,   max = 4,  step = 1 ),
								numericInput( "textSizeCTR",   "Text size",   value = 0.8, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "symbolSizeCTR", "Symbol size", value = 5,   min = 0.5, max = 20, step = 0.5 ),
								""
							),
							splitLayout(
								numericInput( "lineWidthCTR", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "boxTypeCTR",   "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								"",
								""
							),
							h4("Gradient:"),
							splitLayout(
								numericInput( "gradXposCTR",  "X pos",   value = 0.74, min = 0, max = 1, step = 0.01 ),
								numericInput( "gradYposCTR",  "Y pos",   value = 0.04, min = 0, max = 1, step = 0.01 ),
								numericInput( "gradScaleCTR", "Scaling", value = 1,    min = 0, max = 2, step = 0.05 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/cTree.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotCTR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonCTR", "Plot"),
									downloadButton( "downloadPlotCTR", "Save Plot")
								),
								hr(),
								uiOutput("plotCTR")
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
	observeEvent( input$homeButtonCTR, {
		showNotification( "C-Tree button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="C-Tree")
	})

	valuesCTR = reactiveValues()

	output$tabCTR = renderText({ input$plotTab })

	output$plotCTR = renderUI({
		plotOutput(
			"plotOutCTR",
			width  = input$widthCTR,
			height = input$heightCTR
		)
	})

	output$plotColorsCTR = renderUI({
		plotOutput(
			"plotOutColorsCTR",
			width  = paletteWidthCTR(),
			height = paletteHeightCTR()
		)
	})

	output$paletteSelectorCTR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileCTR) ){
			colorData2 = read.table( input$colorFileCTR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteCTR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutCTR = renderPlot({
		input$goButtonCTR
		isolate({
			# Plot data or example
			colorFile = input$colorFileCTR
			if( is.null( input$dataFileCTR )){
				if( input$exampleCTR ){
					dataFile = "lib/examples/CTR.txt"
					source("lib/cTree.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileCTR$datapath
				source("lib/cTree.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthCTR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightCTR = function(){
		colorFile = input$colorFileCTR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileCTR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteCTR )){
			for( pattern in input$paletteCTR ){
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

	output$plotOutColorsCTR = renderPlot({
		colorFile = input$colorFileCTR
		palette   = input$paletteCTR
		source("lib/colorPalette.R", local = TRUE)
		valuesCTR$colors = colors
	})

	output$downloadPlotCTR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileCTR )){
				outFile = gsub( ".*/", "", input$dataFileCTR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthCTR  / 72,
				height = input$heightCTR / 72
			)
			dataFile = "lib/examples/CTR.txt"
			if( !is.null( input$dataFileCTR )){
				dataFile = input$dataFileCTR$datapath
			}
			sourcePlot( "lib/cTree.R", dataFile, input$colorFileCTR, input$paletteCTR )
			dev.off()
		}
	)
[END SRVPLOT]
