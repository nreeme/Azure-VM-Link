####Remote Data source
$seedName = "Kronos2"    
$location = "EastUS2"
$NetworkAddrs = "10.0.0.0"
####


class resource {
    [string]$location
    [object]$resourceGroup
    [object]$networkSecurityGroup
    [object]$virtualNetwork
    [object]$publicIP
    [object]$networkInterface
    [object]$vmDisk
    [object]$VirtualMachine
    hidden [object] $tempWorkSpace
    resource($name, $location, $IPSPACE, $obsValue) {
        $this.tempWorkSpace = [PSCustomObject][ordered]@{"hiddenValue" = $obsValue }
        $this.location = $location
        $this.resourceGroup = [PSCustomObject][ordered]@{
            "Name"   = "$($name)"
            # "Return" = [PSCustomObject][ordered]@{}
        }
        $this.networkSecurityGroup = [PSCustomObject][ordered]@{
            "name"          = "$($name)Security"
            "resourceGroup" = "$($name)"
            "return"        = [PSCustomObject][ordered]@{}
        }
        $this.virtualNetwork = [PSCustomObject][ordered]@{ 
            "name"          = "$($name)Vnet" 
            "addressPrefix" = "$($IPSPACE)/16" 
            "subnetName"    = "$($name)Subnet"
            "subnetPrefix"  = "$($IPSPACE)/24"
            "return"        = [PSCustomObject][ordered]@{}
        }
        $this.publicIP = [PSCustomObject][ordered]@{
            "name"          = "$($name)PublicIp"
            "resourceGroup" = "$($name)"
            "return"        = [PSCustomObject][ordered]@{}
        }
        $this.networkInterface = [PSCustomObject][ordered]@{
            "name"          = "$($name)NetworkInterface"
            "resourceGroup" = "$($name)"
            "subnetName"    = "$($name)Subnet"
            "return"        = [PSCustomObject][ordered]@{}
        }
        $this.vmDisk = [PSCustomObject][ordered]@{
            "name"   = "$($name)VmDisk"
            "size"   = "30"
            "return" = [PSCustomObject][ordered]@{}
        }
        $this.VirtualMachine = [PSCustomObject][ordered]@{
            "name"   = "$($name)VirtualMachine"
            "image"  = "Canonical:UbuntuServer:18.04-LTS:latest"
            "return" = [PSCustomObject][ordered]@{}
        }
        $this.return = @{
            "resourcegroup" = $null
        }
    }
    [string]get_location() {
        return $this.location
    }
    [void] create_resourcegroup () {
        $this.return.resourcegroup = az group create `
            --location $this.location `
            --name $this.resourceGroup.name | ConvertFrom-Json -Depth 20
    }
}


####Local Work
$resource = [resource]::new($seedName, $location, $NetworkAddrs, $null)
####

#### View Values at locations
$resource.get_location()
####




$resource.networkSecurityGroup.return = az network nsg create `
    --resource-group $resource.resourceGroup.name `
    --name $resource.networkSecurityGroup.name | ConvertFrom-Json -Depth 20

$resource.virtualNetwork.return = az network vnet create `
    --location $resource.location `
    --resource-group $resource.resourceGroup.name `
    --name $resource.virtualNetwork.name `
    --address-prefix $resource.virtualNetwork.addressPrefix `
    --subnet-name $resource.virtualNetwork.subnetName `
    --subnet-prefix $resource.virtualNetwork.subnetPrefix | ConvertFrom-Json -Depth 20

$resource.publicIP.return = az network public-ip create `
    --name $resource.publicIP.name `
    --resource-group $resource.resourceGroup.name

$resource.networkInterface.return = az network nic create `
    --name $resource.networkInterface `
    --resource-group $resource.resourceGroup.name `
    --subnet $resource.virtualNetwork.subnetName

$resource.vmDisk.return = az disk create `
    --name $resource.vmDisk.name `
    --resource-group $resource.resourceGroup.name `
    --size-gb $resource.vmDisk.size | ConvertFrom-Json -Depth 20

$resource.VirtualMachine.return = az vm create `
    --name $resource.VirtualMachine.name `
    --resource-group $resource.resourceGroup.name `
    --generate-ssh-keys `
    --image $resource.VirtualMachine.image | ConvertFrom-Json -Depth 20

<#
    
    #>