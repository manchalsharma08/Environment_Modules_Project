variable "env" {}

module "rg" {
    source = "../../moduls/RG"

  sharma =var.env  

}