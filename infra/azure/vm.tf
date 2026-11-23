resource "azurerm_linux_virtual_machine" "lab" {
  name                            = "vm-devops-platform-lab"
  resource_group_name             = azurerm_resource_group.lab.name
  location                        = azurerm_resource_group.lab.location
  size                            = "Standard_B2ls_v2"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.lab.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = trimspace(file(pathexpand("~/.ssh/ansible_key.pub")))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 32
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  depends_on = [azurerm_network_interface_security_group_association.lab]
}
