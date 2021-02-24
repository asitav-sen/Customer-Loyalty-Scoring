
#Sidebar

Sidebar<-argonDashSidebar(
  vertical = TRUE,
  skin = "light",
  background = "white",
  size = "md",
  side = "left",
  id = "my_sidebar",
  brand_url = "https://www.funmiles.net/",
  brand_logo = "https://www.funmiles.net/static/upload/Logos/FunMiles_logo.png",
  #argonSidebarHeader(title = "Menu"),
  argonSidebarMenu(
    argonSidebarItem(
      tabName = "lreppurind",
      style="text-align:center",
      "LaNubia Repeat Purchase Index"
    ),
    argonSidebarItem(
      tabName = "lcusvalind",
      style="text-align:center",
      "LaNubia Customer Value Index"
    ),
    argonSidebarItem(
      tabName = "lloyind",
      style="text-align:center",
      "LaNubia Loyalty Index"
    ),
    argonSidebarItem(
      tabName = "premium_tab",
      style="text-align:center",
      "Premium"
    )
  ),
  br(),
  br(),
  br(),
  argonSidebarDivider(),
  argonSidebarHeader(title = "@LaNubia Consulting 2021")
)



#Header

Header<- argonDashHeader(
  argonRow(
    argonColumn(
      width = 6,
      h1("Grow your business, the Funmiles way", style="color:white"),
      h3("with Funmiles Insights", style="color:white"),
      br(),
      h2("Explore possibilities"),
      argonRow(
        argonButton(
          src = NULL,
          name = "Increase Customers",
          status = "secondary",
          icon = NULL,
          size = NULL,
          block = FALSE,
          disabled = FALSE,
          outline = FALSE,
          toggle_modal = TRUE,
          modal_id = "increasecustomer"
        ),
        argonModal(
          id = "increasecustomer",
          title = "Increase your customers",
          status = "secondary",
          gradient = TRUE,
          argonCard("Reach out to prospects similar to your custuomers", btn_text = "Contact us", src = "www.lanubia.nl", width = 12),
          br(),
          argonCard("Reach out to prospects in your vicinity", btn_text = "Contact us", src = "www.lanubia.nl", width = 12)
        ),
        argonButton(
          src = NULL,
          name = "Increase Share of Wallet",
          status = "secondary",
          icon = NULL,
          size = NULL,
          block = FALSE,
          disabled = FALSE,
          outline = FALSE,
          toggle_modal = TRUE,
          modal_id = "increasesow"
        ),
        argonModal(
          id = "increasesow",
          title = "This is a modal",
          status = "danger",
          gradient = TRUE,
          argonCard("Create offers that your customers can't resist", btn_text = "Contact us", src = "www.lanubia.nl", width = 12),
          br(),
          argonCard("Form strategic alliance with suitable partner", btn_text = "Contact us", src = "www.lanubia.nl", width = 12)
        ),
        argonButton(
          src = NULL,
          name = "Boost Loyalty",
          status = "secondary",
          icon = NULL,
          size = NULL,
          block = FALSE,
          disabled = FALSE,
          outline = FALSE,
          toggle_modal = TRUE,
          modal_id = "increasetransactions"
        ),
        argonModal(
          id = "increasetransactions",
          title = "This is a modal",
          status = "danger",
          gradient = TRUE,
          argonCard("Check out how loyal your customers are", btn_text = "Contact us", src = "www.lanubia.nl", width = 12),
          br(),
          argonCard("Offer booster miles to enhance loyalty", btn_text = "Contact us", src = "www.lanubia.nl", width = 12)
        )
        
        
      )
    ),
    argonColumn(
      width = 6,
      argonPersp(argonImage(src = "https://www.funmiles.net/static/img/funlottery/sxm/2.jpg",
                            url = NULL,
                            floating = FALSE,
                            card_mode = FALSE,
                            hover_lift = FALSE,
                            width = "400px"
      ), side = "right")
    )
  ),
  gradient = TRUE,
  color = "danger",
  separator = T,
  separator_color = "secondary",
  bottom_padding = 6,
  top_padding = 6,
  background_img = NULL,
  mask = T,
  opacity = 3,
  height = 400
)

# Loyalty index tab

llicard <- argonCard(
  h2("Loyalty Index combines attitude, behavior and circustances to score loyalty", align="center"),
  h2("Data related to attitude and experiments are not available at this moment", align="center"),
  h1("However, you can order a survey or experiment to collect data", align="center"),
  argonRow(
    argonColumn(width = 4),
    argonColumn(width = 4,
                center = T,
                argonButton(
                  src = NULL,
                  name = "Order Survey",
                  status = "primary",
                  icon = NULL,
                  size = NULL,
                  block = FALSE,
                  disabled = FALSE,
                  outline = FALSE,
                  toggle_modal = TRUE,
                  modal_id = NULL
                )
    ),
    argonColumn(width = 4)
  ),
  title = NULL,
  src = NULL,
  hover_lift = FALSE,
  shadow = FALSE,
  shadow_size = NULL,
  hover_shadow = FALSE,
  border_level = 0,
  icon = NULL,
  btn_text = "Order Now",
  status = "primary",
  background_color = NULL,
  gradient = FALSE,
  floating = TRUE,
  width = 12
)


#Footer

Footer<- argonDashFooter(copyrights = "LaNubia Consulting, 2021",
                         src = "https://lanubia.nl/",
                         argonFooterMenu(
                           argonFooterItem("LinkedIn", src = "https://www.linkedin.com/company/lanubia-business-consulting/"),
                           argonFooterItem("Twitter", src = "https://twitter.com/LaNubia_Consult")
                         ))

# Auth

# authentication module
# aui<-
#   auth_ui(
#   id = "auth",
#   # add image on top ?
#   tags_top = 
#     tags$div(
#       tags$h4("Go miles with Funmiles", style = "align:center"),
#       tags$img(
#         src = "https://lanubia.nl/wp-content/uploads/2018/04/Logo-LaNubia.com-340-x-156.png", width = 200
#       )
#     ),
#   # add information on bottom ?
#   tags_bottom = tags$div(
#     tags$p(
#       "For any question, please  contact ",
#       tags$a(
#         href = "mailto:hangela@funmiles.net?Subject=Shiny%20aManager",
#         target="_top", "administrator"
#       )
#     )
#   ),
#   # change auth ui background ?
#   # https://developer.mozilla.org/fr/docs/Web/CSS/background
#   background  = "linear-gradient(rgba(0, 0, 255, 0.5),
#                        rgba(255, 255, 0, 0.5)),
#                        url('https://www.r-project.org/logo/Rlogo.png');", 
#   choose_language = TRUE
# )