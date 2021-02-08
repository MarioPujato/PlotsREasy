[START UIPLOT]
		tabPanel( "Violin",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabVIO")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileVIO",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileVIO" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleVIO", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsVIO"),
							br(),
							fileInput( "colorFileVIO", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileVIO" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorVIO")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthVIO",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightVIO", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							h4("Main title and labels:"),
							textInput( "titleVIO",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelVIO", NULL, placeholder = "log2(Fold Change)" ),
							textInput( "yLabelVIO", NULL, placeholder = "-log10(FDR)" ),
							splitLayout(
								numericInput( "titleSizeVIO", "Title size", value = 35, min = 1, max = 50, step = 1 ),
								numericInput( "scaleSizeVIO", "Scale size", value = 20, min = 1, max = 50, step = 1 ),
								numericInput( "labelSizeVIO", "Label size", value = 25, min = 1, max = 50, step = 1 ),
								""
							),
							h4("Plot limits:"),
							splitLayout(
								numericInput( "xMinVIO", "X min", value = "NULL", step = 0.01 ),
								numericInput( "xMaxVIO", "X max", value = "NULL", step = 0.01 ),
								numericInput( "yMinVIO", "Y min", value = "NULL", step = 0.01 ),
								numericInput( "yMaxVIO", "Y max", value = "NULL", step = 0.01 )
							),
							h4("Cutoffs:"),
							splitLayout(
								numericInput( "lfcCutoffVIO",     "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffVIO",     "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffVIO",     "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								numericInput( "fdrSaturationVIO", "-log(FDR) sat", value = "NULL", min = 0, max = 1000, step = 1 )
							),
							h4("Highlight genes:"),
							splitLayout(
								checkboxInput( "hGenesVIO",     "Highlight",   value = F ),
								checkboxInput( "hLabelsVIO",    "Labels",      value = F ),
								"",""
							),
							splitLayout(
								numericInput(  "hPointSizeVIO", "Symbol Size",    value = 2, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "hLabelSizeVIO", "Text Size",      value = 5, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "lNudgeXVIO",    "Left position",  value = 5, min = 0,   max = 50, step = 0.2 ),
								numericInput(  "rNudgeXVIO",    "Right position", value = 5, min = 0,   max = 50, step = 0.2 )
							),
							h5("Selection:"),
							uiOutput( "geneSelectionVIO" ),
							splitLayout(
								numericInput( "lfcCutoffHVIO", "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffHVIO", "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffHVIO", "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								""
							),
							h4("Box and symbols:"),
							splitLayout(
								checkboxInput( "boxSwitchVIO",  "Box",         value = T ),
								numericInput(  "lineWidthVIO",  "Line width",  value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput(  "symbolSizeVIO", "Symbol size", value = 2, min = 0.5, max = 10, step = 0.1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/violin.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotVIO{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonVIO", "Plot"),
									downloadButton( "downloadPlotVIO", "Save Plot")
								),
								hr(),
								uiOutput("plotVIO")
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
	observeEvent( input$homeButtonVIO, {
		showNotification( "Violin button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Violin")
	})

	valuesVIO = reactiveValues()

	output$tabVIO  = renderText({ input$plotTab })

	output$plotVIO = renderUI({
		plotOutput(
			"plotOutVIO",
			width  = input$widthVIO,
			height = input$heightVIO
		)
	})

	output$plotColorsVIO = renderUI({
		plotOutput(
			"plotOutColorsVIO",
			width  = paletteWidthVIO(),
			height = paletteHeightVIO()
		)
	})

	output$paletteSelectorVIO = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vc-Gray", "Vc-Green", "Vc-Red" )
		selections = c()
		if( !is.null(input$colorFileVIO) ){
			colorData2 = read.table( input$colorFileVIO$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteVIO",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutVIO = renderPlot({
		input$goButtonVIO
		isolate({
			# Plot data or example
			if( is.null( input$dataFileVIO )){
				if( input$exampleVIO ){
					dataFile = "lib/examples/VIO.txt"
					source("lib/violin.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFileVIO$datapath
				source("lib/violin.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthVIO = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightVIO = function(){
		colorFile = input$colorFileVIO
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileVIO$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteVIO )){
			for( pattern in input$paletteVIO ){
				iColor = readLines( "lib/defaultPalettes.txt" )
				iColor = iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor = as.vector( unlist( strsplit( iColor, "\t" )))
				iColor = iColor[2]
				colors = c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows    = ceiling( length( colors ) / numColumns )
		factor     = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotOutColorsVIO = renderPlot({
		colorFile = input$colorFileVIO
		palette   = input$paletteVIO
		indColors = input$indColorsVIO
		source("lib/colorPalette.R", local = TRUE)
		valuesVIO$colors = colors
	})

	output$downloadPlotVIO <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVIO )){
				outFile = gsub( ".*/", "", input$dataFileVIO )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthVIO  / 72,
				height = input$heightVIO / 72
			)
			dataFile = "lib/examples/VIO.txt"
			if( !is.null( input$dataFileVIO )){
				dataFile = input$dataFileVIO$datapath
			}
			sourcePlot( "lib/violin.R", dataFile, input$colorFileVIO, input$paletteVIO )
			dev.off()
		}
	)
[END SRVPLOT]
