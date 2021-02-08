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
#							fileInput( "colorFileSCA", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							fileInput( "colorFileSCA", NULL, placeholder = "Select file" ),
							tags$script('$( "#colorFileSCA" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorSCA")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthSCA",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightSCA", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Titles:"),
							textInput( "titleSCA",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelSCA", NULL, placeholder = "X label here" ),
							textInput( "yLabelSCA", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeSCA", "Title size", value = 26, min = 5, max = 50, step = 1 ),
								numericInput( "labelSizeSCA", "Lab size",   value = 22, min = 5, max = 50, step = 1 ),
								"",""
							),
							br(),hr(),
							h4("Scales:"),
							splitLayout(
								numericInput(  "lineWidthSCA", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "scaleSizeSCA", "Scale size",  value = 18, min = 2, max = 30, step = 1 ),
								checkboxInput( "xLogSCA", "Log X", value = F ),
								checkboxInput( "yLogSCA", "Log Y", value = F )
							),
							br(),hr(),
							h4("Points:"),
							splitLayout(
								numericInput( "pointSizeSCA", "Point Size", value = 5, min = 1, max = 30, step = 1 ),
								"","",""
							),
							splitLayout(
								checkboxInput( "labelsPresentSCA", "Labels", value = T ),
								checkboxInput( "showLabelsSCA",    "Show",   value = F ),
								numericInput(  "textSizeSCA",      "Label Size",   value = 14, min = 2, max = 10, step = 0.1 ),
								""
							),
							br(),hr(),
							h4("Legend:"),
							splitLayout(
								checkboxInput( "showLegendSCA", "Legend", value = F ),
								numericInput(  "legendSizeSCA", "Size",   value = 15, min = 2, max = 30, step = 1 ),
								"",""
							),
							br(),hr(),
							h4("Linear fit:"),
							splitLayout(
								checkboxInput( "showLinearFitSCA", "Linear", value = F ),
								numericInput( "xPosEqSCA", "X pos", value = 0,  step = 1 ),
								numericInput( "yPosEqSCA", "Y pos", value = 0,  step = 1 ),
								numericInput( "eqSizeSCA", "Size",  value = 14, step = 1 )
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/scatter.md" )
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
	observeEvent( input$homeButtonSCA, {
		showNotification( "Scatter button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Scatter")
	})

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
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "VENN-2", "PIE-1" )
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
					dataFile = "lib/examples/SCA.txt"
					source("lib/scatter.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileSCA$datapath
				source("lib/scatter.R", local = TRUE)
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

	output$plotOutColorsSCA = renderPlot({
		colorFile = input$colorFileSCA
		palette   = input$paletteSCA
		source("lib/colorPalette.R", local = TRUE)
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
			dataFile = "lib/examples/SCA.txt"
			if( !is.null( input$dataFileSCA )){
				dataFile = input$dataFileSCA$datapath
			}
			sourcePlot( "lib/scatter.R", dataFile, input$colorFileSCA, input$paletteSCA )
			dev.off()
		}
	)
[END SRVPLOT]
