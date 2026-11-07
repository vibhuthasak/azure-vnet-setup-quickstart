bicep template for quickstart azure network environment

## Deploy

The template is subscription-scoped and creates the network resource group itself.

```sh
az deployment sub create \
  --location <region> \
  --template-file main.bicep \
  --parameters parameters.bicepparam
```

All resources are created in `--location` unless `location` is set in the parameter file.
