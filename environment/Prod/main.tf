variable "env" {}

module "rg" {
    source = "../../moduls/RG"

  sharma =var.env  

}
module "vnet" {
    source = "../../moduls/Vnetwork"

  sharma =var.env  

}
