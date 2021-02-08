[START UIPLOT]
		tabPanel( "Horizontal Bars",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabHOR")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileHOR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileHOR" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleHOR", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsHOR"),
							br(),
							fileInput( "colorFileHOR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileHOR" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorHOR")
						),
						tabPanel( "Options",
							br(),
							splitLayout(
								h4("Dimensions:"),
								numericInput( "widthHOR",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightHOR", "Height", value = 600, min = 300, max = 2400, step = 50 )
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarHOR", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarHOR",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarHOR",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarHOR",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							h4("Main title and labels:"),
							textInput( "titleHOR",  NULL, placeholder = "Main title here" ),
							textInput( "YLabelHOR", NULL, placeholder = "Y label here" ),
							textInput( "XLabelHOR", NULL, placeholder = "X label here" ),
							splitLayout(
								numericInput( "titleSizeHOR",  "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "XLabelSizeHOR", "Xlab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "YLabelSizeHOR", "Ylab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "scaleSizeHOR",  "Scale size", value = 2.0, min = 0.5, max = 10, step = 0.1 )
							),
							splitLayout(
								numericInput( "yXLabelHOR",  "Xlab pos",  value = 0.01, min = 0,    max = 1,   step = 0.01 ),
								numericInput( "xYLabel1HOR", "Ylab1 pos", value = 0.10, min = 0,    max = 1,   step = 0.01 ),
								numericInput( "YLabDirHOR",  "Ylab1 dir", value = 0,    min = -180, max = 180, step = 15 ),
								numericInput( "xYLabel2HOR", "Ylab2 pos", value = 0.02, min = 0,    max = 1,   step = 0.01 )
							),
							h4("Scales:"),
							splitLayout(
								numericInput( "xMinHOR", "X min", value = "NULL", step = 0.1 ),
								numericInput( "xMaxHOR", "X max", value = "NULL", step = 0.1 ),
								"",
								""
							),
							h4("Bar spacing:"),
							splitLayout(
								numericInput( "barSpaceHOR",   "Bar space",   value = 0.0, min = 0, max = 1, step = 0.05 ),
								numericInput( "groupSpaceHOR", "Group space", value = 0.4, min = 0, max = 1, step = 0.05 ),
								"",
								""
							),
							h4("Options:"),
							splitLayout(
								numericInput( "XOffsetHOR", "X offset", value = 0, min = 0 ),
								"",
								"",
								""
							),
							splitLayout(
								checkboxInput( "boxSwitchHOR", "Box",        value = T ),
								numericInput(  "boxTypeHOR",   "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								numericInput(  "lineWidthHOR", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								""
							),
							splitLayout(
								checkboxInput( "stackColumnsHOR", "Stack columns", value = F ),
								checkboxInput( "groupSwitchHOR",  "Group labels",  value = T ),
								checkboxInput( "barBordersHOR",   "Bar borders",   value = T ),
								""
							),
							splitLayout(
								numericInput( "lineWidthHOR", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "boxTypeHOR",   "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								"",
								""
							),
							h4("Error bars:"),
							checkboxInput( "errorPresentHOR", "Error bars in file", value = F ),
							splitLayout(
								checkboxInput( "errorUpHOR",   "Up bars",    value = T ),
								checkboxInput( "errorDownHOR", "Down bars",  value = T ),
								"",
								""
							),
							splitLayout(
								numericInput( "errorWidthHOR",  "Thickness", value = 2.5, min = 1.0,  max = 10, step = 0.1 ),
								numericInput( "errorLengthHOR", "Width",     value = 0.1, min = 0.01, max = 1,  step = 0.02 ),
								"",
								""
							),
							h4("Legend:"),
							splitLayout(
								checkboxInput( "legendSwitchHOR", "Legend" ),
								checkboxInput( "legendTypeHOR",   "Horizontal" ),
								"",
								""
							),
							splitLayout(
								numericInput( "legendSizeHOR", "Size",  value = 1.5,  min = 0.1, max = 2, step = 0.05 ),
								numericInput( "xLegendHOR",    "X pos", value = 0.80, min = 0,   max = 1, step = 0.01 ),
								numericInput( "yLegendHOR",    "Y pos", value = 0.86, min = 0,   max = 1, step = 0.01 ),
								""
							),
							h4("Add horizontal line:"),
							splitLayout(
								checkboxInput( "switchLineHOR",  "H line", value = F ),
								numericInput( "linePositionHOR", "Y pos",  value = 0, min = NA,  max = NA, step = 1 ),
								numericInput( "lineTypeHOR",     "Type",   value = 2, min = 1,   max = 6,  step = 1 ),
								numericInput( "line2WidthHOR",   "Width",  value = 4, min = 0.5, max = 10, step = 0.1 )
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/horizontalBar.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotHOR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonHOR", "Plot"),
									downloadButton( "downloadPlotHOR", "Save Plot")
								),
								hr(),
								uiOutput("plotHOR")
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
	observeEvent( input$homeButtonHOR, {
		showNotification( "Horizontal Bars button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Horizontal Bars")
	})

	valuesHOR = reactiveValues()

	output$tabHOR  = renderText({ input$plotTab })

	output$plotHOR = renderUI({
		plotOutput(
			"plotOutHOR",
			width  = input$widthHOR,
			height = input$heightHOR
		)
	})

	output$plotColorsHOR = renderUI({
		plotOutput(
			"plotOutColorsHOR",
			width  = paletteWidthHOR(),
			height = paletteHeightHOR()
		)
	})

	output$paletteSelectorHOR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileHOR) ){
			colorData2 = read.table( input$colorFileHOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteHOR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutHOR = renderPlot({
		input$goButtonHOR
		isolate({
			# Plot data or example
			colorFile = input$colorFileHOR
			if( is.null( input$dataFileHOR )){
				if( input$exampleHOR ){
					dataFile = "lib/examples/HOR.txt"
					source("lib/horizontalBar.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileHOR$datapath
				source("lib/horizontalBar.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthHOR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightHOR = function(){
		colorFile = input$colorFileHOR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileHOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteHOR )){
			for( pattern in input$paletteHOR ){
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

	output$plotOutColorsHOR = renderPlot({
		colorFile = input$colorFileHOR
		palette   = input$paletteHOR
		source("lib/colorPalette.R", local = TRUE)
		valuesHOR$colors = colors
	})

	output$downloadPlotHOR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileHOR )){
				outFile = gsub( ".*/", "", input$dataFileHOR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthHOR  / 72,
				height = input$heightHOR / 72
			)
			dataFile = "lib/examples/HOR.txt"
			if( !is.null( input$dataFileHOR )){
				dataFile = input$dataFileHOR$datapath
			}
			sourcePlot( "lib/horizontalBar.R", dataFile, input$colorFileHOR, input$paletteHOR )
			dev.off()
		}
	)
[END SRVPLOT]
