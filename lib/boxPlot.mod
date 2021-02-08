[START UIPLOT]
		tabPanel( "Box Plot",
			sidebarLayout(
				sidebarPanel(
					h3("Box Plot"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileBOX",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileBOX" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleBOX", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsBOX"),
					br(),
					tags$script('$( "#colorFileBOX" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorBOX"),
					fileInput( "colorFileBOX", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					br(),hr(),
					splitLayout(
						h4("Dimensions:"),
						numericInput( "widthBOX",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightBOX", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					h4("Main title and labels:"),
					textInput( "titleBOX",  NULL, placeholder = "Main title here" ),
					splitLayout(
						numericInput( "titleSizeBOX", "Title size",  value = 30, min = 5, max = 50,  step = 1 ),
						numericInput( "labelSizeBOX", "Label size",  value = 25, min = 5, max = 50,  step = 1 ),
						numericInput( "scaleSizeBOX", "Scale size",  value = 20, min = 5, max = 50,  step = 1 ),
						numericInput( "xAngleBOX",    "Label angle", value = 0,  min = 0, max = 180, step = 30 )
					),
					h4("Select data to plot:"),
					uiOutput( "xDataSelBOX" ),
					uiOutput( "yDataSelBOX" ),
					uiOutput( "gDataSelBOX" ),
					h4("Box Options:"),
					splitLayout(
						numericInput(  "lineWidthBOX",   "Line width", value = 4,   min = 0.5, max = 10, step = 0.1 ),
						numericInput(  "whiskerPercBOX", "Whiskers %", value = 1.5, min = 0,   max = 10, step = 0.1 ),
						numericInput(  "meanSizeBOX",    "Mean size",  value = 1.5, min = 0,   max = 10, step = 0.05 ),
						""
					),
					splitLayout(
						checkboxInput( "whiskersBOX", "Whiskers", value = T ),
						checkboxInput( "notchBOX",    "Notched",  value = F ),
						checkboxInput( "outliersBOX", "Outliers", value = F ),
						""
					),
					splitLayout(
						numericInput( "lineTypeBOX",   "Line Type",   value = 1,  min = 0,   max = 6,  step = 1 ),
						numericInput( "symbolTypeBOX", "Symbol type", value = 19, min = 0,   max = 25, step = 1 ),
						numericInput( "symbolSizeBOX", "Size",        value = 2,  min = 0.5, max = 10, step = 0.1 ),
						""
					),
					h4("Legend:"),
					splitLayout(
						numericInput( "legendSizeBOX", "Size", value = 15, min = 5, max = 50, step = 1 ),
						"","",""
					)
				),

				mainPanel(
					tags$style(HTML("#plotBOX{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonBOX", "Plot"),
									downloadButton( "downloadPlotBOX", "Save Plot")
								),
								hr(),
								uiOutput("plotBOX")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/boxPlot.md" )
							)
						)
					)
				)
			)
		)
[END UIPLOT]

[START SRVPLOT]
	observeEvent( input$homeButtonBOX, {
		showNotification( "Box Plot button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Box Plot")
	})

	valuesBOX = reactiveValues()

	observe({
		dataFile = "lib/examples/BOX.txt"
		if( ! is.null( input$dataFileBOX )){
			dataFile = input$dataFileBOX$datapath
		}
		dataTable        = read.table( dataFile, header=T, sep="\t", check.names=F, nrows=2 )
		valuesBOX$header = colnames( dataTable )
	})

	output$xDataSelBOX = renderUI({
		selectInput( "xVarBOX", 'X variable',     valuesBOX$header, select=valuesBOX$header[1], selectize=T )
	})
	output$yDataSelBOX = renderUI({
		selectInput( "yVarBOX", 'Y variable',     valuesBOX$header, select=valuesBOX$header[-1], selectize=T )
	})
	output$gDataSelBOX = renderUI({
		selectInput( "gVarBOX", 'Group variable', valuesBOX$header, select=valuesBOX$header[1], selectize=T )
	})

	output$plotBOX = renderUI({
		plotOutput(
			"plotOutBOX",
			width  = input$widthBOX,
			height = input$heightBOX
		)
	})

	output$plotColorsBOX = renderUI({
		plotOutput(
			"plotOutColorsBOX",
			width  = paletteWidthBOX(),
			height = paletteHeightBOX()
		)
	})

	output$paletteSelectorBOX = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileBOX) ){
			colorData2 = read.table( input$colorFileBOX$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteBOX",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutBOX = renderPlot({
		input$goButtonBOX
		isolate({
			# Plot data or example
			colorFile = input$colorFileBOX
			if( is.null( input$dataFileBOX )){
				if( input$exampleBOX ){
					dataFile = "lib/examples/BOX.txt"
					source("lib/boxPlot.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileBOX$datapath
				source("lib/boxPlot.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthBOX = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightBOX = function(){
		colorFile = input$colorFileBOX
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileBOX$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteBOX )){
			for( pattern in input$paletteBOX ){
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

	output$plotOutColorsBOX = renderPlot({
		colorFile = input$colorFileBOX
		palette   = input$paletteBOX
		source("lib/colorPalette.R", local = TRUE)
		valuesBOX$colors = colors
	})

	output$downloadPlotBOX <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileBOX )){
				outFile = gsub( ".*/", "", input$dataFileBOX )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthBOX  / 72,
				height = input$heightBOX / 72
			)
			dataFile = "lib/examples/BOX.txt"
			if( !is.null( input$dataFileBOX )){
				dataFile = input$dataFileBOX$datapath
			}
			sourcePlot( "lib/boxPlot.R", dataFile, input$colorFileBOX, input$paletteBOX )
			dev.off()
		}
	)
[END SRVPLOT]
