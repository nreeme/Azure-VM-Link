class ClassName {
    [string]$name
    [string]$location
    [string]$resourceGroup
    [string]$image
    [object]$return
    ClassName ($opt01, $opt02, $opt03) {
        $this.name = $opt01
        $this.location = (if ($null -ne $opt02) { $opt02 } else { "EastUS2" } )
        $this.resourceGroup = @{
            "name" = $opt03
            "Return" = [PSCustomObject][ordered]@{}
        }
        $this.image = @{
            "image" = "canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:latest"
        }
        $this.return = @{
            "resourceGroup"        = "" 
            "networkSecurityGroup" = ""
            "disk"                 = ""
        }
    }
    [Void] method0 () {
        #LOG IN
    }
    [Void] method01 () {
        $this.resourcegroup = az group create `
            --location $this.location `
            --name $this.name | ConvertFrom-Json -Depth 20
    }
    [Void] method01 () {s
        $this.return = az vm create `
            --resource-group $this.resourceGroup `
            --name $this.name  `
            --image $this.image `
            --admin-username $this.name `
            --generate-ssh-keys | ConvertFrom-Json -Depth 20
    }
    [Void] method0 () {
        #LOG OUT
    }
}

$test = [ClassName]::new("Test", "WestUS2", "Test")


[System.Collections.ArrayList]$FinalResult = @()
$Data = @(
    @{
        "VMs"      = "VM01"
        "location" = "WestUS2"
        "RGs"      = "RG01"
    }
    @{
        "VMs"      = "Vm02"
        "location" = "$null"
        "RGs"      = "RG02"
    }
    @{
        "VMs"      = "VM03"
        "location" = "WestUS2"
        "RGs"      = "RG03"
    }
)

$Data | ForEach-Object {
    $object.method0()
    $object.method01()
    $object.method02()
    $object.method03()
    $object.method04()
    [void]$FinalResult.add($object.return)
}

$FinalResult | ConvertTo-Json -Depth 10