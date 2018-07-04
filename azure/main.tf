# Create a resource group
resource "azurerm_resource_group" "met-rg" {
  name     = "met-rg-${var.met_instance_name}"
  location = "West US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "met-vn" {
  name                = "met-vn-${var.met_instance_name}"
  address_space       = ["${var.address_space}"]
  location            = "${azurerm_resource_group.met-rg.location}"
  resource_group_name = "${azurerm_resource_group.met-rg.name}"
}

resource "azurerm_subnet" "met-subnet" {
  name                 = "met-subnet-${var.met_instance_name}"
  resource_group_name  = "${azurerm_resource_group.met-rg.name}"
  virtual_network_name = "${azurerm_virtual_network.met-vn.name}"
  address_prefix       = "${var.address_space}"
}

resource "azurerm_network_interface" "met-ni" {
  name                = "met-ni-${var.met_instance_name}"
  location            = "${azurerm_resource_group.met-rg.location}"
  resource_group_name = "${azurerm_resource_group.met-rg.name}"

  ip_configuration {
    name                          = "met-ip-config-${var.met_instance_name}"
    subnet_id                     = "${azurerm_subnet.met-subnet.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "met-master" {
  name                  = "met-master-${var.met_instance_name}"
  location              = "${azurerm_resource_group.met-rg.location}"
  resource_group_name   = "${azurerm_resource_group.met-rg.name}"
  network_interface_ids = ["${azurerm_network_interface.met-ni.id}"]
  vm_size               = "${var.master_vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "met-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "master"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    environment = "met-${var.met_instance_name}"
  }
}
