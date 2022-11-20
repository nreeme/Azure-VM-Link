class ClassName {
    [string]$name
    [string]$location
    [object]$return
    ClassName ($opt01, $opt02) {
        $this.name = $opt01
        $this.location = (if ($null -ne $opt02) { $opt02 } else { "EastUS2" } )
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
        $this.return.resourcegroup = az group create `
            --location $this.location `
            --name $this.name | ConvertFrom-Json -Depth 20
    }
    [Void] method01 () {s
        $this.return.resourcegroup = az group create `
            --location $this.location `
            --name $this.name | ConvertFrom-Json -Depth 20
    }
    [Void] method0 () {
        #LOG OUT
    }
}

$test = [ClassName]::new("Kronos", "WestUS2")


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
    [void]$FinalResult.add($object.return)
}

$FinalResult | ConvertTo-Json -Depth 10