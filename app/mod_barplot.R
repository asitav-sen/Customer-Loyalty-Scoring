
hbarplotUI<- function(id,filtervalues){
  ns<- NS(id)
  argonRow(
    argonColumn(
      width = 4,
      selectizeInput(ns("hbarfilter"),"Select Months", choices = filtervalues, selected= filtervalues, multiple = T),
      sliderInput(ns("topfilter"), "Select number of segments to show",min = 5, max=length(unique(scores$Segment)), value = 5, step=1)
    ),
    argonColumn(
      width = 8,
      plotlyOutput(ns("hbar")) 
    )
  )
}

hbarplotServer<- function(id, df, xtitle="", ytitle=""){
  moduleServer(
    id,
    function(input, output, session){
      fd<-reactive({
        as.POSIXct(input$hbarfilter, tz="UTC")
      })

      dat<- reactive({
        df%>%
          filter(monthid %in% fd())
      })
      
      output$hbar<- renderPlotly({
        dat()%>%
          group_by(Segment)%>%
          summarise(sales=sum(miles)*10)%>%
          slice_max(sales,n=input$topfilter)%>%
        plot_ly(
          x= ~reorder(Segment,sales),
          y= ~sales,
          type = 'bar',
          showlegend=F
        )%>%
          layout(
            xaxis = list(title = xtitle),
            yaxis = list(title = ytitle),
            plot_bgcolor = 'transparent',
            paper_bgcolor = 'transparent'
          ) %>% config(displayModeBar = FALSE)
      })
    }
  )
}