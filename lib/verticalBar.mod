[START UIPLOT]
		tabPanel( "Vertical Bar",
			sidebarLayout(
				sidebarPanel(
					h3("Vertical Bar"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileBAR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileBAR" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleBAR", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsBAR"),
					br(),
#					colourInput( "palette", "Select color", "#FFFFFF" ),
					tags$script('$( "#colorFileBAR" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorBAR"),
					fileInput( "colorFileBAR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					br(),hr(),
					h4("Dimensions:"),
					splitLayout(
						numericInput( "widthBAR",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightBAR", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					h4("Main title and labels:"),
					textInput( "titleBAR",  NULL, placeholder = "Main title here" ),
					splitLayout(
						numericInput( "titleSizeBAR", "Title size",  value = 30, min = 5, max = 50,  step = 1 ),
						numericInput( "labelSizeBAR", "Label size",  value = 25, min = 5, max = 50,  step = 1 ),
						numericInput( "scaleSizeBAR", "Scale size",  value = 20, min = 5, max = 50,  step = 1 ),
						numericInput( "xAngleBAR",    "Label angle", value = 0,  min = 0, max = 180, step = 30 )
					),
					h4("Select data to plot:"),
					uiOutput( "xDataSelBAR" ),
					uiOutput( "yDataSelBAR" ),
					uiOutput( "gDataSelBAR" ),
					h4("Bar options:"),
					splitLayout(
						checkboxInput( "stackColumnsBAR", "Stack cols",   value = T ),
						checkboxInput( "normStackBAR",    "Stack norm",   value = T ),
						"",""
					),
					splitLayout(
						numericInput( "barSpaceBAR",  "Bar space",  value = 0, min = 0,   max = 5,  step = 0.1 ),
						numericInput( "barWidthBAR",  "Bar width",  value = 1, min = 0,   max = 5,  step = 0.1 ),
						numericInput( "lineWidthBAR", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
						""
					),
					h4("Error bars:"),
					checkboxInput( "errorPresentBAR", "Error bars in file", value = F ),
					splitLayout(
						checkboxInput( "errorUpBAR",   "Up bars",    value = T ),
						checkboxInput( "errorDownBAR", "Down bars",  value = T ),
						"",""
					),
					splitLayout(
						numericInput( "errorWidthBAR",  "Thickness", value = 2.5, min = 1.0,  max = 10, step = 0.1 ),
						numericInput( "errorLengthBAR", "Width",     value = 0.1, min = 0.01, max = 1,  step = 0.02 ),
						"",""
					),
					h4("Legend:"),
					splitLayout(
						checkboxInput( "legendSwitchBAR", "Legend" ),
						numericInput(  "legendSizeBAR",   "Size", value = 15, min = 5, max = 50, step = 1 ),
						"",""
					),
					h4("Add horizontal line:"),
					splitLayout(
						numericInput( "linePositionBAR", "Y pos",  value = 0, min = NA,  max = NA, step = 1 ),
						numericInput( "line2WidthBAR",   "Width",  value = 4, min = 0.5, max = 10, step = 0.1 ),
						"",""
					)
				),

				mainPanel(
					tags$style(HTML("#plotBAR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonBAR", "Plot"),
									downloadButton( "downloadPlotBAR", "Save Plot")
								),
								hr(),
								uiOutput("plotBAR")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/verticalBar.md" )
							)
						)
					)
				)
			)
		)
[END UIPLOT]

[START SRVPLOT]
	observeEvent( input$homeButtonBAR, {
		showNotification( "Vertical Bar button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Vertical Bar")
	})

	valuesBAR = reactiveValues()

	observe({
		dataFile = "lib/examples/BAR.txt"
		if( ! is.null( input$dataFileBAR )){
			dataFile = input$dataFileBAR$datapath
		}
		dataTable        = read.table( dataFile, header=T, sep="\t", check.names=F, nrows=2 )
		valuesBAR$header = colnames( dataTable )
	})

	output$xDataSelBAR = renderUI({
		selectInput( "xVarBAR", 'X variable',     valuesBAR$header, select=valuesBAR$header[1], selectize=T )
	})
	output$yDataSelBAR = renderUI({
		selectInput( "yVarBAR", 'Y variable',     valuesBAR$header, select=valuesBAR$header[-1], selectize=T )
	})
	output$gDataSelBAR = renderUI({
		selectInput( "gVarBAR", 'Group variable', valuesBAR$header, select=valuesBAR$header[1], selectize=T )
	})

	output$tabBAR  = renderText({ input$plotTab })

	output$plotBAR = renderUI({
		plotOutput(
			"plotOutBAR",
			width  = input$widthBAR,
			height = input$heightBAR
		)
	})

	output$plotColorsBAR = renderUI({
		plotOutput(
			"plotOutColorsBAR",
			width  = paletteWidthBAR(),
			height = paletteHeightBAR()
		)
	})

	output$plotOutBAR = renderPlot({
		input$goButtonBAR
		isolate({
			# Plot data or example
			colorFile = input$colorFileBAR
			if( is.null( input$dataFileBAR )){
				if( input$exampleBAR ){
					dataFile = "lib/examples/BAR.txt"
					source("lib/verticalBar.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileBAR$datapath
				source("lib/verticalBar.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	output$plotOutColorsBAR = renderPlot({
		colorFile = input$colorFileBAR
		palette   = input$paletteBAR
		source("lib/colorPalette.R", local = TRUE)
		valuesBAR$colors = colors
	})

	output$paletteSelectorBAR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileBAR) ){
			colorData2 = read.table( input$colorFileBAR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteBAR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	paletteWidthBAR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightBAR = function(){
		colorFile = input$colorFileBAR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileBAR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteBAR )){
			for( pattern in input$paletteBAR ){
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

	output$downloadPlotBAR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileBAR )){
				outFile = gsub( ".*/", "", input$dataFileBAR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthBAR  / 72,
				height = input$heightBAR / 72
			)
			dataFile = "lib/examples/BAR.txt"
			if( !is.null( input$dataFileBAR )){
				dataFile = input$dataFileBAR$datapath
			}
			sourcePlot( "lib/verticalBar.R", dataFile, input$colorFileBAR, input$paletteBAR )
			dev.off()
		}
	)
[END SRVPLOT]
