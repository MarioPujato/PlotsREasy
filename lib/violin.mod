[START UIPLOT]
		tabPanel( "Violin",
			sidebarLayout(
				sidebarPanel(
					h3("Violin"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileVIO",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileVIO" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleVIO", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsVIO"),
					br(),
					tags$script('$( "#colorFileVIO" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorVIO"),
					fileInput( "colorFileVIO", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					br(),
					h4("Dimensions:"),
					splitLayout(
						numericInput( "widthVIO",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightVIO", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					h4("Main title and labels:"),
					textInput( "titleVIO",  NULL, placeholder = "Main title here" ),
					textInput( "xLabelVIO", NULL, placeholder = "log2(Fold Change)" ),
					textInput( "yLabelVIO", NULL, placeholder = "-log10(FDR)" ),
					splitLayout(
						numericInput( "titleSizeVIO", "Title size",  value = 35, min = 1, max = 50,  step = 1 ),
						numericInput( "scaleSizeVIO", "Scale size",  value = 20, min = 1, max = 50,  step = 1 ),
						numericInput( "labelSizeVIO", "Label size",  value = 25, min = 1, max = 50,  step = 1 ),
						numericInput( "xAngleVIO",    "Label angle", value = 0,  min = 0, max = 180, step = 30 )
					),
					h4("Select data to plot:"),
					uiOutput( "xDataSelVIO" ),
					uiOutput( "yDataSelVIO" ),
					uiOutput( "gDataSelVIO" ),
					h4("Options:"),
					splitLayout(
						numericInput(  "lineWidthVIO", "Size", value = 4, min = 0, max = 10, step = 1 ),
						"","",""
					),
					h4("Legend:"),
					splitLayout(
						checkboxInput( "legendSwitchVIO", "Legend" ),
						numericInput(  "legendSizeVIO",   "Size", value = 15, min = 5, max = 50, step = 1 ),
						"",""
					),
					h4("Add horizontal line:"),
					splitLayout(
						numericInput( "linePositionVIO", "Y pos", value = 0, min = NA,  max = NA, step = 1 ),
						numericInput( "line2WidthVIO",   "Width", value = 4, min = 0.5, max = 10, step = 0.1 ),
						"",""
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
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/violin.md" )
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

	observe({
		dataFile = "lib/examples/VIO.txt"
		if( ! is.null( input$dataFileVIO )){
			dataFile = input$dataFileVIO$datapath
		}
		dataTable        = read.table( dataFile, header=T, sep="\t", check.names=F, nrows=2 )
		valuesVIO$header = colnames( dataTable )
	})

	output$xDataSelVIO = renderUI({
		selectInput( "xVarVIO", 'X variable',     valuesVIO$header, select=valuesVIO$header[1],  selectize=T )
	})
	output$yDataSelVIO = renderUI({
		selectInput( "yVarVIO", 'Y variable',     valuesVIO$header, select=valuesVIO$header[-1], selectize=T )
	})
	output$gDataSelVIO = renderUI({
		selectInput( "gVarVIO", 'Group variable', valuesVIO$header, select=valuesVIO$header[1],  selectize=T )
	})

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
		mySelected = c( "FR-Blue", "FR-Green", "FR-Orange", "FR-Yellow", "FR-Red" )
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
