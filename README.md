# dl-infra

This project was created as an experiment and serves as a **mirror of repositories** hosted on **GitHub** and **Azure DevOps**.  
The CI/CD pipelines run in the **Azure DevOps (ADO)** environment.

## Deploy

To deploy the infrastructure from `main.bicep`, use the Azure CLI:

```bash
az deployment sub create --location "<deployment-location>" --template-file "main.bicep" --parameters resourceGroupName="<resource-group-name>" --parameters location="<resource-location>" --name "<deployment-name>"
```

Example:

```bash
az deployment sub create --location "westeurope" --template-file "main.bicep" --parameters resourceGroupName="rg-dl" --parameters location="westeurope" --name "dl-deployment"
```

Make sure you are signed in to Azure CLI and that the target subscription has permission to create the resource group and related resources.
