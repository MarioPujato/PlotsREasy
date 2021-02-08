[START UIPLOT]
		tabPanel( "Scatter Lab",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabSCL")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileSCL",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileSCL" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleSCL", "Load example file", value = F ),
							br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsSCL"),
							br(),
#							fileInput( "colorFileSCL", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							fileInput( "colorFileSCL", NULL, placeholder = "Select file" ),
							tags$script('$( "#colorFileSCL" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorSCL")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthSCL",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightSCL", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Titles:"),
							textInput( "titleSCL",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelSCL", NULL, placeholder = "X label here" ),
							textInput( "yLabelSCL", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeSCL", "Title size", value = 26, min = 5, max = 50, step = 1 ),
								numericInput( "labelSizeSCL", "Lab size",   value = 22, min = 5, max = 50, step = 1 ),
								"",""
							),
							br(),hr(),
							h4("Scales:"),
							splitLayout(
								numericInput(  "lineWidthSCL", "Line width", value = 4,  min = 0.5, max = 10, step = 0.1 ),
								numericInput(  "scaleSizeSCL", "Scale size", value = 18, min = 2,   max = 30, step = 1 ),
								checkboxInput( "xLogSCL", "Log X", value = F ),
								checkboxInput( "yLogSCL", "Log Y", value = F )
							),

							br(),hr(),
							h4("Label points:"),
							splitLayout(
								numericInput( "pointSizeSCL", "Bg symbol size", value = 2, min = 0, max = 10, step = 0.5 ),
								"","",""
							),
							h5("Horizontal labels:"),
							splitLayout(
								checkboxInput( "lPoints1SCL",    "Label",     value = F ),
								numericInput(  "hLabelSize1SCL", "Text size", value = 5, min = 0, max = 10, step = 0.5 ),
								checkboxInput( "applyNudgeXSCL", "Align",     value = F ),
								numericInput(  "nudgeXSCL",      "X value",   value = 1, step = 1 )
							),
							textAreaInput( "lList1SCL", NULL, rows = 6, placeholder = "Paste list here" ),
							h5("Vertical labels:"),
							splitLayout(
								checkboxInput( "lPoints2SCL",    "Label",     value = F ),
								numericInput(  "hLabelSize2SCL", "Text size", value = 5, min = 0, max = 10, step = 0.5 ),
								checkboxInput( "applyNudgeYSCL", "Align",     value = F ),
								numericInput(  "nudgeYSCL",      "Y value",   value = 1, step = 1 )
							),
							textAreaInput( "lList2SCL", NULL, rows = 6, placeholder = "Paste list here" ),

							br(),hr(),
							h4("Highlight points:"),
							h5("Group 1 highlight:"),
							splitLayout(
								checkboxInput( "hPoints1SCL",    "Highlight",   value = F ),
								numericInput(  "hPointSize1SCL", "Symbol size", value = 2, min = 0.1, max = 10, step = 0.5 ),
								"",""
							),
							textAreaInput( "hList1SCL", NULL, rows = 6, placeholder = "Paste list 1 here" ),
							splitLayout(
							),
							h5("Group 2 highlight:"),
							splitLayout(
								checkboxInput( "hPoints2SCL",    "Highlight",   value = F ),
								numericInput(  "hPointSize2SCL", "Symbol size", value = 2, min = 0.1, max = 10, step = 0.5 ),
								"",""
							),
							textAreaInput( "hList2SCL", NULL, rows = 6, placeholder = "Paste list 2 here" ),
							h5("Group 3 highlight:"),
							splitLayout(
								checkboxInput( "hPoints3SCL",    "Highlight",   value = F ),
								numericInput(  "hPointSize3SCL", "Symbol size", value = 2, min = 0.1, max = 10, step = 0.5 ),
								"",""
							),
							textAreaInput( "hList3SCL", NULL, rows = 6, placeholder = "Paste list 3 here" )

#							br(),hr(),
#							h4("Legend:"),
#							splitLayout(
#								checkboxInput( "showLegendSCL", "Legend", value = F ),
#								numericInput(  "legendSizeSCL", "Size",   value = 15, min = 2, max = 30, step = 1 ),
#								"",""
#							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/scatterLab.md" )
						)
					)
				),
				mainPanel(
					tags$style(HTML("#plotSCL{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonSCL", "Plot"),
									downloadButton( "downloadPlotSCL", "Save Plot")
								),
								hr(),
								uiOutput("plotSCL")
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
	observeEvent( input$homeButtonSCL, {
		showNotification( "Scatter Lab button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Scatter Lab")
	})

	valuesSCL = reactiveValues()

	output$tabSCL  = renderText({ input$plotTab })

	output$plotSCL = renderUI({
		plotOutput(
			"plotOutSCL",
			width  = input$widthSCL,
			height = input$heightSCL
		)
	})

	output$plotColorsSCL = renderUI({
		plotOutput(
			"plotOutColorsSCL",
			width  = paletteWidthSCL(),
			height = paletteHeightSCL()
		)
	})

	output$paletteSelectorSCL = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "SCL-1", "SCL-2", "SCL-3", "SCL-4" )
		selections = c()
		if( !is.null(input$colorFileSCL) ){
			colorData2 = read.table( input$colorFileSCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteSCL",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutSCL = renderPlot({
		input$goButtonSCL
		isolate({
			# Plot data or example
			colorFile = input$colorFileSCL
			if( is.null( input$dataFileSCL )){
				if( input$exampleSCL ){
					dataFile = "lib/examples/SCL.txt"
					source("lib/scatterLab.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileSCL$datapath
				source("lib/scatterLab.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthSCL = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightSCL = function(){
		colorFile = input$colorFileSCL
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileSCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteSCL )){
			for( pattern in input$paletteSCL ){
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

	output$plotOutColorsSCL = renderPlot({
		colorFile = input$colorFileSCL
		palette   = input$paletteSCL
		source("lib/colorPalette.R", local = TRUE)
		valuesSCL$colors = colors
	})

	output$downloadPlotSCL <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileSCL )){
				outFile = gsub( ".*/", "", input$dataFileSCL )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthSCL  / 72,
				height = input$heightSCL / 72
			)
			dataFile = "lib/examples/SCL.txt"
			if( !is.null( input$dataFileSCL )){
				dataFile = input$dataFileSCL$datapath
			}
			sourcePlot( "lib/scatterLab.R", dataFile, input$colorFileSCL, input$paletteSCL )
			dev.off()
		}
	)
[END SRVPLOT]
