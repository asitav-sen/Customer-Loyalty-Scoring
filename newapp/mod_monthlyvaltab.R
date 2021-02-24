monthlyvalUI<- function(id){
  ns<- NS(id)
    argonTabSet(
      id = ns("monthlytabs"),
      card_wrapper = TRUE,
      horizontal = TRUE,
      circle = FALSE,
      size = "sm",
      width = 12,
      iconList = list(
        icon("user-friends"),
        icon("exchange-alt"),
        icon("money-bill-wave")
      ),
      argonTab(
        tabName = "Customers",
        active = TRUE,
        argonLead("Number of customers per month"),
        argonRow(
          argonTooltip(
            position = "left",
            title = "Click and drag to zoom. Read manual for details.",
            argonColumn(width = 12,
                        lineplotUI(ns("customersmonthly"))
            )
          )
        )
        
      ),
      argonTab(
        tabName = "Transactions",
        active = FALSE,
        argonLead("Number of transactions per month"),
        argonRow(
          argonTooltip(
            position = "left",
            title = "Click and drag to zoom. Read manual for details.",
            argonColumn(width = 12,
                        lineplotUI(ns("transactionmonthly"))
                        )
          )
        )
      ),
      argonTab(
        tabName = "Revenue",
        active = FALSE,
        argonLead("Sales revenue per month"),
        argonRow(
          argonTooltip(
            position = "left",
            title = "Click and drag to zoom. Read manual for details.",
            argonColumn(width = 12,
                        lineplotUI(ns("revenuemonthly"))
                        )
          )
        )
      )
    )

}


monthlyvalServer<- function(id, deltadata){
  moduleServer(
    id,
    function(input, output, session){
      lineplotServer("customersmonthly",xval=deltadata$monthid, yval=deltadata$customers, cval=deltadata$repcat, xtitle="Months", ytitle="Customers")
      lineplotServer("transactionmonthly",xval=deltadata$monthid, yval=deltadata$transactions, cval=deltadata$repcat, xtitle="Months", ytitle="Transactions")
      lineplotServer("revenuemonthly",xval=deltadata$monthid, yval=deltadata$sales, cval=deltadata$repcat, xtitle="Months", ytitle="Revenue")
    }
  )
}