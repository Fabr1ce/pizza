terraform {
  required_providers {
    dominos = {
      # Placeholders that need to be updated.
      source = "host.org/namespace/dominos"
      version = "0.1.0"
    }
  }

  backend "remote" {
    # Placeholders that need to be updated.
    hostname = "excited-mutt.tfe.training.hashidemos.io"
    organization = "hashicat"
    workspaces {
      name = "hashicat-aws"
    }
  }
}

provider "dominos" {
  first_name    = "My"
  last_name     = "Name"
  email_address = "my@name.com"
  phone_number  = "15555555555"

  credit_card {
    number = 123456789101112
    cvv    = 1314
    date   = "15/16"
    zip    = 18192
  }
}

data "dominos_address" "addr" {
  street = "123 Main St"
  city   = "Anytown"
  state  = "WA"
  zip    = "02122"
}

data "dominos_store" "store" {
  address_url_object = data.dominos_address.addr.url_object
}

data "dominos_menu_item" "item" {
  store_id     = data.dominos_store.store.store_id
  query_string = ["philly", "medium"]
}

resource "dominos_order" "order" {
  address_api_object = data.dominos_address.addr.api_object
  item_codes         = [data.dominos_menu_item.item.matches.0.code]
  store_id           = data.dominos_store.store.store_id
}

