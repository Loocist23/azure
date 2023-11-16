# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example_network" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "exemple_subnet" {
  name                 = "exemple_subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example_network.name
  address_prefixes     = ["10.0.1.0/24"]  
}

resource "azurerm_kubernetes_cluster" "exemple_cluster" {
    
        name                = "exemple_cluster"
        location            = azurerm_resource_group.example.location
        resource_group_name = azurerm_resource_group.example.name
        dns_prefix          = "exemple"
        
        default_node_pool {
            name            = "default"
            node_count      = 1
            vm_size         = "Standard_D2_v2"
        }

        identity {
            type = "SystemAssigned"
        }
}

resource "local_file" "kube_config" {
    filename = ".kube/config"
    content = azurerm_kubernetes_cluster.exemple_cluster.kube_config_raw
}