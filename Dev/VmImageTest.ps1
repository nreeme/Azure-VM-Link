az group create `
--location WestUS3 `
--name myResourceGroup

az vm create `
  --resource-group myResourceGroup `
  --name myVM `
  --image Canonical:UbuntuServer:18.04-LTS:latest `
  --admin-username azureuser `
  --generate-ssh-keys