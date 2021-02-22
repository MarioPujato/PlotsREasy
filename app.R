suppressMessages(library('shiny'))
suppressMessages(library('shinyjs'))
suppressMessages(library('shinythemes'))
suppressMessages(library('gridExtra'))
suppressMessages(library('ggrepel'))
suppressMessages(library('beeswarm'))
suppressMessages(library('superheat'))
suppressMessages(library('beeswarm'))
suppressMessages(library('plotrix'))
suppressMessages(library('wordcloud'))
suppressMessages(library('DESeq2'))
suppressMessages(library('methods'))
suppressMessages(library('plyr'))
suppressMessages(library('EnrichedHeatmap'))
suppressMessages(library('VennDiagram'))
suppressMessages(library('cowplot'))
suppressMessages(library('easyGgplot2'))
suppressMessages(library('grid'))
suppressMessages(library('gplots'))
suppressMessages(library('Matrix'))
suppressMessages(library('colourpicker'))
options(shiny.maxRequestSize = 50*1024^2)


ui = navbarPage(
	title       = div(img(src="images/PlotsREasy_small_logo.png", height=25), "PlotsREasy"),
	windowTitle = "PlotsREasy",
	theme       = shinytheme( "sandstone" ),
	collapsible = TRUE,
#	icon        = "images/az_small_logo.png",

	tabPanel( "Home",
		useShinyjs(), # Include shinyjs
		tags$body(tags$style(
			type="text/css", "body {padding-top: 70px; text-align: justify;}"
		)),
		fluidRow(
			column(2),
			column(8,
				includeMarkdown( "lib/home.md" ),
				br(),
				h3("Choose a plot"),
				hr(),
				tags$head(tags$style(
					HTML("input[type=\"number\"]{ width: 100px;}"),
					HTML("hr {border-top: 1px solid #DDDDDD;}"),
					HTML("#homeButtonBRN {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonBRN:hover {opacity:1;}"),
					HTML("#homeButtonBSW {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonBSW:hover {opacity:1;}"),
					HTML("#homeButtonBOX {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonBOX:hover {opacity:1;}"),
					HTML("#homeButtonCTR {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonCTR:hover {opacity:1;}"),
					HTML("#homeButtonCOR {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonCOR:hover {opacity:1;}"),
					HTML("#homeButtonHTM {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonHTM:hover {opacity:1;}"),
					HTML("#homeButtonHIS {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonHIS:hover {opacity:1;}"),
					HTML("#homeButtonHOR {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonHOR:hover {opacity:1;}"),
					HTML("#homeButtonPCA {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonPCA:hover {opacity:1;}"),
					HTML("#homeButtonPIE {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonPIE:hover {opacity:1;}"),
					HTML("#homeButtonSCA {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonSCA:hover {opacity:1;}"),
					HTML("#homeButtonSCL {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonSCL:hover {opacity:1;}"),
					HTML("#homeButtonVEN {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonVEN:hover {opacity:1;}"),
					HTML("#homeButtonBAR {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonBAR:hover {opacity:1;}"),
					HTML("#homeButtonVIO {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonVIO:hover {opacity:1;}"),
					HTML("#homeButtonVLC {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonVLC:hover {opacity:1;}"),
					HTML("#homeButtonWCL {display:block; height: 10vw; width: 10vw; border-radius: 0%; opacity:0.3;}"),HTML("#homeButtonWCL:hover {opacity:1;}")
				)),
				splitLayout(
					actionButton( "homeButtonBRN", label=NULL, style="background: url('images/BRN_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonBSW", label=NULL, style="background: url('images/BSW_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonBOX", label=NULL, style="background: url('images/BOX_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonCTR", label=NULL, style="background: url('images/CTR_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonCOR", label=NULL, style="background: url('images/COR_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonHTM", label=NULL, style="background: url('images/HTM_button.png'); background-size: cover; background-position: center;" )
				),
				br(),
				splitLayout(
					actionButton( "homeButtonHIS", label=NULL, style="background: url('images/HIS_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonHOR", label=NULL, style="background: url('images/HOR_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonPCA", label=NULL, style="background: url('images/PCA_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonPIE", label=NULL, style="background: url('images/PIE_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonSCA", label=NULL, style="background: url('images/SCA_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonSCL", label=NULL, style="background: url('images/SCL_button.png'); background-size: cover; background-position: center;" )
				),
				br(),
				splitLayout(
					actionButton( "homeButtonVEN", label=NULL, style="background: url('images/VEN_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonBAR", label=NULL, style="background: url('images/BAR_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonVIO", label=NULL, style="background: url('images/VIO_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonVLC", label=NULL, style="background: url('images/VLC_button.png'); background-size: cover; background-position: center;" ),
					actionButton( "homeButtonWCL", label=NULL, style="background: url('images/WCL_button.png'); background-size: cover; background-position: center;" ),
					""
				),
				hr()
			),
			column(2)
		)
	),
	navbarMenu( "",
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
		),

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
		),

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
		),

		tabPanel( "C-Tree",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabCTR")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileCTR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileCTR" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleCTR", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsCTR"),
							br(),
							fileInput( "colorFileCTR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileCTR" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorCTR")
						),
						tabPanel( "Options",
							br(),
							splitLayout(
								h4("Dimensions:"),
								numericInput( "widthCTR",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightCTR", "Height", value = 600, min = 300, max = 2400, step = 50 )
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarCTR", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarCTR",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarCTR",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarCTR",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							h4("Main title and labels:"),
							textInput( "titleCTR",  NULL, placeholder = "Main title here" ),
							textInput( "yLabelCTR", NULL, placeholder = "Y label here" ),
							splitLayout(
								numericInput( "titleSizeCTR",  "Title size", value = 3.0,  min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yLabelSizeCTR", "Ylab size",  value = 2.5,  min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yYlabelCTR",    "Ylab pos",   value = 0.01, min = 0,   max = 1,  step = 0.01 ),
								numericInput( "scaleSizeCTR",  "Scale size", value = 2.0,  min = 0.5, max = 10, step = 0.1 )
							),
							h4("Options:"),
							splitLayout(
								numericInput( "methodCTR",     "Arrangement", value = 1,   min = 1,   max = 4,  step = 1 ),
								numericInput( "textSizeCTR",   "Text size",   value = 0.8, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "symbolSizeCTR", "Symbol size", value = 5,   min = 0.5, max = 20, step = 0.5 ),
								""
							),
							splitLayout(
								numericInput( "lineWidthCTR", "Line width", value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput( "boxTypeCTR",   "Box type",   value = 1, min = 0,   max = 6,  step = 1 ),
								"",
								""
							),
							h4("Gradient:"),
							splitLayout(
								numericInput( "gradXposCTR",  "X pos",   value = 0.74, min = 0, max = 1, step = 0.01 ),
								numericInput( "gradYposCTR",  "Y pos",   value = 0.04, min = 0, max = 1, step = 0.01 ),
								numericInput( "gradScaleCTR", "Scaling", value = 1,    min = 0, max = 2, step = 0.05 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/cTree.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotCTR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonCTR", "Plot"),
									downloadButton( "downloadPlotCTR", "Save Plot")
								),
								hr(),
								uiOutput("plotCTR")
							),
							tabPanel( "Log",
								br(),
								"Nothing to display"
							)
						)
					)
				)
			)
		),

		tabPanel( "Correlation Matrix",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabCOR")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileCOR",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileCOR" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleCOR", "Load example file", value = F ),
							br(),br(),hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsCOR"),
							br(),
							fileInput( "colorFileCOR", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileCOR" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorCOR")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthCOR",  "Witdh",  value = 530, min = 300, max = 2400, step = 50 ),
								numericInput( "heightCOR", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Options:"),
							splitLayout(
								numericInput(  "rowLabelSpaceCOR", "Row label space", value = 0.2, min = 0, max = 10, step = 0.1 ),
								numericInput(  "colLabelSpaceCOR", "Col label space", value = 0.2, min = 0, max = 10, step = 0.1 ),
								checkboxInput( "cellDataCOR", "Show cell data", value = T ),
								""
							),
							splitLayout(
								numericInput(  "rowLabelSizeCOR", "Row label size", value = 6, min = 0, max = 50, step = 1 ),
								numericInput(  "colLabelSizeCOR", "Col label size", value = 6, min = 0, max = 50, step = 1 ),
								numericInput(  "cellTextSizeCOR", "Cell text size", value = 5, min = 0, max = 50, step = 1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/corMatrix.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotCOR{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonCOR", "Plot"),
									downloadButton( "downloadPlotCOR", "Save Plot")
								),
								hr(),
								uiOutput("plotCOR")
							),
							tabPanel( "Log",
								br(),
								"Nothing to display"
							)
						)
					)
				)
			)
		),

		tabPanel( "Heatmap",
			sidebarLayout(
				sidebarPanel(
					h3("Heatmap"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileHTM",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileHTM" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleHTM", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsHTM"),
					br(),
					fileInput( "colorFileHTM", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#colorFileHTM" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorHTM"),
					br(),hr(),
					h4("Dimensions:"),
					splitLayout(
						numericInput( "widthHTM",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightHTM", "Height", value = 900, min = 300, max = 2400, step = 50 ),
						"",""
					),
					br(),hr(),
					h4("Main title and labels:"),
					textInput( "titleHTM", NULL, placeholder = "Main title here" ),
					splitLayout(
						numericInput( "titleSizeHTM",  "Title size", value = 15, min = 1, max = 50, step = 1 ),
						"","",""
					),
					splitLayout(
						checkboxInput( "labColSwitchHTM", "Display X labels", value = T ),
						checkboxInput( "labRowSwitchHTM", "Display Y labels", value = F ),
						"",""
					),
					splitLayout(
						numericInput( "xLabelSizeHTM",  "X font size", value = 5,   min = 0.01, max = 20, step = 0.1 ),
						numericInput( "yLabelSizeHTM",  "Y font size", value = 5,   min = 0.01, max = 20, step = 0.1 ),
						numericInput( "xLabelSpaceHTM", "X space",     value = 0.2, min = 0,    max = 10, step = 0.1 ),
						numericInput( "yLabelSpaceHTM", "Y space",     value = 0.2, min = 0,    max = 10, step = 0.1 )
					),
					br(),hr(),
					h4("Scaling:"),
					checkboxInput( "linearColorScaleHTM", "Linear color scale", value = F ),
					br(),
					h4("Row-normalized values:"),
					splitLayout(
						checkboxInput( "trZscoreHTM", "Z-score", value = F ),
						"","",""
					),
					splitLayout(
						checkboxInput( "trLScaleHTM", "Linear scale", value = F ),
						numericInput(  "minResHTM",   "Min", value = 0, step = 1 ),
						numericInput(  "maxResHTM",   "Max", value = 1, step = 1 ),
						""
					),
					br(),hr(),
					h4("Log values:"),
					splitLayout(
						checkboxInput( "logScaleHTM", "Log scaling", value = F ),
						numericInput(  "logBaseHTM",  "Base", value = 2, step = 1 ),
						"",""
					),
					br(),hr(),
					h4("Legend:"),
					splitLayout(
						numericInput(  "minValueHTM", "Min value", value = NULL, step = 0.1 ),
						numericInput(  "maxValueHTM", "Max value", value = NULL, step = 0.1 ),
						checkboxInput( "legSymmHTM",  "Symmetric", value = F ),
						""
					),
					splitLayout(
						numericInput( "legWidthHTM",  "Width",     value = 1.5,  min = 0.1, max = 20, step = 0.02 ),
						numericInput( "legHeightHTM", "Height",    value = 0.15, min = 0.1, max = 20, step = 0.02 ),
						numericInput( "legSizeHTM",   "Font size", value = 16,   min = 0.1, max = 50, step = 1 ),
						""
					),
					br(),hr(),
					h4("Dendrograms:"),
					splitLayout(
						checkboxInput( "rowDendroHTM", "Show row tree",    value = F ),
						checkboxInput( "colDendroHTM", "Show column tree", value = F ),
						"",""
					),
					splitLayout(
						checkboxInput( "rowReorderHTM", "Reorder rows",    value = F ),
						checkboxInput( "colReorderHTM", "Reorder columns", value = F ),
						"",""
					),
					br(),hr(),
					h4("Cells and grid:"),
					splitLayout(
						numericInput(  "gridHWidthHTM", "V width",     value = NULL, min = 0.1, max = 10, step = 0.1 ),
						numericInput(  "gridVWidthHTM", "H width",     value = NULL, min = 0.1, max = 10, step = 0.1 ),
						checkboxInput( "cellDataHTM",  "Show cell data", value = F ),
						""
					)
				),

				mainPanel(
					tags$style(HTML("#plotHTM{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonHTM", "Plot"),
									downloadButton( "downloadPlotHTM", "Save Plot")
								),
								hr(),
								uiOutput("plotHTM")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/heatMap.md" )
							)
						)
					)
				)
			)
		),

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
		),

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
		),

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
		),

		tabPanel( "Scatter",
			sidebarLayout(
				sidebarPanel(
					h3("Scatter"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileSCA", NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileSCA" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleSCA", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsSCA"),
					br(),
					tags$script('$( "#colorFileSCA" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorSCA"),
					fileInput( "colorFileSCA", NULL, placeholder = "Select file" ),
					br(),hr(),
					h4("Dimensions:"),
					splitLayout(
						numericInput( "widthSCA",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightSCA", "Height", value = 600, min = 300, max = 2400, step = 50 ),
						"",""
					),
					br(),hr(),
					h4("Titles:"),
					textInput( "titleSCA",  NULL, placeholder = "Main title here" ),
					textInput( "xLabelSCA", NULL, placeholder = "X label here" ),
					textInput( "yLabelSCA", NULL, placeholder = "Y label here" ),
					splitLayout(
						numericInput( "titleSizeSCA", "Title size", value = 26, min = 5, max = 50, step = 1 ),
						numericInput( "labelSizeSCA", "Lab size",   value = 22, min = 5, max = 50, step = 1 ),
						"",""
					),
					br(),hr(),
					h4("Scales:"),
					splitLayout(
						numericInput( "lineWidthSCA", "Line width", value = 4,  min = 0.5, max = 10, step = 0.1 ),
						numericInput( "scaleSizeSCA", "Scale size", value = 18, min = 2,   max = 30, step = 1 ),
						checkboxInput( "xLogSCA", "Log X", value = F ),
						checkboxInput( "yLogSCA", "Log Y", value = F )
					),
					br(),hr(),
					h4("Points:"),
					splitLayout(
						numericInput( "pointSizeSCA", "Point Size",   value = 5, min = 1, max = 30, step = 1 ),
						numericInput( "alphaSCA",     "Transparency", value = 1, min = 0, max = 1,  step = 0.1 ),
						"",""
					),
					splitLayout(
						checkboxInput( "labelsPresentSCA", "Labels", value = T ),
						checkboxInput( "showLabelsSCA",    "Show",   value = F ),
						numericInput(  "textSizeSCA",      "Label Size",   value = 14, min = 2, max = 10, step = 0.1 ),
						""
					),
					br(),hr(),
					h4("Legend:"),
					splitLayout(
						checkboxInput( "showLegendSCA", "Legend", value = F ),
						numericInput(  "legendSizeSCA", "Size",   value = 15, min = 2, max = 30, step = 1 ),
						"",""
					),
					br(),hr(),
					h4("Linear fit:"),
					splitLayout(
						checkboxInput( "showLinearFitSCA", "Linear", value = F ),
						numericInput( "xPosEqSCA", "X pos", value = 0,  step = 1 ),
						numericInput( "yPosEqSCA", "Y pos", value = 0,  step = 1 ),
						numericInput( "eqSizeSCA", "Size",  value = 14, step = 1 )
					)
				),

				mainPanel(
					tags$style(HTML("#plotSCA{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonSCA", "Plot"),
									downloadButton( "downloadPlotSCA", "Save Plot")
								),
								hr(),
								uiOutput("plotSCA")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/scatter.md" )
							)
						)
					)
				)
			)
		),

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
		),

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
		),

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
						numericInput( "groupSpaceBAR", "Group space", value = 0, min = 0,   max = 1,  step = 0.1 ),
						numericInput( "barSpaceBAR",   "Bar space",   value = 0, min = 0,   max = 1,  step = 0.1 ),
						numericInput( "lineWidthBAR",  "Line width",  value = 4, min = 0.5, max = 10, step = 0.1 ),
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
		),

		tabPanel( "Violin",
			sidebarLayout(
				sidebarPanel(
					h3("Violin"),
					br(),hr(),
					h4("Data file:"),
					fileInput( "dataFileVIO",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					tags$script('$( "#dataFileVIO" ).on( "click", function() { this.value = null; });'),
					checkboxInput( "exampleVIO", "Load example file", value = F ),
					br(),hr(),
					h4("Color Palette:"),
					uiOutput("plotColorsVIO"),
					br(),
					tags$script('$( "#colorFileVIO" ).on( "click", function() { this.value = null; });'),
					uiOutput("paletteSelectorVIO"),
					fileInput( "colorFileVIO", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
					br(),
					h4("Dimensions:"),
					splitLayout(
						numericInput( "widthVIO",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
						numericInput( "heightVIO", "Height", value = 600, min = 300, max = 2400, step = 50 )
					),
					h4("Main title and labels:"),
					textInput( "titleVIO",  NULL, placeholder = "Main title here" ),
					textInput( "xLabelVIO", NULL, placeholder = "log2(Fold Change)" ),
					textInput( "yLabelVIO", NULL, placeholder = "-log10(FDR)" ),
					splitLayout(
						numericInput( "titleSizeVIO", "Title size",  value = 35, min = 1, max = 50,  step = 1 ),
						numericInput( "scaleSizeVIO", "Scale size",  value = 20, min = 1, max = 50,  step = 1 ),
						numericInput( "labelSizeVIO", "Label size",  value = 25, min = 1, max = 50,  step = 1 ),
						numericInput( "xAngleVIO",    "Label angle", value = 0,  min = 0, max = 180, step = 30 )
					),
					h4("Select data to plot:"),
					uiOutput( "xDataSelVIO" ),
					uiOutput( "yDataSelVIO" ),
					uiOutput( "gDataSelVIO" ),
					h4("Options:"),
					splitLayout(
						numericInput(  "lineWidthVIO", "Size", value = 4, min = 0, max = 10, step = 1 ),
						"","",""
					),
					h4("Legend:"),
					splitLayout(
						checkboxInput( "legendSwitchVIO", "Legend" ),
						numericInput(  "legendSizeVIO",   "Size", value = 15, min = 5, max = 50, step = 1 ),
						"",""
					),
					h4("Add horizontal line:"),
					splitLayout(
						numericInput( "linePositionVIO", "Y pos", value = 0, min = NA,  max = NA, step = 1 ),
						numericInput( "line2WidthVIO",   "Width", value = 4, min = 0.5, max = 10, step = 0.1 ),
						"",""
					)
				),

				mainPanel(
					tags$style(HTML("#plotVIO{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonVIO", "Plot"),
									downloadButton( "downloadPlotVIO", "Save Plot")
								),
								hr(),
								uiOutput("plotVIO")
							),
							tabPanel( "Instructions",
								br(),
								includeMarkdown( "lib/core.md" ),
								br(),
								includeMarkdown( "lib/violin.md" )
							)
						)
					)
				)
			)
		),

		tabPanel( "Volcano",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabVLC")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileVLC",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileVLC" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleVLC", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsVLC"),
							br(),
							fileInput( "colorFileVLC", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileVLC" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorVLC")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							splitLayout(
								numericInput( "widthVLC",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightVLC", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",""
							),
							br(),hr(),
							h4("Main title and labels:"),
							textInput( "titleVLC",  NULL, placeholder = "Main title here" ),
							textInput( "xLabelVLC", NULL, placeholder = "log2(Fold Change)" ),
							textInput( "yLabelVLC", NULL, placeholder = "-log10(FDR)" ),
							splitLayout(
								numericInput( "titleSizeVLC", "Title size", value = 35, min = 1, max = 50, step = 1 ),
								numericInput( "scaleSizeVLC", "Scale size", value = 20, min = 1, max = 50, step = 1 ),
								numericInput( "labelSizeVLC", "Label size", value = 25, min = 1, max = 50, step = 1 ),
								""
							),
							br(),hr(),
							h4("Plot limits:"),
							splitLayout(
								numericInput( "xMinVLC", "X min", value = "NULL", step = 0.01 ),
								numericInput( "xMaxVLC", "X max", value = "NULL", step = 0.01 ),
								numericInput( "yMinVLC", "Y min", value = "NULL", step = 0.01 ),
								numericInput( "yMaxVLC", "Y max", value = "NULL", step = 0.01 )
							),
							h4("Cutoffs:"),
							splitLayout(
								numericInput( "lfcCutoffVLC",     "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffVLC",     "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffVLC",     "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								numericInput( "fdrSaturationVLC", "-log(FDR) sat", value = "NULL", min = 0, max = 1000, step = 1 )
							),
							br(),hr(),
							h4("Highlight genes:"),
							splitLayout(
								checkboxInput( "hGenesVLC",     "Highlight",   value = F ),
								checkboxInput( "hLabelsVLC",    "Labels",      value = F ),
								"",""
							),
							splitLayout(
								numericInput(  "hPointSizeVLC", "Symbol Size",    value = 2, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "hLabelSizeVLC", "Text Size",      value = 5, min = 0.1, max = 10, step = 0.1 ),
								numericInput(  "lNudgeXVLC",    "Left position",  value = 1, min = 0,   max = 50, step = 0.2 ),
								numericInput(  "rNudgeXVLC",    "Right position", value = 1, min = 0,   max = 50, step = 0.2 )
							),
							h5("Select pasted genes:"),
							textAreaInput( "lGenesVLC", NULL, rows = 12, placeholder = "Paste gene list here" ),
							h5("Select genes invididually:"),
							uiOutput( "geneSelectionVLC" ),
							h5("Select genes by cutoff:"),
							splitLayout(
								numericInput( "lfcCutoffHVLC", "min log2(FC)",  value = -2, min = -20, max = 0.1,  step = 0.1 ),
								numericInput( "rfcCutoffHVLC", "max log2(FC)",  value = 2,  min = 0.1, max = 20,   step = 0.1 ),
								numericInput( "fdrCutoffHVLC", "-log(FDR)",     value = 2,  min = 1.3, max = 200,  step = 0.1 ),
								""
							),
							br(),
							hr(),
							h4("Box and symbols:"),
							splitLayout(
								checkboxInput( "boxSwitchVLC",  "Box",         value = T ),
								numericInput(  "lineWidthVLC",  "Line width",  value = 4, min = 0.5, max = 10, step = 0.1 ),
								numericInput(  "symbolSizeVLC", "Symbol size", value = 2, min = 0.5, max = 10, step = 0.1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/volcano.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotVLC{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonVLC", "Plot"),
									downloadButton( "downloadPlotVLC", "Save Plot")
								),
								hr(),
								uiOutput("plotVLC")
							),
							tabPanel( "Log",
								br(),
								"Nothing to display"
							)
						)
					)
				)
			)
		),

		tabPanel( "Word Cloud",
			sidebarLayout(
				sidebarPanel(
					h3(textOutput("tabWCL")),
					br(),
					tabsetPanel(
						tabPanel( "Input",
							br(),
							h4("Data file:"),
							fileInput( "dataFileWCL",  NULL, placeholder = "Select data file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#dataFileWCL" ).on( "click", function() { this.value = null; });'),
							checkboxInput( "exampleWCL", "Load example file", value = F ),
							br(),
							hr(),
							h4("Color Palette:"),
							uiOutput("plotColorsWCL"),
							br(),
							fileInput( "colorFileWCL", NULL, placeholder = "Select file", accept = c("text/plain", "text/tab-separated-values", ".tsv", ".txt") ),
							tags$script('$( "#colorFileWCL" ).on( "click", function() { this.value = null; });'),
							uiOutput("paletteSelectorWCL")
						),
						tabPanel( "Options",
							br(),
							h4("Dimensions:"),
							br(),
							splitLayout(
								numericInput( "widthWCL",  "Witdh",  value = 600, min = 300, max = 2400, step = 50 ),
								numericInput( "heightWCL", "Height", value = 600, min = 300, max = 2400, step = 50 ),
								"",
								""
							),
							h4("Margins:"),
							splitLayout(
								numericInput( "bottomMarWCL", "Bottom", value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "leftMarWCL",   "Left"  , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "upperMarWCL",  "Upper" , value = 1.0, min = 0, max = 10, step = 0.05 ),
								numericInput( "rightMarWCL",  "Right" , value = 0.1, min = 0, max = 10, step = 0.05 )
							),
							textInput( "titleWCL", NULL, placeholder = "Main title here" ),
							splitLayout(
								numericInput( "titleSizeWCL", "Title size", value = 3.0, min = 0.1, max = 10, step = 0.05 ),
								numericInput( "yTitleWCL",    "Title pos",  value = 0.99, min = 0,   max = 1,  step = 0.01 ),
								"",
								""
							),
							h4("Options:"),
							splitLayout(
								checkboxInput( "fadingWCL",   "Fading",    value = T ),
								checkboxInput( "boldFontWCL", "Bold font", value = F ),
								"",
								""
							),
							splitLayout(
								numericInput(  "centerValueWCL", "Center val", value = 10,  min  = 0, step = 0.5 ),
								numericInput(  "minSizeWCL",     "Min size",   value = 0.7, step = 0.1 ),
								numericInput(  "maxSizeWCL",     "Max size",   value = 3.0, step = 0.1 ),
								""
							)
						),
						tabPanel( "Help",
							br(),
							includeMarkdown( "lib/core.md" ),
							br(),
							includeMarkdown( "lib/wordCloud.md" )
						)
					)
				),

				mainPanel(
					tags$style(HTML("#plotWCL{ height: 70vh; width: 100vh; overflow: auto }")),
					fixedPanel(
						tabsetPanel(
							tabPanel( "Plot",
								br(),
								splitLayout(
									cellWidths = c(80,110),
									actionButton( "goButtonWCL", "Plot"),
									downloadButton( "downloadPlotWCL", "Save Plot")
								),
								hr(),
								uiOutput("plotWCL")
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
	),
	id       = "plotTab",
	selected = "Home",
	position = c("fixed-top")
)

server = function( input, output, session )
{
	curDate   = date()
	sessionId = session$token

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
	observeEvent( input$homeButtonCTR, {
		showNotification( "C-Tree button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="C-Tree")
	})

	valuesCTR = reactiveValues()

	output$tabCTR = renderText({ input$plotTab })

	output$plotCTR = renderUI({
		plotOutput(
			"plotOutCTR",
			width  = input$widthCTR,
			height = input$heightCTR
		)
	})

	output$plotColorsCTR = renderUI({
		plotOutput(
			"plotOutColorsCTR",
			width  = paletteWidthCTR(),
			height = paletteHeightCTR()
		)
	})

	output$paletteSelectorCTR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileCTR) ){
			colorData2 = read.table( input$colorFileCTR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteCTR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutCTR = renderPlot({
		input$goButtonCTR
		isolate({
			# Plot data or example
			colorFile = input$colorFileCTR
			if( is.null( input$dataFileCTR )){
				if( input$exampleCTR ){
					dataFile = "lib/examples/CTR.txt"
					source("lib/cTree.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileCTR$datapath
				source("lib/cTree.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthCTR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightCTR = function(){
		colorFile = input$colorFileCTR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileCTR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteCTR )){
			for( pattern in input$paletteCTR ){
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

	output$plotOutColorsCTR = renderPlot({
		colorFile = input$colorFileCTR
		palette   = input$paletteCTR
		source("lib/colorPalette.R", local = TRUE)
		valuesCTR$colors = colors
	})

	output$downloadPlotCTR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileCTR )){
				outFile = gsub( ".*/", "", input$dataFileCTR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthCTR  / 72,
				height = input$heightCTR / 72
			)
			dataFile = "lib/examples/CTR.txt"
			if( !is.null( input$dataFileCTR )){
				dataFile = input$dataFileCTR$datapath
			}
			sourcePlot( "lib/cTree.R", dataFile, input$colorFileCTR, input$paletteCTR )
			dev.off()
		}
	)
	observeEvent( input$homeButtonCOR, {
		showNotification( "Correlation Matrix button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Correlation Matrix")
	})

	valuesCOR = reactiveValues()

	output$tabCOR  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	paletteWidthCOR = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightCOR = function(){
		colorFile = input$colorFileCOR
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileCOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteCOR )){
			for( pattern in input$paletteCOR ){
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

	output$plotCOR = renderUI({
		plotOutput(
			"plotOutCOR",
			width  = input$widthCOR,
			height = input$heightCOR
		)
	})

	output$plotColorsCOR = renderUI({
		plotOutput(
			"plotOutColorsCOR",
			width  = paletteWidthCOR(),
			height = paletteHeightCOR()
		)
	})

	output$plotOutColorsCOR = renderPlot({
		colorFile = input$colorFileCOR
		palette   = input$paletteCOR
		indColors = input$indColorsCOR
		source("lib/colorPalette.R", local = TRUE)
		valuesCOR$colors = colors
	})

	output$paletteSelectorCOR = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "PCA-1", "PCA-2", "PCA-4" )
		selections = c()
		if( !is.null(input$colorFileCOR) ){
			colorData2 = read.table( input$colorFileCOR$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteCOR",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutCOR = renderPlot({
		input$goButtonCOR
		isolate({
			# Plot data or example
			colorFile = input$colorFileCOR
			if( is.null( input$dataFileCOR )){
				if( input$exampleCOR ){
					dataFile = "lib/examples/COR.txt"
					write( paste("[COR] Using test file:",dataFile), file=stderr() )
					source("lib/corMatrix.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFileCOR$datapath
				source("lib/corMatrix.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	output$downloadPlotCOR <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileCOR )){
				outFile = gsub( ".*/", "", input$dataFileCOR )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthCOR  / 72,
				height = input$heightCOR / 72
			)
			dataFile = "lib/examples/COR.txt"
			if( !is.null( input$dataFileCOR )){
				dataFile = input$dataFileCOR$datapath
			}
			sourcePlot( "lib/corMatrix.R", dataFile, input$colorFileCOR, input$paletteCOR )
			dev.off()
		}
	)
	observeEvent( input$homeButtonHTM, {
		showNotification( "Heatmap button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Heatmap")
	})

	valuesHTM = reactiveValues()

	output$tabHTM = renderText({ input$plotTab })

	output$plotHTM = renderUI({
		plotOutput(
			"plotOutHTM",
			width  = input$widthHTM,
			height = input$heightHTM
		)
	})

	output$plotColorsHTM = renderUI({
		plotOutput(
			"plotOutColorsHTM",
			width  = paletteWidthHTM(),
			height = paletteHeightHTM()
		)
	})

	output$plotOutColorsHTM = renderPlot({
		colorFile = input$colorFileHTM
		palette   = input$paletteHTM
		source("lib/colorPalette.R", local = TRUE)
		valuesHTM$colors = colors
	})


	output$paletteSelectorHTM = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "H7-Blue", "H7-Red", "H7-Yellow", "H7-White" )
		selections = c()
		if( !is.null(input$colorFileHTM) ){
			colorData2 = read.table( input$colorFileHTM$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteHTM",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutHTM = renderPlot({
		input$goButtonHTM
		isolate({
			# Plot data or example
			colorFile = input$colorFileHTM
			if( is.null( input$dataFileHTM )){
				if( input$exampleHTM ){
					dataFile = "lib/examples/HTM.txt"
					source("lib/heatMap.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileHTM$datapath
				source("lib/heatMap.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthHTM = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightHTM = function(){
		colorFile = input$colorFileHTM
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileHTM$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteHTM )){
			for( pattern in input$paletteHTM ){
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

#	observeEvent( input$downloadPlotHTM,{
#		if( input$downloadPlotHTM>0 ){
#			shinyjs::disable("goButtonHTM")
#			shinyjs::disable("downloadPlotHTM")
#			notifHTM02 <<- showNotification( "Downloading HEATMAP plot ...", duration=60 )
#
#			# Generate name for output file
#			outPath = "/Users/ktwc196/Downloads/"
#			outFile = "example_HTM"
#			if( !is.null( input$dataFileHTM )){
#				outFile = gsub( ".*/", "", input$dataFileHTM )
#				outFile = gsub( "\\..*", "", outFile )
#			}
#			downloadFile$path = paste( outPath, outFile, "_HTM_", Sys.Date(), ".pdf", sep = "" )
#			write( paste("[Heatmap |",curDate,"|",sessionId,"] PDF file saved to:",downloadFile$path), file=stderr())
#
#			# Generate plot in PDF format
#			cairo_pdf(
#				downloadFile$path,
#				width  = dimensionsHTM$width  / 72,
#				height = dimensionsHTM$height / 72
#			)
#
#			dataFile = "lib/examples/HTM.txt"
#			if( !is.null( input$dataFileHTM )){
#				dataFile = input$dataFileHTM$datapath
#			}
#			sourcePlot( "lib/heatMap.R", dataFile, input$colorFileHTM, input$paletteHTM )
#			dev.off()
#
#			removeNotification(notifHTM02)
#			showNotification( "Finished downloading HEATMAP plot", duration=3 )
#			shinyjs::enable("goButtonHTM")
#			shinyjs::enable("downloadPlotHTM")
#		}
#	})

	output$downloadPlotHTM <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileHTM )){
				outFile = gsub( ".*/", "", input$dataFileHTM )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthHTM  / 72,
				height = input$heightHTM / 72
			)
			dataFile = "lib/examples/HTM.txt"
			if( !is.null( input$dataFileHTM )){
				dataFile = input$dataFileHTM$datapath
			}
			sourcePlot( "lib/heatMap.R", dataFile, input$colorFileHTM, input$paletteHTM )
			dev.off()
		}
	)
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
	observeEvent( input$homeButtonSCA, {
		showNotification( "Scatter button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Scatter")
	})

	valuesSCA = reactiveValues()

	output$tabSCA  = renderText({ input$plotTab })

	output$plotSCA = renderUI({
		plotOutput(
			"plotOutSCA",
			width  = input$widthSCA,
			height = input$heightSCA
		)
	})

	output$plotColorsSCA = renderUI({
		plotOutput(
			"plotOutColorsSCA",
			width  = paletteWidthSCA(),
			height = paletteHeightSCA()
		)
	})

	output$paletteSelectorSCA = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "VENN-2", "PIE-1" )
		selections = c()
		if( !is.null(input$colorFileSCA) ){
			colorData2 = read.table( input$colorFileSCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteSCA",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutSCA = renderPlot({
		input$goButtonSCA
		isolate({
			# Plot data or example
			colorFile = input$colorFileSCA
			if( is.null( input$dataFileSCA )){
				if( input$exampleSCA ){
					dataFile = "lib/examples/SCA.txt"
					source("lib/scatter.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileSCA$datapath
				source("lib/scatter.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthSCA = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightSCA = function(){
		colorFile = input$colorFileSCA
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileSCA$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteSCA )){
			for( pattern in input$paletteSCA ){
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

	output$plotOutColorsSCA = renderPlot({
		colorFile = input$colorFileSCA
		palette   = input$paletteSCA
		source("lib/colorPalette.R", local = TRUE)
		valuesSCA$colors = colors
	})

	output$downloadPlotSCA <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileSCA )){
				outFile = gsub( ".*/", "", input$dataFileSCA )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthSCA  / 72,
				height = input$heightSCA / 72
			)
			dataFile = "lib/examples/SCA.txt"
			if( !is.null( input$dataFileSCA )){
				dataFile = input$dataFileSCA$datapath
			}
			sourcePlot( "lib/scatter.R", dataFile, input$colorFileSCA, input$paletteSCA )
			dev.off()
		}
	)
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
	observeEvent( input$homeButtonVIO, {
		showNotification( "Violin button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Violin")
	})

	valuesVIO = reactiveValues()

	observe({
		dataFile = "lib/examples/VIO.txt"
		if( ! is.null( input$dataFileVIO )){
			dataFile = input$dataFileVIO$datapath
		}
		dataTable        = read.table( dataFile, header=T, sep="\t", check.names=F, nrows=2 )
		valuesVIO$header = colnames( dataTable )
	})

	output$xDataSelVIO = renderUI({
		selectInput( "xVarVIO", 'X variable',     valuesVIO$header, select=valuesVIO$header[1],  selectize=T )
	})
	output$yDataSelVIO = renderUI({
		selectInput( "yVarVIO", 'Y variable',     valuesVIO$header, select=valuesVIO$header[-1], selectize=T )
	})
	output$gDataSelVIO = renderUI({
		selectInput( "gVarVIO", 'Group variable', valuesVIO$header, select=valuesVIO$header[1],  selectize=T )
	})

	output$plotVIO = renderUI({
		plotOutput(
			"plotOutVIO",
			width  = input$widthVIO,
			height = input$heightVIO
		)
	})

	output$plotColorsVIO = renderUI({
		plotOutput(
			"plotOutColorsVIO",
			width  = paletteWidthVIO(),
			height = paletteHeightVIO()
		)
	})

	output$paletteSelectorVIO = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "FR-Blue", "FR-Green", "FR-Orange", "FR-Yellow", "FR-Red" )
		selections = c()
		if( !is.null(input$colorFileVIO) ){
			colorData2 = read.table( input$colorFileVIO$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteVIO",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutVIO = renderPlot({
		input$goButtonVIO
		isolate({
			# Plot data or example
			if( is.null( input$dataFileVIO )){
				if( input$exampleVIO ){
					dataFile = "lib/examples/VIO.txt"
					source("lib/violin.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile = input$dataFileVIO$datapath
				source("lib/violin.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthVIO = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightVIO = function(){
		colorFile = input$colorFileVIO
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileVIO$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteVIO )){
			for( pattern in input$paletteVIO ){
				iColor = readLines( "lib/defaultPalettes.txt" )
				iColor = iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor = as.vector( unlist( strsplit( iColor, "\t" )))
				iColor = iColor[2]
				colors = c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows    = ceiling( length( colors ) / numColumns )
		factor     = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotOutColorsVIO = renderPlot({
		colorFile = input$colorFileVIO
		palette   = input$paletteVIO
		indColors = input$indColorsVIO
		source("lib/colorPalette.R", local = TRUE)
		valuesVIO$colors = colors
	})

	output$downloadPlotVIO <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVIO )){
				outFile = gsub( ".*/", "", input$dataFileVIO )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
			cairo_pdf(
				file,
				width  = input$widthVIO  / 72,
				height = input$heightVIO / 72
			)
			dataFile = "lib/examples/VIO.txt"
			if( !is.null( input$dataFileVIO )){
				dataFile = input$dataFileVIO$datapath
			}
			sourcePlot( "lib/violin.R", dataFile, input$colorFileVIO, input$paletteVIO )
			dev.off()
		}
	)
	observeEvent( input$homeButtonVLC, {
		showNotification( "Volcano button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Volcano")
	})

	valuesVLC = reactiveValues()

	output$tabVLC  = renderText({ input$plotTab })

	# Load gene list from data
	#---------------------------------------------------------------------------
	highlightGenes = reactiveValues()
	observe({
		curDate   = date()
		sessionId = session$token
		write( paste("[volcano |",curDate,"|",sessionId,"] Getting gene list from data"), file=stderr())

		# Find input source (if any)
		if( is.null( input$dataFileVLC )){
			if( input$exampleVLC ){
				dataFile = "lib/examples/VLC.txt"
			}else{
				return(NULL)
			}
		}else{
			dataFile = input$dataFileVLC$datapath
		}

		# Load data
		iData = read.table( dataFile, header = T, sep = "\t", colClasses = "character", check.names = F )

		# Cutoffs
		lfcCutoff = input$lfcCutoffVLC # Left  (negative)
		rfcCutoff = input$rfcCutoffVLC # Right (positive)
		fdrCutoff = input$fdrCutoffVLC

		# Filter data using cutoffs
		numSelect = 5000
		upGenes   = head(iData[,1],numSelect)
		downGenes = tail(iData[,1],numSelect)

		# Get Gene list from data
		highlightGenes$names = c(upGenes,downGenes)
		numGenes = length(highlightGenes$names)
		write( paste("[volcano |",curDate,"|",sessionId,"]   Number of genes selected:",numGenes), file=stderr())
		write( paste("[volcano |",curDate,"|",sessionId,"] [ DONE ]"), file=stderr())
	})
	
	output$geneSelectionVLC = renderUI({
		selectInput( "geneNamesVLC", NULL, c("Gene name here"='', highlightGenes$names), multiple = T, selectize = T )
	})

	output$plotVLC = renderUI({
		plotOutput(
			"plotOutVLC",
			width  = input$widthVLC,
			height = input$heightVLC
		)
	})

	output$plotColorsVLC = renderUI({
		plotOutput(
			"plotOutColorsVLC",
			width  = paletteWidthVLC(),
			height = paletteHeightVLC()
		)
	})

	output$paletteSelectorVLC = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vc-Gray", "Vc-Green", "Vc-Red" )
		selections = c()
		if( !is.null(input$colorFileVLC) ){
			colorData2 = read.table( input$colorFileVLC$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteVLC",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutVLC = renderPlot({
		input$goButtonVLC
		isolate({
			# Plot data or example
			colorFile = input$colorFileVLC
			if( is.null( input$dataFileVLC )){
				if( input$exampleVLC ){
					dataFile = "lib/examples/VLC.txt"
					source("lib/volcano.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileVLC$datapath
				source("lib/volcano.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthVLC = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightVLC = function(){
		colorFile = input$colorFileVLC
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileVLC$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteVLC )){
			for( pattern in input$paletteVLC ){
				iColor = readLines( "lib/defaultPalettes.txt" )
				iColor = iColor[grep( paste("^", pattern, "\t", sep=""), iColor )]
				iColor = as.vector( unlist( strsplit( iColor, "\t" )))
				iColor = iColor[2]
				colors = c( colors, iColor )
			}
		}
		# Max number of columns set to 8
		numColumns = 8
		numRows    = ceiling( length( colors ) / numColumns )
		factor     = 72 * 6/16
		return( round( numRows * factor, digits = 0 ))
	}

	output$plotOutColorsVLC = renderPlot({
		colorFile = input$colorFileVLC
		palette   = input$paletteVLC
		indColors = input$indColorsVLC
		source("lib/colorPalette.R", local = TRUE)
		valuesVLC$colors = colors
	})

	output$downloadPlotVLC <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVLC )){
				outFile = gsub( ".*/", "", input$dataFileVLC )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthVLC  / 72,
				height = input$heightVLC / 72
			)
			dataFile = "lib/examples/VLC.txt"
			if( !is.null( input$dataFileVLC )){
				dataFile = input$dataFileVLC$datapath
			}
			sourcePlot( "lib/volcano.R", dataFile, input$colorFileVLC, input$paletteVLC )
			dev.off()
		}
	)

	output$downloadGenesVLC <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileVLC )){
				outFile = gsub( ".*/", "", input$dataFileVLC )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".txt", sep = "" )
		},
		content = function( file ){
			dataFile = "lib/examples/VLC.txt"
			if( !is.null( input$dataFileVLC )){
				dataFile = input$dataFileVLC$datapath
			}
			source( "lib/volcanoGenes.R", local = TRUE )
		}
	)
	observeEvent( input$homeButtonWCL, {
		showNotification( "Word Cloud button pressed", duration=1 )
		updateNavbarPage( session, "plotTab", selected="Word Cloud")
	})

	valuesWCL = reactiveValues()

	output$tabWCL  = renderText({ input$plotTab })

	output$plotWCL = renderUI({
		plotOutput(
			"plotOutWCL",
			width  = input$widthWCL,
			height = input$heightWCL
		)
	})

	output$plotColorsWCL = renderUI({
		plotOutput(
			"plotOutColorsWCL",
			width  = paletteWidthWCL(),
			height = paletteHeightWCL()
		)
	})

	output$paletteSelectorWCL = renderUI({
		colorData1 = read.table( "lib/defaultPalettes.txt", header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
		mySelected = c( "Vin1-Blue", "Vin1-Green", "Vin1-Yellow", "Vin1-Orange", "Vin1-Red" )
		selections = c()
		if( !is.null(input$colorFileWCL) ){
			colorData2 = read.table( input$colorFileWCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 )
			mySelected = rownames(colorData2)
			selections = mySelected
		}
		selections = c(selections, rownames(colorData1))
		selectInput( "paletteWCL",
			"Select colors:",
			selections,
			selected = mySelected,
			multiple = TRUE
		)
	})

	output$plotOutWCL = renderPlot({
		input$goButtonWCL
		isolate({
			# Plot data or example
			colorFile = input$colorFileWCL
			if( is.null( input$dataFileWCL )){
				if( input$exampleWCL ){
					dataFile = "lib/examples/WCL.txt"
					source("lib/wordCloud.R", local = TRUE)
				}else{
					return(NULL)
				}
			}else{
				dataFile  = input$dataFileWCL$datapath
				source("lib/wordCloud.R", local = TRUE)
			}
		})
	}, family = "Arial" )

	paletteWidthWCL = function(){
		# Max number of columns set to 8
		factor = 72 * 6/16
		return( round( 8 * factor, digits = 0 ))
	}

	paletteHeightWCL = function(){
		colorFile = input$colorFileWCL
		# Get colors from multiple selection
		colors = c()
		if( !is.null( colorFile )){
			# Read in color file
			colors = unlist(read.table( input$colorFileWCL$datapath, header=F, sep="\t", comment.char="", colClasses="character", row.names=1 ))
		}else if( !is.null( input$paletteWCL )){
			for( pattern in input$paletteWCL ){
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

	output$plotOutColorsWCL = renderPlot({
		colorFile = input$colorFileWCL
		palette   = input$paletteWCL
		source("lib/colorPalette.R", local = TRUE)
		valuesWCL$colors = colors
	})

	output$downloadPlotWCL <- downloadHandler(
		filename = function(){
			outFile = "example"
			if( !is.null( input$dataFileWCL )){
				outFile = gsub( ".*/", "", input$dataFileWCL )
				outFile = gsub( "\\..*", "", outFile )
			}
			paste( outFile, "_", Sys.Date(), ".pdf", sep = "" )
		},
		content = function( file ){
		cairo_pdf(
				file,
				width  = input$widthWCL  / 72,
				height = input$heightWCL / 72
			)
			dataFile = "lib/examples/WCL.txt"
			if( !is.null( input$dataFileWCL )){
				dataFile = input$dataFileWCL$datapath
			}
			sourcePlot( "lib/wordCloud.R", dataFile, input$colorFileWCL, input$palette011 )
			dev.off()
		}
	)

	sourcePlot = function( scriptFile, dataFile, colorFile, inPalette ){
		source( scriptFile, local = T )
	}
}

shinyApp(
	ui     = ui,
	server = server
)
