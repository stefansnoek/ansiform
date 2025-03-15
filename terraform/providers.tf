terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "3087dfe8-7fda-4ff3-adcf-86ab5103796b"
}
