[START UIPLOT]
		tabPanel( "Histogram",
			sidebarLayout(
				sidebarPanel(
					h3("Histogram"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileHIS",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileHIS" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleHIS", "Load example file", value = F ),
					br(),
					hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsHIS"),
					br(),
					tags$script('$( "#colorFileHIS" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorHIS"),
					fileInput( "colorFileHIS", NULL, placeholder = "Select file" ),
					br(),hr(),
					splitLayout(
						h4("Dimensions:"),
						numericInput( "widthHIS",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightHIS", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					br(),hr(),
					h4("Title:"),
					textInput( "titleHIS",  NULL, placeholder = "Main title here" ),
					splitLayout(
						numericInput( "titleSizeHIS", "Title size", value = 30, min = 5, max = 50, step = 1 ),
						numericInput( "labelSizeHIS", "Xlab size",  value = 25, min = 5, max = 50, step = 1 ),
						"",""
					),
					br(),hr(),
					h4("Scales:"),
					splitLayout(
						numericInput( "lineWidthHIS", "Line width", value = 4,  min = 0.5, max = 10, step = 0.1 ),
						numericInput( "scaleSizeHIS", "Scale size", value = 20, min = 5,   max = 50, step = 1 ),
						"",""
					),
					br(),hr(),
					h4("Options:"),
					splitLayout(
						numericInput( "binWidthHIS", "Bin width", value = 0.05, min = 0, max = 1, step = 0.01 ),
						"","",""
					),
					splitLayout(
						checkboxInput( "barBordersHIS", "Bar borders",  value = F ),
						checkboxInput( "densityHIS",    "Density area", value = F ),
						numericInput(  "alphaHIS",      "Transparency", value = 1, min = 0, max = 1,  step = 0.1 )
					),
					br(),hr(),
					h4("Legend:"),
					splitLayout(
						checkboxInput( "showLegendHIS", "Legend", value = F ),
						numericInput(  "legendSizeHIS", "Size",   value = 15, min = 2, max = 30, step = 1 ),
						"",""
					)
				),

				mainPanel(
					tags$style(HTML("#plotHIS{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonHIS", "Plot"),
									downloadButton( "downloadPlotHIS", "Save Plot")
								),
								hr(),
								uiOutput("plotHIS")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/histogram.md" )
							)
						)
					)
				)
			)
		)
[END UIPLOT]

[START SRVPLOT]
	observeEvent( input$homeButtonHIS, {
		showNotification( "Histogram button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Histogram")
	})

	valuesHIS = reactiveValues()

	output$plotHIS = renderUI({
		plotOutput(
			"plotOutHIS",
			width  = input$widthHIS,
			height = input$heightHIS
		)
	})

	output$plotColorsHIS = renderUI({
		plotOutput(
			"plotOutColorsHIS",
			width  = paletteWidthHIS(),
			height = paletteHeightHIS()
		)
	})

	output$paletteSelectorHIS = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileHIS) ){
			colorData2 = read.table( input$colorFileHIS$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteHIS",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutHIS = renderPlot({
		input$goButtonHIS
		isolate({
			# Plot data or example
			colorFile = input$colorFileHIS
			if( is.null( input$dataFileHIS )){
				if( input$exampleHIS ){
					dataFile = "lib/examples/HIS.txt"
					source("lib/histogram.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileHIS$datapath
				source("lib/histogram.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthHIS = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightHIS = function(){
		colorFile = input$colorFileHIS
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileHIS$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteHIS )){
			for( pattern in input$paletteHIS ){
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

	output$plotOutColorsHIS = renderPlot({
		colorFile = input$colorFileHIS
		palette   = input$paletteHIS
		source("lib/colorPalette.R", local = TRUE)
		valuesHIS$colors = colors
	})

	output$downloadPlotHIS <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileHIS )){
				outFile = gsub( ".*/", "", input$dataFileHIS )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthHIS  / 72,
				height = input$heightHIS / 72
			)
			dataFile = "lib/examples/HIS.txt"
			if( !is.null( input$dataFileHIS )){
				dataFile = input$dataFileHIS$datapath
			}
			sourcePlot( "lib/histogram.R", dataFile, input$colorFileHIS, input$paletteHIS )
			dev.off()
		}
	)
[END SRVPLOT]
