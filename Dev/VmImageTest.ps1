az group create `
  --location WestUS3 `
  --name myResourceGroup

az vm create `
  --resource-group myResourceGroup `
  --name myVM `
  --image Canonical:UbuntuServer:18.04-LTS:latest `
  --admin-username azureuser `
  --generate-ssh-keys

New-AzVm `
  -ResourceGroupName 'myResourceGroup' `
  -Name 'myVM' `
  -Location 'WestUS3' `
  -Image Canonical:UbuntuServer:18.04-LTS:latest `
  -size Standard_D2s_v3 `
  -PublicIpAddressName myPubIP `
  -OpenPorts 80 `
  -GenerateSshKey `
  -SshKeyName mySSHKey