$testPCJson = (@{
    "name" = "VMSandbox"
    "id" = "/subscriptions/782c5c20-e1f5-4b1f-981c-ea3179aefb13/resourceGroups/ProjectVm_group/providers/Microsoft.Compute/virtualMachines/VMSandbox"
    "type" = "Microsoft.Compute/virtualMachines"
    "location" = "westus3"
    "properties" = @{
        "vmId" = "af72ab3c-92e6-4d48-aa17-7f56b9469f2b"
        "hardwareProfile" = @{
            "vmSize" = "Standard_D2s_v3"
        }
        "storageProfile" = @{
            "imageReference" = @{
                "publisher" = "canonical"
                "offer" = "0001-com-ubuntu-server-focal"
                "sku" = "20_04-lts-gen2"
                "version" = "latest"
            }
            "osDisk" = @{
                "osType" = "Linux"
                "name" = "VMSandbox_OsDisk_1_a84904cd00e84bc9ac8e522c90ff51c8"
                "createOption" = "FromImage"
                "caching" = "ReadWrite"
                "managedDisk" = @{
                    "id" = "/subscriptions/782c5c20-e1f5-4b1f-981c-ea3179aefb13/resourceGroups/PROJECTVM_GROUP/providers/Microsoft.Compute/disks/VMSandbox_OsDisk_1_a84904cd00e84bc9ac8e522c90ff51c8"
                }
            }
            "dataDisks" = @()
        }
        "osProfile" = @{
            "computerName" = "VMSandbox"
            "adminUsername" = "azureuser"
            "linuxConfiguration" = @{
                "disablePasswordAuthentication" = $false
            }
            "secrets" = @()
        }
        "networkProfile" = @{
            "networkInterfaces" = @(
                @{
                    "id" = "/subscriptions/782c5c20-e1f5-4b1f-981c-ea3179aefb13/resourceGroups/ProjectVm_group/providers/Microsoft.Network/networkInterfaces/vmsandbox389"
                    "properties" = @{
                        "deleteOption" = "Detach"
                    }
                }
            )
        }
        "diagnosticsProfile" = @{
            "bootDiagnostics" = @{
                "enabled" = $true
            }
        }
    }
})