[START UIPLOT]
		tabPanel( "Volcano",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabVLC")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileVLC",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileVLC" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleVLC", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsVLC"),
							br(),
							fileInput( "colorFileVLC", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileVLC" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorVLC")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthVLC",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightVLC", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Main title and labels:"),
							textInput( "titleVLC",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelVLC", NULL, placeholder = "log2(Fold Change)" ),
							textInput( "yLabelVLC", NULL, placeholder = "-log10(FDR)" ),
							splitLayout(
								numericInput( "titleSizeVLC", "Title size", value = 35, min = 1, max = 50, step = 1 ),
								numericInput( "scaleSizeVLC", "Scale size", value = 20, min = 1, max = 50, step = 1 ),
								numericInput( "labelSizeVLC", "Label size", value = 25, min = 1, max = 50, step = 1 ),
								""
							),
							br(),hr(),
							h4("Plot limits:"),
							splitLayout(
								numericInput( "xMinVLC", "X min", value = "NULL", step = 0.01 ),
								numericInput( "xMaxVLC", "X max", value = "NULL", step = 0.01 ),
								numericInput( "yMinVLC", "Y min", value = "NULL", step = 0.01 ),
								numericInput( "yMaxVLC", "Y max", value = "NULL", step = 0.01 )
							),
							h4("Cutoffs:"),
							splitLayout(
								numericInput( "lfcCutoffVLC",     "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffVLC",     "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffVLC",     "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								numericInput( "fdrSaturationVLC", "-log(FDR) sat", value = "NULL", min = 0, max = 1000, step = 1 )
							),
							br(),hr(),
							h4("Highlight genes:"),
							splitLayout(
								checkboxInput( "hGenesVLC",     "Highlight",   value = F ),
								checkboxInput( "hLabelsVLC",    "Labels",      value = F ),
								"",""
							),
							splitLayout(
								numericInput(  "hPointSizeVLC", "Symbol Size",    value = 2, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "hLabelSizeVLC", "Text Size",      value = 5, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "lNudgeXVLC",    "Left position",  value = 1, min = 0,   max = 50, step = 0.2 ),
								numericInput(  "rNudgeXVLC",    "Right position", value = 1, min = 0,   max = 50, step = 0.2 )
							),
							h5("Select pasted genes:"),
							textAreaInput( "lGenesVLC", NULL, rows = 12, placeholder = "Paste gene list here" ),
							h5("Select genes invididually:"),
							uiOutput( "geneSelectionVLC" ),
							h5("Select genes by cutoff:"),
							splitLayout(
								numericInput( "lfcCutoffHVLC", "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffHVLC", "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffHVLC", "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								""
							),
							br(),
							hr(),
							h4("Box and symbols:"),
							splitLayout(
								checkboxInput( "boxSwitchVLC",  "Box",         value = T ),
								numericInput(  "lineWidthVLC",  "Line width",  value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput(  "symbolSizeVLC", "Symbol size", value = 2, min = 0.5, max = 10, step = 0.1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/volcano.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotVLC{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonVLC", "Plot"),
									downloadButton( "downloadPlotVLC", "Save Plot")
								),
								hr(),
								uiOutput("plotVLC")
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
	observeEvent( input$homeButtonVLC, {
		showNotification( "Volcano button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Volcano")
	})

	valuesVLC = reactiveValues()

	output$tabVLC  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	highlightGenes = reactiveValues()
	observe({
		curDate   = date()
		sessionId = session$token
		write( paste("[volcano |",curDate,"|",sessionId,"] Getting gene list from data"), file=stderr())

		# Find input source (if any)
		if( is.null( input$dataFileVLC )){
			if( input$exampleVLC ){
				dataFile = "lib/examples/VLC.txt"
			}else{
				return(NULL)
			}
		}else{
			dataFile = input$dataFileVLC$datapath
		}

		# Load data
		iData = read.table( dataFile, header = T, sep = "\t", colClasses = "character", check.names = F )

		# Cutoffs
		lfcCutoff = input$lfcCutoffVLC # Left  (negative)
		rfcCutoff = input$rfcCutoffVLC # Right (positive)
		fdrCutoff = input$fdrCutoffVLC

		# Filter data using cutoffs
		numSelect = 5000
		upGenes   = head(iData[,1],numSelect)
		downGenes = tail(iData[,1],numSelect)

		# Get Gene list from data
		highlightGenes$names = c(upGenes,downGenes)
		numGenes = length(highlightGenes$names)
		write( paste("[volcano |",curDate,"|",sessionId,"]   Number of genes selected:",numGenes), file=stderr())
		write( paste("[volcano |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr())
	})
	
	output$geneSelectionVLC = renderUI({
		selectInput( "geneNamesVLC", NULL, c("Gene name here"='', highlightGenes$names), multiple = T, selectize = T )
	})

	output$plotVLC = renderUI({
		plotOutput(
			"plotOutVLC",
			width  = input$widthVLC,
			height = input$heightVLC
		)
	})

	output$plotColorsVLC = renderUI({
		plotOutput(
			"plotOutColorsVLC",
			width  = paletteWidthVLC(),
			height = paletteHeightVLC()
		)
	})

	output$paletteSelectorVLC = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vc-Gray", "Vc-Green", "Vc-Red" )
		selections = c()
		if( !is.null(input$colorFileVLC) ){
			colorData2 = read.table( input$colorFileVLC$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteVLC",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutVLC = renderPlot({
		input$goButtonVLC
		isolate({
			# Plot data or example
			colorFile = input$colorFileVLC
			if( is.null( input$dataFileVLC )){
				if( input$exampleVLC ){
					dataFile = "lib/examples/VLC.txt"
					source("lib/volcano.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileVLC$datapath
				source("lib/volcano.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthVLC = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightVLC = function(){
		colorFile = input$colorFileVLC
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileVLC$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteVLC )){
			for( pattern in input$paletteVLC ){
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

	output$plotOutColorsVLC = renderPlot({
		colorFile = input$colorFileVLC
		palette   = input$paletteVLC
		indColors = input$indColorsVLC
		source("lib/colorPalette.R", local = TRUE)
		valuesVLC$colors = colors
	})

	output$downloadPlotVLC <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVLC )){
				outFile = gsub( ".*/", "", input$dataFileVLC )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthVLC  / 72,
				height = input$heightVLC / 72
			)
			dataFile = "lib/examples/VLC.txt"
			if( !is.null( input$dataFileVLC )){
				dataFile = input$dataFileVLC$datapath
			}
			sourcePlot( "lib/volcano.R", dataFile, input$colorFileVLC, input$paletteVLC )
			dev.off()
		}
	)

	output$downloadGenesVLC <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVLC )){
				outFile = gsub( ".*/", "", input$dataFileVLC )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".txt", sep = "" )
		},
		content = function( file ){
			dataFile = "lib/examples/VLC.txt"
			if( !is.null( input$dataFileVLC )){
				dataFile = input$dataFileVLC$datapath
			}
			source( "lib/volcanoGenes.R", local = TRUE )
		}
	)
[END SRVPLOT]
