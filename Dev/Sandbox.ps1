class resource {
    [string]$location
    [object]$resourceGroup
    [object]$networkSecurityGroup
    [object]$virtualNetwork
    hidden [object] $tempWorkSpace
    resource($name, $location, $IPSPACE, $resourceName, $obsValue) {
        $this.tempWorkSpace = [PSCustomObject][ordered]@{"hiddenValue" = $obsValue }
        $this.location = $location
        $this.resourceGroup = [PSCustomObject][ordered]@{
            "Name"   = $name
            "Return" = [PSCustomObject][ordered]@{}
        }
        $this.networkSecurityGroup = [PSCustomObject][ordered]@{
            "name"          = "$($name)Security"
            "resourceGroup" = $resourceName
            "Return"        = [PSCustomObject][ordered]@{}
        }
        $this.virtualNetwork = [PSCustomObject][ordered]@{ 
            "name"          = "$($name)Vnet" 
            "addressPrefix" = "$($IPSPACE)/16" 
            "subnetName"    = "Kronos2Subnet"
            "subnetPrefix"  = "$($IPSPACE)/24"
            "return"        = [PSCustomObject][ordered]@{}
            "hiddenArg"     = $obsValue
        }
    }
    [string]get_location() {
        return $this.location
    }
    [void] reset_location() {
        $this.location = "EastUS2"
    }
}


####Remote Data source
$seedName = "Kronos2"    
$location = "EastUS2"
$NetworkAddrs = "10.0.0.0"
$resourceName = $resource.resourceGroup.Name
$resource = [resource]::new($seedName, $location, $NetworkAddrs, $resourceName, $null)
####

#### View Values at locations
$resource.get_location()
$resource.reset_location()
$resource.get_location()
####


$resource.resourceGroup.return = az group create `
    --location $resource.location `
    --name $resource.resourceGroup.name | ConvertFrom-Json -Depth 10

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
