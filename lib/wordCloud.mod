[START UIPLOT]
		tabPanel( "Word Cloud",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabWCL")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileWCL",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileWCL" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleWCL", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsWCL"),
							br(),
							fileInput( "colorFileWCL", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileWCL" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorWCL")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							br(),
							splitLayout(
								numericInput( "widthWCL",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightWCL", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",
								""
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarWCL", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarWCL",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarWCL",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarWCL",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							textInput( "titleWCL", NULL, placeholder = "Main title here" ),
							splitLayout(
								numericInput( "titleSizeWCL", "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yTitleWCL",    "Title pos",  value = 0.99, min = 0,   max = 1,  step = 0.01 ),
								"",
								""
							),
							h4("Options:"),
							splitLayout(
								checkboxInput( "fadingWCL",   "Fading",    value = T ),
								checkboxInput( "boldFontWCL", "Bold font", value = F ),
								"",
								""
							),
							splitLayout(
								numericInput(  "centerValueWCL", "Center val", value = 10,  min  = 0, step = 0.5 ),
								numericInput(  "minSizeWCL",     "Min size",   value = 0.7, step = 0.1 ),
								numericInput(  "maxSizeWCL",     "Max size",   value = 3.0, step = 0.1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/wordCloud.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotWCL{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonWCL", "Plot"),
									downloadButton( "downloadPlotWCL", "Save Plot")
								),
								hr(),
								uiOutput("plotWCL")
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
	observeEvent( input$homeButtonWCL, {
		showNotification( "Word Cloud button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Word Cloud")
	})

	valuesWCL = reactiveValues()

	output$tabWCL  = renderText({ input$plotTab })

	output$plotWCL = renderUI({
		plotOutput(
			"plotOutWCL",
			width  = input$widthWCL,
			height = input$heightWCL
		)
	})

	output$plotColorsWCL = renderUI({
		plotOutput(
			"plotOutColorsWCL",
			width  = paletteWidthWCL(),
			height = paletteHeightWCL()
		)
	})

	output$paletteSelectorWCL = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileWCL) ){
			colorData2 = read.table( input$colorFileWCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteWCL",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutWCL = renderPlot({
		input$goButtonWCL
		isolate({
			# Plot data or example
			colorFile = input$colorFileWCL
			if( is.null( input$dataFileWCL )){
				if( input$exampleWCL ){
					dataFile = "lib/examples/WCL.txt"
					source("lib/wordCloud.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileWCL$datapath
				source("lib/wordCloud.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthWCL = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightWCL = function(){
		colorFile = input$colorFileWCL
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileWCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteWCL )){
			for( pattern in input$paletteWCL ){
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

	output$plotOutColorsWCL = renderPlot({
		colorFile = input$colorFileWCL
		palette   = input$paletteWCL
		source("lib/colorPalette.R", local = TRUE)
		valuesWCL$colors = colors
	})

	output$downloadPlotWCL <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileWCL )){
				outFile = gsub( ".*/", "", input$dataFileWCL )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthWCL  / 72,
				height = input$heightWCL / 72
			)
			dataFile = "lib/examples/WCL.txt"
			if( !is.null( input$dataFileWCL )){
				dataFile = input$dataFileWCL$datapath
			}
			sourcePlot( "lib/wordCloud.R", dataFile, input$colorFileWCL, input$palette011 )
			dev.off()
		}
	)
[END SRVPLOT]
