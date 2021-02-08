[START UIPLOT]
		tabPanel( "Correlation Matrix",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabCOR")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileCOR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileCOR" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleCOR", "Load example file", value = F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsCOR"),
							br(),
							fileInput( "colorFileCOR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileCOR" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorCOR")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthCOR",  "Witdh",  value = 530, min = 300, max = 2400, step = 50 ),
								numericInput( "heightCOR", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Options:"),
							splitLayout(
								numericInput(  "rowLabelSpaceCOR", "Row label space", value = 0.2, min = 0, max = 10, step = 0.1 ),
								numericInput(  "colLabelSpaceCOR", "Col label space", value = 0.2, min = 0, max = 10, step = 0.1 ),
								checkboxInput( "cellDataCOR", "Show cell data", value = T ),
								""
							),
							splitLayout(
								numericInput(  "rowLabelSizeCOR", "Row label size", value = 6, min = 0, max = 50, step = 1 ),
								numericInput(  "colLabelSizeCOR", "Col label size", value = 6, min = 0, max = 50, step = 1 ),
								numericInput(  "cellTextSizeCOR", "Cell text size", value = 5, min = 0, max = 50, step = 1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/corMatrix.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotCOR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonCOR", "Plot"),
									downloadButton( "downloadPlotCOR", "Save Plot")
								),
								hr(),
								uiOutput("plotCOR")
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
	observeEvent( input$homeButtonCOR, {
		showNotification( "Correlation Matrix button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Correlation Matrix")
	})

	valuesCOR = reactiveValues()

	output$tabCOR  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthCOR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightCOR = function(){
		colorFile = input$colorFileCOR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileCOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteCOR )){
			for( pattern in input$paletteCOR ){
				iColor = readLines( "lib/defaultPalettes.txt" )
				iColor = iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor = as.vector( unlist( strsplit( iColor, "\t" )))
				iColor = iColor[2]
				colors = c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows = ceiling( length(colors) / numColumns )
		factor = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotCOR = renderUI({
		plotOutput(
			"plotOutCOR",
			width  = input$widthCOR,
			height = input$heightCOR
		)
	})

	output$plotColorsCOR = renderUI({
		plotOutput(
			"plotOutColorsCOR",
			width  = paletteWidthCOR(),
			height = paletteHeightCOR()
		)
	})

	output$plotOutColorsCOR = renderPlot({
		colorFile = input$colorFileCOR
		palette   = input$paletteCOR
		indColors = input$indColorsCOR
		source("lib/colorPalette.R", local = TRUE)
		valuesCOR$colors = colors
	})

	output$paletteSelectorCOR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "PCA-1", "PCA-2", "PCA-4" )
		selections = c()
		if( !is.null(input$colorFileCOR) ){
			colorData2 = read.table( input$colorFileCOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteCOR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutCOR = renderPlot({
		input$goButtonCOR
		isolate({
			# Plot data or example
			colorFile = input$colorFileCOR
			if( is.null( input$dataFileCOR )){
				if( input$exampleCOR ){
					dataFile = "lib/examples/COR.txt"
					write( paste("[COR] Using test file:",dataFile), file=stderr() )
					source("lib/corMatrix.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFileCOR$datapath
				source("lib/corMatrix.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	output$downloadPlotCOR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileCOR )){
				outFile = gsub( ".*/", "", input$dataFileCOR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthCOR  / 72,
				height = input$heightCOR / 72
			)
			dataFile = "lib/examples/COR.txt"
			if( !is.null( input$dataFileCOR )){
				dataFile = input$dataFileCOR$datapath
			}
			sourcePlot( "lib/corMatrix.R", dataFile, input$colorFileCOR, input$paletteCOR )
			dev.off()
		}
	)
[END SRVPLOT]
