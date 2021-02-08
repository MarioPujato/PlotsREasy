[START UIPLOT]
		tabPanel( "Venn Diagram",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabVEN")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileVEN",  NULL, placeholder="Select data file", accept=c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileVEN" ).on( "click", function() { this.value=null; });'),
							checkboxInput( "exampleVEN", "Load example file", value=F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsVEN"),
							br(),
							fileInput( "colorFileVEN", NULL, placeholder="Select file", accept=c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileVEN" ).on( "click", function() { this.value=null; });'),
							uiOutput("paletteSelectorVEN")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthVEN",  "Witdh",  value=600, min=300, max=2400, step=50 ),
								numericInput( "heightVEN", "Height", value=600, min=300, max=2400, step=50 ),
								"",""
							),
							br(),hr(),
							h4("Main title:"),
							textInput( "titleVEN", NULL, placeholder="Main title here" ),
							splitLayout(
								numericInput( "titleSizeVEN",  "Title size",   value=35, min=10, max=60,  step=1 ),
								numericInput( "legendSizeVEN", "Legend size",  value=20, min=10, max=60,  step=1 ),
								numericInput( "numberSizeVEN", "Numbers size", value=30, min=10, max=60,  step=1 ),
								""
							),
							splitLayout(
								numericInput( "labelPosVEN",  "Label pos",    value=0,    min=0,  max=180, step=5 ),
								numericInput( "distance1VEN", "Label dist1",  value=0.05, min=0,  max=10,  step=0.01 ),
								numericInput( "distance2VEN", "Label dist2",  value=0.05, min=0,  max=10,  step=0.01 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/vennDiagram.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotVEN{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths=c(80,110),
									actionButton( "goButtonVEN", "Plot"),
									downloadButton( "downloadPlotVEN", "Save Plot")
								),
								hr(),
								uiOutput("plotVEN")
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
	observeEvent( input$homeButtonVEN, {
		showNotification( "Venn Diagram button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Venn Diagram")
	})

	valuesVEN = reactiveValues()

	output$tabVEN =renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthVEN=function(){
		# Max number of columns set to 8
		factor=72 * 6/16
		return( round( 8 * factor, digits=0 ))
	}

	paletteHeightVEN=function(){
		colorFile=input$colorFileVEN
		# Get colors from multiple selection
		colors=c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileVEN$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteVEN )){
			for( pattern in input$paletteVEN ){
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

	output$plotVEN=renderUI({
		plotOutput(
			"plotOutVEN",
			width =input$widthVEN,
			height=input$heightVEN
		)
	})

	output$plotColorsVEN=renderUI({
		plotOutput(
			"plotOutColorsVEN",
			width =paletteWidthVEN(),
			height=paletteHeightVEN()
		)
	})

	output$plotOutColorsVEN=renderPlot({
		colorFile=input$colorFileVEN
		palette  =input$paletteVEN
		source("lib/colorPalette.R", local=TRUE)
		valuesVEN$colors = colors
	})

	output$paletteSelectorVEN = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected=c( "VENN-1", "VENN-2", "VENN-3" )
		selections = c()
		if( !is.null(input$colorFileVEN) ){
			colorData2 = read.table( input$colorFileVEN$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteVEN",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutVEN=renderPlot({
		input$goButtonVEN
		isolate({
			# Plot data or example
			colorFile=input$colorFileVEN
			if( is.null( input$dataFileVEN )){
				if( input$exampleVEN ){
					dataFile="lib/examples/VEN.txt"
					write( paste("[VEN] |",curDate,"|",sessionId,"] Using test file:",dataFile), file=stderr() )
					source("lib/vennDiagram.R", local=TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile=input$dataFileVEN$datapath
				source("lib/vennDiagram.R", local=TRUE)
			}
		})
	}, family="Arial" )

	output$downloadPlotVEN <- downloadHandler(
		filename=function(){
			outFile="example"
			if( !is.null( input$dataFileVEN )){
				outFile=gsub( ".*/", "", input$dataFileVEN )
				outFile=gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep="" )
		},
		content=function( file ){
		cairo_pdf(
				file,
				width =input$widthVEN  / 72,
				height=input$heightVEN / 72
			)
			dataFile="lib/examples/VEN.txt"
			if( !is.null( input$dataFileVEN )){
				dataFile=input$dataFileVEN$datapath
			}
			sourcePlot( "lib/vennDiagram.R", dataFile, input$colorFileVEN, input$paletteVEN )
			dev.off()
		}
	)
[END SRVPLOT]
