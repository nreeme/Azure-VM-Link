$test = @"
{
    "name": "Kronos2VirtualMachine_disk1_79dfc3cbd5dc4b529f323229885485d0",
    "id": "/subscriptions/782c5c20-e1f5-4b1f-981c-ea3179aefb13/resourceGroups/KRONOS2/providers/Microsoft.Compute/disks/Kronos2VirtualMachine_disk1_79dfc3cbd5dc4b529f323229885485d0",
    "type": "Microsoft.Compute/disks",
    "location": "westus3",
    "tags": {},
    "managedBy": "/subscriptions/782c5c20-e1f5-4b1f-981c-ea3179aefb13/resourceGroups/Kronos2/providers/Microsoft.Compute/virtualMachines/Kronos2VirtualMachine",
    "sku": {
        "name": "Premium_LRS",
        "tier": "Premium"
    },
    "properties": {
        "osType": "Linux",
        "creationData": {
            "createOption": "FromImage",
            "imageReference": {
                "id": "/Subscriptions/0f28f72f-3700-4a71-92f7-2d809552aae9/Providers/Microsoft.Compute/Locations/WestUS3/Publishers/canonical/ArtifactTypes/VMImage/Offers/0001-com-ubuntu-server-focal/Skus/20_04-lts-gen2/Versions/20.04.202210140"
            }
        },
        "diskSizeGB": 30,
        "timeCreated": "2022-10-18T20:35:23.6136679+00:00",
        "provisioningState": "Succeeded",
        "diskState": "Attached"
    }
}
"@ | ConvertFrom-Json -Depth 10