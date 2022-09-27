####Remote Data source
$seedName = "Kronos2"    
$location = "WestUS2"
$NetworkAddrs = "10.0.0.0"
####


class resource {
    [string]$location
    [array[]]$resourceGroup
    [array[]]$networkSecurityGroup
    [array[]]$virtualNetwork
    [array[]]$publicIP
    [array[]]$networkInterface
    [array[]]$vmDisk
    hidden [object] $tempWorkSpace
    resource($name, $location, $IPSPACE, $obsValue) {
        $this.tempWorkSpace = @{"hiddenValue" = $obsValue }
        $this.location = $location
        $this.resourceGroup = @{
            "Name"   = "($name)ResourceGroup"
            "Return" = @{}
        }
        $this.networkSecurityGroup = @{
            "name"          = "$($name)Security"
            "resourceGroup" = "($name)ResourceGroup"
            "return"        = @{}
        }
        $this.virtualNetwork = @{ 
            "name"          = "$($name)Vnet" 
            "addressPrefix" = "$($IPSPACE)/16" 
            "subnetName"    = "$($name)Subnet"
            "subnetPrefix"  = "$($IPSPACE)/24"
            "return"        = @{}
        }
        $this.publicIP = @{
            "name"          = "$($name)PublicIp"
            "resourceGroup" = "$($name)ResourceGroup"
            "return"        = @{}
        }
        $this.networkInterface = @{
            "name"          = "$($name)NetworkInterface"
            "resourceGroup" = "$($name)ResourceGroup"
            "subnetName"    = "$($name)Subnet"
            "return"        = @{}
        }
        $this.vmDisk = @{
            "name"          = "$($name)NetworkInterface"
            "return"        = @{}
        }
        
    }
    [string]get_location() {
        return $this.location
    }
}


####Local Work
$resource = [resource]::new($seedName, $location, $NetworkAddrs, $null)
####

#### View Values at locations
$resource.get_location()
####


$resource.resourceGroup.return = az group create `
    --location $resource.location `
    --name $resource.resourceGroup.name | ConvertFrom-Json -Depth 20

$resource.networkSecurityGroup.return = az network nsg create `
    --resource-group $resource.resourceGroup.name `
    --name $resource.networkSecurityGroup.name | ConvertFrom-Json -Depth 20

$resource.virtualNetwork.return = az network vnet create `
    --location $resource.location `
    --resource-group $resource.resourceGroup.return.name `
    --name $resource.virtualNetwork.name `
    --address-prefix $resource.virtualNetwork.addressPrefix `
    --subnet-name $resource.virtualNetwork.subnetName `
    --subnet-prefix $resource.virtualNetwork.subnetPrefix | ConvertFrom-Json -Depth 20

$resource.publicIP.return = az network public-ip create `
    --name $resource.publicIP.name `
    --resource-group $resource.resourceGroup.name
<#
$resource.networkInterface.return = az network nic create `
    --name $resource.networkInterface `
    --resource-group $resource.resourceGroup.return.name `
    --subnet $resource.virtualNetwork.subnetName

$resourceaz.diskcreate.return = az disk create `
    --name $resource..return.name | ConvertFrom-Json -Depth 20 `
    --resource-group $resource.resourceGroup.return.name | ConvertFrom-Json -Depth 20 #>