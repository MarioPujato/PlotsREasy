[START UIPLOT]
		tabPanel( "GenomicHeatmap",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabGHM")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileGHM",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileGHM" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleGHM", "Load example file", value = F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsGHM"),
							br(),
							fileInput( "colorFileGHM", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileGHM" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorGHM")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthGHM",  "Witdh",  value = 650, min = 300, max = 2400, step = 50 ),
								numericInput( "heightGHM", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Main title:"),
							textInput( "titleGHM",  NA, placeholder = "Main title here" ),
							br(),hr(),
							h4("Options:"),
							splitLayout(
								numericInput( "titleSizeGHM",  "Title size", value = 30, min = 1, max = 50, step = 1 ),
								numericInput( "scaleSizeGHM",  "Scale size", value = 22, min = 1, max = 50, step = 1 ),
								numericInput( "labelSizeGHM",  "Label size", value = 26, min = 1, max = 50, step = 1 ),
								""
							),
							splitLayout(
								numericInput( "textSizeGHM",   "Text size",   value = 20, min = 1, max = 50, step = 1 ),
								numericInput( "legendSizeGHM", "Legend size", value = 16, min = 1, max = 50, step = 1 ),
								"",""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/genomicHeatmap.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotGHM{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonGHM", "Plot"),
									downloadButton( "downloadPlotGHM", "Save Plot")
								),
								hr(),
								uiOutput("plotGHM")
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
	output$tabGHM  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthGHM = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightGHM = function(){
		colorFile = input$colorFileGHM
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = as.vector( unlist( read.table( colorFile$datapath, header = F )))
		}else if( !is.null( input$paletteGHM )){
			for( pattern in input$paletteGHM ){
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

	output$plotGHM = renderUI({
		plotOutput(
			"plotOutGHM",
			width  = input$widthGHM,
			height = input$heightGHM
		)
	})

	output$plotColorsGHM = renderUI({
		plotOutput(
			"plotOutColorsGHM",
			width  = paletteWidthGHM(),
			height = paletteHeightGHM()
		)
	})

	output$plotOutColorsGHM = renderPlot({
		colorFile = input$colorFileGHM
		palette   = input$paletteGHM
		indColors = input$indColorsGHM
		source("lib/colorPalette.R", local = TRUE)
	})

	output$paletteSelectorGHM = renderUI({
		colorData = read.table( "lib/defaultPalettes.txt", header = F )
		if( !is.null(input$colorFileGHM) ){
			colorData = as.vector( unlist( read.table( input$colorFileGHM, header = F )))
		}
		selections = colorData$V1
		selectInput( "paletteGHM",
			"Select colors:",
			selections,
			selected = c( "PCA-1", "PCA-2", "PCA-3" ),
			multiple = TRUE
		)
	})

	output$plotOutGHM = renderPlot({
		input$goButtonGHM
		isolate({
			# Plot data or example
			colorFile = input$colorFileGHM
			if( is.null( input$dataFileGHM )){
				if( input$exampleGHM ){
					dataFile = "lib/examples/GHM.txt"
					write( paste("[GHM] Using test file:",dataFile), file=stderr() )
					source("lib/genomicHeatmap.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFileGHM$datapath
				source("lib/genomicHeatmap.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	output$downloadPlotGHM <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileGHM )){
				outFile = gsub( ".*/", "", input$dataFileGHM )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthGHM  / 72,
				height = input$heightGHM / 72
			)
			dataFile = "lib/examples/GHM.txt"
			if( !is.null( input$dataFileGHM )){
				dataFile = input$dataFileGHM$datapath
			}
			sourcePlot( "lib/genomicHeatmap.R", dataFile, input$colorFileGHM, input$paletteGHM )
			dev.off()
		}
	)
[END SRVPLOT]
