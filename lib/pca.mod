[START UIPLOT]
		tabPanel( "PCA",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabPCA")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFilePCA",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFilePCA" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "examplePCA", "Load example file", value = F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsPCA"),
							br(),
							fileInput( "colorFilePCA", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFilePCA" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorPCA")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthPCA",  "Witdh",  value = 650, min = 300, max = 2400, step = 50 ),
								numericInput( "heightPCA", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Main title:"),
							textInput( "titlePCA",  NULL, placeholder = "Main title here" ),
							h4("Groups:"),
							textInput( "groupsPCA", NULL, placeholder = "1,1,2,2,3,3,4,5" ),
							br(),hr(),
							h4("Options:"),
							splitLayout(
								checkboxInput( "deseq2PCA", "Use DESeq2", value = T ),
								checkboxInput( "scaleYPCA",     "Scale Y axis", value = F ),
								numericInput( "nTopVarPCA", "Top variable features", value = 500, min = 500, max = 10000, step = 100 ),
								""
							),
							splitLayout(
								numericInput( "titleSizePCA",  "Title size", value = 30, min = 1, max = 50, step = 1 ),
								numericInput( "scaleSizePCA",  "Scale size", value = 22, min = 1, max = 50, step = 1 ),
								numericInput( "labelSizePCA",  "Label size", value = 26, min = 1, max = 50, step = 1 ),
								""
							),
							splitLayout(
								numericInput( "textSizePCA",   "Text size",   value = 20, min = 1, max = 50, step = 1 ),
								numericInput( "legendSizePCA", "Legend size", value = 16, min = 1, max = 50, step = 1 ),
								"",""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/pca.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotPCA{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonPCA", "Plot"),
									downloadButton( "downloadPlotPCA", "Save Plot")
								),
								hr(),
								uiOutput("plotPCA")
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
	observeEvent( input$homeButtonPCA, {
		showNotification( "PCA button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="PCA")
	})

	valuesPCA = reactiveValues()

	output$tabPCA  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthPCA = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightPCA = function(){
		colorFile = input$colorFilePCA
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFilePCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$palettePCA )){
			for( pattern in input$palettePCA ){
				iColor = readLines( "lib/defaultPalettes.txt" )
				iColor = iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor = as.vector( unlist( strsplit( iColor, "\t" )))
				iColor = iColor[2]
				colors = c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows = ceiling( length(colors) / numColumns )
		factor = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotPCA = renderUI({
		plotOutput(
			"plotOutPCA",
			width  = input$widthPCA,
			height = input$heightPCA
		)
	})

	output$plotColorsPCA = renderUI({
		plotOutput(
			"plotOutColorsPCA",
			width  = paletteWidthPCA(),
			height = paletteHeightPCA()
		)
	})

	output$plotOutColorsPCA = renderPlot({
		colorFile = input$colorFilePCA
		palette   = input$palettePCA
		indColors = input$indColorsPCA
		source("lib/colorPalette.R", local = TRUE)
		valuesPCA$colors = colors
	})

	output$paletteSelectorPCA = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "PCA-1", "PCA-2", "PCA-3", "PCA-4" )
		selections = c()
		if( !is.null(input$colorFilePCA) ){
			colorData2 = read.table( input$colorFilePCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "palettePCA",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutPCA = renderPlot({
		input$goButtonPCA
		isolate({
			# Plot data or example
			colorFile = input$colorFilePCA
			if( is.null( input$dataFilePCA )){
				if( input$examplePCA ){
					dataFile = "lib/examples/PCA.txt"
					write( paste("[PCA] Using test file:",dataFile), file=stderr() )
					source("lib/pca.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFilePCA$datapath
				source("lib/pca.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	output$downloadPlotPCA <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFilePCA )){
				outFile = gsub( ".*/", "", input$dataFilePCA )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthPCA  / 72,
				height = input$heightPCA / 72
			)
			dataFile = "lib/examples/PCA.txt"
			if( !is.null( input$dataFilePCA )){
				dataFile = input$dataFilePCA$datapath
			}
			sourcePlot( "lib/pca.R", dataFile, input$colorFilePCA, input$palettePCA )
			dev.off()
		}
	)
[END SRVPLOT]
