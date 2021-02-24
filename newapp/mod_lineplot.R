
lineplotUI<- function(id){
  ns<- NS(id)
  shinycssloaders::withSpinner(plotlyOutput(ns("lineplot")) , image = "https://media.giphy.com/media/RLsct1jsRVsVFupW7a/giphy.gif", image.height ="200px",hide.ui = T)
  
}

lineplotServer<- function(id, xval, yval, cval, xtitle="", ytitle=""){
  moduleServer(
    id,
    function(input, output, session){
      output$lineplot<- renderPlotly({
        req(xval, yval, cval)
        plot_ly(
          x= xval,
          y= yval,
          type = 'scatter',
          mode = 'lines+markers',
          #size = 4,
          color = cval,
          colors = c("dodgerblue","aquamarine4","gray48")
        )%>%
          layout(
            xaxis = list(title = xtitle),
            yaxis = list(title = ytitle),
            plot_bgcolor = 'transparent',
            paper_bgcolor = 'transparent',
            legend = list(orientation = 'h')
          ) %>% config(displayModeBar = FALSE)
      })
    }
  )
}