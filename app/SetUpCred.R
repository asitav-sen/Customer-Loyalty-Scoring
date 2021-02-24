library(shinymanager)
credentials <- data.frame(
  user = c("asitav", "zewdu", "aldo", "rigobert", "shiraz", "fuelcompany", "mcdonalds"),
  password = c("lanubia@2021", "lanubia@2021", "lanubia@2021","lanubia@2021", "lanubia@2021", "lanubia@2021", "lanubia@2021"),
  # password will automatically be hashed
  admin = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE),
  company = c("GAS CURACAO","GAS CURACAO","GAS CURACAO","GAS CURACAO","GAS CURACAO","GAS CURACAO", "MCDONALDS"),
  stringsAsFactors = FALSE
)

# you can use keyring package to set database key
library(keyring)
key_set("funmiles", "asitav")

create_db(
  credentials_data = credentials,
  sqlite_path = "~/Funmiles/app/db/cred.sqlite", # will be created
  passphrase = key_get("funmiles", "asitav")
  # passphrase = "passphrase_wihtout_keyring"
)
