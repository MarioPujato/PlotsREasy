[START UIPLOT]
		tabPanel( "Bee Swarm",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabBSW")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileBSW",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileBSW" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleBSW", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsBSW"),
							br(),
							fileInput( "colorFileBSW", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileBSW" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorBSW")
						),
						tabPanel( "Options",
							br(),
							splitLayout(
								h4("Dimensions:"),
								numericInput( "widthBSW",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightBSW", "Height", value = 600, min = 300, max = 2400, step = 50 )
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarBSW", "Bottom", value = 1.5, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarBSW",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarBSW",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarBSW",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							h4("Main title and labels:"),
							textInput( "titleBSW",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelBSW", NULL, placeholder = "X label here" ),
							textInput( "yLabelBSW", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeBSW",  "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "xLabelSizeBSW", "Xlab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yLabelSizeBSW", "Ylab size",  value = 2.5, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "scaleSizeBSW",  "Scale size", value = 2.0, min = 0.5, max = 10, step = 0.1 )
							),
							splitLayout(
								numericInput( "yYlabelBSW",  "Ylab pos",  value = 0.01, min = 0,    max = 1,   step = 0.01 ),
								numericInput( "xXlabel1BSW", "Xlab1 pos", value = 0.15, min = 0,    max = 1,   step = 0.01 ),
								numericInput( "xLabDirBSW",  "Xlab1 dir", value = 90,   min = -180, max = 180, step = 15 ),
								numericInput( "xXlabel2BSW", "Xlab2 pos", value = 0.02, min = 0,    max = 1,   step = 0.01 )
							),
							h4("Scales:"),
							splitLayout(
								numericInput( "xScalePosBSW", "XScale pos", value = 0.3,     min = -10, max = 10, step = 0.01 ),
								numericInput( "yScalePosBSW", "YScale pos", value = 0.0,     min = -10, max = 10, step = 0.01 ),
								numericInput( "yMinBSW",      "Y min",      value = "NULL", step = 0.1 ),
								numericInput( "yMaxBSW",      "Y max",      value = "NULL", step = 0.1 )
							),
							h4("Options:"),
							splitLayout(
								checkboxInput( "boxSwitchBSW", "Box", value = T ),
								numericInput( "boxTypeBSW",    "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								numericInput( "lineWidthBSW",  "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								""
							),
							splitLayout(
								numericInput(  "symbolTypeBSW", "Symbol type", value = 19, min = 0,   max = 25, step = 1 ),
								numericInput(  "symbolSizeBSW", "Size",        value = 2,  min = 0.5, max = 10, step = 0.1 ),
								checkboxInput( "seqSymbolsBSW", "Sequential" ),
								""
							),
							splitLayout(
								numericInput(  "methodTypeBSW", "Method",   value = 1, min = 1, max = 4, step = 1 ),
								checkboxInput( "boxBSW",        "Box",      value = F ),
								checkboxInput( "whiskersBSW",   "Whiskers", value = F ),
								checkboxInput( "notchBSW",      "Notched",  value = F )
							),
							splitLayout(
								h4("Legend:"),
								checkboxInput( "legendSwitchBSW", "Legend" ),
								checkboxInput( "legendTypeBSW",   "Horizontal" ),
								""
							),
							splitLayout(
								numericInput( "legendSizeBSW", "Size",  value = 1.5,  min = 0.1, max = 2, step = 0.05 ),
								numericInput( "xLegendBSW",    "X pos", value = 0.8,  min = 0,   max = 1, step = 0.01 ),
								numericInput( "yLegendBSW",    "Y pos", value = 0.05, min = 0,   max = 1, step = 0.01 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/beeSwarm.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotBSW{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonBSW", "Plot"),
									downloadButton( "downloadPlotBSW", "Save Plot")
								),
								hr(),
								uiOutput("plotBSW")
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
	observeEvent( input$homeButtonBSW, {
		showNotification( "Bee Swarm button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Bee Swarm")
	})

	valuesBSW = reactiveValues()

	output$tabBSW  = renderText({ input$plotTab })

	output$plotBSW = renderUI({
		plotOutput(
			"plotOutBSW",
			width  = input$widthBSW,
			height = input$heightBSW
		)
	})

	output$plotColorsBSW = renderUI({
		plotOutput(
			"plotOutColorsBSW",
			width  = paletteWidthBSW(),
			height = paletteHeightBSW()
		)
	})

	output$paletteSelectorBSW = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileBSW) ){
			colorData2 = read.table( input$colorFileBSW$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteBSW",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutBSW = renderPlot({
		input$goButtonBSW
		isolate({
			# Plot data or example
			colorFile = input$colorFileBSW
			if( is.null( input$dataFileBSW )){
				if( input$exampleBSW ){
					dataFile = "lib/examples/BSW.txt"
					source("lib/beeSwarm.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileBSW$datapath
				source("lib/beeSwarm.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthBSW = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightBSW = function(){
		colorFile = input$colorFileBSW
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileBSW$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteBSW )){
			for( pattern in input$paletteBSW ){
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

	output$plotOutColorsBSW = renderPlot({
		colorFile = input$colorFileBSW
		palette   = input$paletteBSW
		source("lib/colorPalette.R", local = TRUE)
		valuesBSW$colors = colors
	})

	output$downloadPlotBSW <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileBSW )){
				outFile = gsub( ".*/", "", input$dataFileBSW )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthBSW  / 72,
				height = input$heightBSW / 72
			)
			dataFile = "lib/examples/BSW.txt"
			if( !is.null( input$dataFileBSW )){
				dataFile = input$dataFileBSW$datapath
			}
			sourcePlot( "lib/beeSwarm.R", dataFile, input$colorFileBSW, input$paletteBSW )
			dev.off()
		}
	)
[END SRVPLOT]
