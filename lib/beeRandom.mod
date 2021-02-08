[START UIPLOT]
		tabPanel( "Bee Random",
			sidebarLayout(
				sidebarPanel(
					h3("Bee Random"),
					br(),hr(),
					h4("Data file:"),
					tags$script('$( "#dataFileBRN" ).on( "click", function() { this.value = null; });'),
					fileInput( "dataFileBRN",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					checkboxInput( "exampleBRN", "Load example", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsBRN"),
					br(),
					colourInput( "palette", "Select color", "#FFFFFF" ),
					tags$script('$( "#colorFileBRN" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorBRN"),
					fileInput( "colorFileBRN", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					br(),hr(),
					splitLayout(
						h4("Dimensions:"),
						numericInput( "widthBRN",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightBRN", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					hr(),
					h4("Margins:"),
					splitLayout(
						numericInput( "bottomMarBRN", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
						numericInput( "leftMarBRN",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
						numericInput( "upperMarBRN",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
						numericInput( "rightMarBRN",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
					),
					hr(),
					h4("Main title and labels:"),
					textInput( "titleBRN",  NULL, placeholder = "Main title here" ),
					textInput( "yLabelBRN", NULL, placeholder = "Y label here" ),
					splitLayout(
						numericInput( "titleSizeBRN",  "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
						numericInput( "xLabelSizeBRN", "Xlab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
						numericInput( "yLabelSizeBRN", "Ylab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
						numericInput( "scaleSizeBRN",  "Scale size", value = 2.0, min = 0.5, max = 10, step = 0.1 )
					),
					splitLayout(
						numericInput( "xXlabelBRN", "Xlab pos", value = 0.02, min = 0, max = 1,   step = 0.01 ),
						numericInput( "yYlabelBRN", "Ylab pos", value = 0.01, min = 0, max = 1,   step = 0.01 ),
						numericInput( "xLabDirBRN", "Xlab dir", value = 0,    min = 0, max = 360, step = 5 ),
						""
					),
					hr(),
					h4("Scales:"),
					splitLayout(
						numericInput( "xMinBRN", "X min", value = "NULL", step = 0.01 ),
						numericInput( "xMaxBRN", "X max", value = "NULL", step = 0.01 ),
						numericInput( "yMinBRN", "Y min", value = "NULL", step = 0.01 ),
						numericInput( "yMaxBRN", "Y max", value = "NULL", step = 0.01 )
					),
					hr(),
					h4("Options:"),
					splitLayout(
						checkboxInput( "boxSwitchBRN", "Box",        value = T ),
						numericInput(  "boxTypeBRN",   "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
						numericInput(  "lineWidthBRN", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
						""
					),
					splitLayout(
						numericInput( "distWidthBRN",  "Distr width",  value = 0.1, min = 0.05, max = 0.2, step = 0.05 ),
						numericInput( "trPickBRN",     "Transparency", value = 50,  min = 0,    max = 100, step = 1 ),
						numericInput( "symbolSizeBRN", "Symbol size",  value = 2,   min = 0.5,  max = 10,  step = 0.1 ),
						""
					),
					hr(),
					h4("Add horizontal line:"),
					splitLayout(
						checkboxInput( "switchLineBRN",  "H line", value = F ),
						numericInput( "linePositionBRN", "Y pos",  value = 0, min = NA,  max = NA, step = 1 ),
						numericInput( "lineTypeBRN",     "Type",   value = 2, min = 1,   max = 6,  step = 1 ),
						numericInput( "line2WidthBRN",   "Width",  value = 4, min = 0.5, max = 10, step = 0.1 )
					)
				),

				mainPanel(
					tags$style(HTML("#plotBRN{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonBRN", "Plot"),
									downloadButton( "downloadPlotBRN", "Save Plot")
								),
								hr(),
								uiOutput("plotBRN")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/beeRandom.md" )
							)
						)
					)
				)
			)
		)
[END UIPLOT]

[START SRVPLOT]
	observeEvent( input$homeButtonBRN, {
		showNotification( "Bee Random button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Bee Random")
	})

	valuesBRN = reactiveValues()

	output$plotBRN = renderUI({
		if( input$goButtonBRN > 0 ){
			isolate({
				shinyjs::disable("goButtonBRN")
				shinyjs::disable("downloadPlotBRN")
				notifBRN01 <<- showNotification( "Generating Bee Random plot ...", duration=10 )

				plotOutput(
					"plotOutBRN",
					width  = input$widthBRN,
					height = input$heightBRN
				)
			})
		}
	})

	output$plotOutBRN = renderPlot({
		if( input$goButtonBRN > 0 ){
			isolate({
				# Plot data or example
				colorFile = input$colorFileBRN
				if( is.null( input$dataFileBRN )){
					if( input$exampleBRN ){
						dataFile = "lib/examples/BRN.txt"
						source("lib/beeRandom.R", local = TRUE)
					}else{
						return(NULL)
					}
				}else{
					dataFile  = input$dataFileBRN$datapath
					source("lib/beeRandom.R", local = TRUE)
				}
			})
			removeNotification(notifBRN01)
			showNotification( "Finished Bee Random plot", duration=2 )
			shinyjs::enable("goButtonBRN")
			shinyjs::enable("downloadPlotBRN")
		}
	}, family = "Arial" )

	output$plotColorsBRN = renderUI({
		plotOutput(
			"plotOutColorsBRN",
			width  = paletteWidthBRN(),
			height = paletteHeightBRN()
		)
	})

	output$paletteSelectorBRN = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileBRN) ){
			colorData2 = read.table( input$colorFileBRN$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteBRN",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	paletteWidthBRN = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightBRN = function(){
		colorFile = input$colorFileBRN
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileBRN$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteBRN )){
			for( pattern in input$paletteBRN ){
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

	output$plotOutColorsBRN = renderPlot({
		colorFile = input$colorFileBRN
		palette   = input$paletteBRN
		source("lib/colorPalette.R", local = TRUE)
		valuesBRN$colors = colors
	})

	output$downloadPlotBRN = downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileBRN )){
				outFile = gsub( ".*/", "", input$dataFileBRN )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthBRN  / 72,
				height = input$heightBRN / 72
			)
			dataFile = "lib/examples/BRN.txt"
			if( !is.null( input$dataFileBRN )){
				dataFile = input$dataFileBRN$datapath
			}
			sourcePlot( "lib/beeRandom.R", dataFile, input$colorFileBRN, input$paletteBRN )
			dev.off()
		}
	)
[END SRVPLOT]
