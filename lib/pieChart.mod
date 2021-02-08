[START UIPLOT]
		tabPanel( "Pie Chart",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabPIE")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFilePIE",  NULL, placeholder="Select data file", accept=c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFilePIE" ).on( "click", function() { this.value=null; });'),
							checkboxInput( "examplePIE", "Load example file", value=F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsPIE"),
							br(),
							fileInput( "colorFilePIE", NULL, placeholder="Select file", accept=c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFilePIE" ).on( "click", function() { this.value=null; });'),
							uiOutput("paletteSelectorPIE")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthPIE",  "Witdh",  value=600, min=300, max=2400, step=50 ),
								numericInput( "heightPIE", "Height", value=600, min=300, max=2400, step=50 ),
								"",""
							),
							br(),hr(),
							h4("Main title:"),
							textInput( "titlePIE",  NULL, placeholder="Main title here" ),
							splitLayout(
								numericInput( "titleSizePIE",  "Title size",  value=3,   min=1, max=10, step=0.1 ),
								numericInput( "legendSizePIE", "Legend size", value=1.8, min=1, max=10, step=0.1 ),
								numericInput( "columnsPIE",    "Legend cols", value=3,   min=1, max=10, step=1 ),
								""
							),
							br(),hr(),
							h4("Pie dimensions:"),
							splitLayout(
								numericInput( "xCirclePIE", "X pos", value=0.5, min=0, max=1, step=0.05 ),
								numericInput( "yCirclePIE", "Y pos", value=0.5, min=0, max=1, step=0.05 ),
								"",""
							),
							splitLayout(
								numericInput( "rCirclePIE", "Outter radius", value=0.35, min=0.05, max=1, step=0.01 ),
								numericInput( "iCirclePIE", "Inner radius",  value=0.14, min=0.00, max=1, step=0.01 ),
								numericInput( "explodePIE", "Exploded",      value=0.01, min=0.00, max=1, step=0.01 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/pieChart.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotPIE{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths=c(80,110),
									actionButton( "goButtonPIE", "Plot"),
									downloadButton( "downloadPlotPIE", "Save Plot")
								),
								hr(),
								uiOutput("plotPIE")
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
	observeEvent( input$homeButtonPIE, {
		showNotification( "Pie Chart button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Pie Chart")
	})

	valuesPIE = reactiveValues()

	output$tabPIE =renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthPIE=function(){
		# Max number of columns set to 8
		factor=72 * 6/16
		return( round( 8 * factor, digits=0 ))
	}

	paletteHeightPIE=function(){
		colorFile=input$colorFilePIE
		# Get colors from multiple selection
		colors=c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFilePIE$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$palettePIE )){
			for( pattern in input$palettePIE ){
				iColor=readLines( "lib/defaultPalettes.txt" )
				iColor=iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor=as.vector( unlist( strsplit( iColor, "\t" )))
				iColor=iColor[2]
				colors=c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns=8
		numRows=ceiling( length(colors) / numColumns )
		factor=72 * 6/16
		return( round( numRows * factor, digits=0 ))
	}

	output$plotPIE=renderUI({
		plotOutput(
			"plotOutPIE",
			width =input$widthPIE,
			height=input$heightPIE
		)
	})

	output$plotColorsPIE=renderUI({
		plotOutput(
			"plotOutColorsPIE",
			width =paletteWidthPIE(),
			height=paletteHeightPIE()
		)
	})

	output$plotOutColorsPIE=renderPlot({
		colorFile=input$colorFilePIE
		palette  =input$palettePIE
		indColors=input$indColorsPIE
		source("lib/colorPalette.R", local=TRUE)
		valuesPIE$colors = colors
	})

	output$paletteSelectorPIE = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "PIE-1", "PIE-2", "PIE-3" )
		selections = c()
		if( !is.null(input$colorFilePIE) ){
			colorData2 = read.table( input$colorFilePIE$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "palettePIE",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutPIE=renderPlot({
		input$goButtonPIE
		isolate({
			# Plot data or example
			colorFile=input$colorFilePIE
			if( is.null( input$dataFilePIE )){
				if( input$examplePIE ){
					dataFile="lib/examples/PIE.txt"
					write( paste("[PIE] |",curDate,"|",sessionId,"] Using test file:",dataFile), file=stderr() )
					source("lib/pieChart.R", local=TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile=input$dataFilePIE$datapath
				source("lib/pieChart.R", local=TRUE)
			}
		})
	}, family="Arial" )

	output$downloadPlotPIE <- downloadHandler(
		filename=function(){
			outFile="example"
			if( !is.null( input$dataFilePIE )){
				outFile=gsub( ".*/", "", input$dataFilePIE )
				outFile=gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep="" )
		},
		content=function( file ){
		cairo_pdf(
				file,
				width =input$widthPIE  / 72,
				height=input$heightPIE / 72
			)
			dataFile="lib/examples/PIE.txt"
			if( !is.null( input$dataFilePIE )){
				dataFile=input$dataFilePIE$datapath
			}
			sourcePlot( "lib/pieChart.R", dataFile, input$colorFilePIE, input$palettePIE )
			dev.off()
		}
	)
[END SRVPLOT]
