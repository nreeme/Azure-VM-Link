$resource = @{
    "Location"       = "EastUS2"
    "resourceGroup"  = @{
        "Name"   = "Kronos2"
        "Return" = @{}
    }
    "virtualNetwork" = @{ 
        "name"           = "Kronos2Vnet" 
        "addressPrefix" = "10.0.0.0/16" 
        "subnetName"    = "Kronos2Subnet"
        "subnetPrefix"  = "10.0.0.0/24"
        "return"         = @{}
    }
}
$resource.resourceGroup.return = az group create `
    --location $resource.location `
    --name $resource.resourceGroup.name | ConvertFrom-Json -Depth 20

$resource.virtualNetwork.return = az network vnet create `
    --location $resource.location `
    --resource-group $resource.resourceGroup.return.name `
    --name $resource.virtualNetwork.name `
    --address-prefix $resource.virtualNetwork.addressPrefix `
    --subnet-name $resource.virtualNetwork.subnetName `
    --subnet-prefix $resource.virtualNetwork.subnetPrefix | ConvertFrom-Json -Depth 20
