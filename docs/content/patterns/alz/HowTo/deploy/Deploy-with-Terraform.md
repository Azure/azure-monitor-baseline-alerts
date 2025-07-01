---
title: Deploy with Terraform
weight: 75
---

### On this page

> [Example of deploying AMBA-ALZ](./#example-of-deploying-amba-alz) </br>
> [Example of deploying a Custom Architecture](./#example-of-deploying-a-custom-architecture) </br>
> [Example of deploying with Custom Policy Assignments](./#example-of-deploying-with-custom-policy-assignments) </br>
> [Data Collection](./#data-collection) </br>
> [Next Steps](./#next-steps) </br>

## Choose one of the examples

- **Example of deploying AMBA-ALZ**: This example demonstrates how to deploy the AMBA-ALZ pattern using an existing management group hierarchy with default naming as used in the [ALZ Architecture Definition](https://raw.githubusercontent.com/Azure/Azure-Landing-Zones-Library/refs/heads/main/platform/alz/architecture_definitions/alz.alz_architecture_definition.json).
- **Example of deploying a Custom Architecture**: This example demonstrates how to deploy the AMBA-ALZ pattern using an existing custom management group hierarchy.
- **Example of deploying with Custom Policy Assignments**: It is possible to tailor the Policy Definitions that are deployed and assigned by developing custom archetypes. This example demonstrates a situation where only Service Health is deployed, but can be applied to other policy assignments as well.

## Example of deploying AMBA-ALZ

This example demonstrates how to deploy the AMBA-ALZ pattern using an existing management group hierarchy with default naming as used in the [ALZ Architecture Definition](https://raw.githubusercontent.com/Azure/Azure-Landing-Zones-Library/refs/heads/main/platform/alz/architecture_definitions/alz.alz_architecture_definition.json).

1. Create a new directory, for example `tf-amba-alz`.
1. Open Visual Studio Code or another preferred tool.
1. Select `Open Folder...` from the File menu (or Ctrl+K Ctrl+O) and open `tf-amba-alz`
1. Open a Terminal (PowerShell).

    {{< hint type=note >}}
    Depending on the tool being used, it may be necessary to change the terminal to the `tf-amba-alz` directory.
    {{< /hint >}}

1. Download `terraform.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/complete/terraform.tf -OutFile terraform.tf
    ```

1. Download `main.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/complete/main.tf -OutFile main.tf
    ```

1. Download `variables.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/complete/variables.tf -OutFile variables.tf
    ```

1. The source and version of the module need to be updated in `main.tf`. Find `module "amba_alz"` and replace

    ```hcl
    source = "../../"
    ```

    With:

    ```hcl
    source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
    version = "0.1.1"
    ```

1. Review the variables in `variables.tf` and update default values as needed.
1. Log in to Azure: `az login`
1. Run: `terraform init`
1. Run: `terraform apply`

## Example of deploying a Custom Architecture

This example demonstrates how to deploy the AMBA-ALZ pattern using an existing custom management group hierarchy.

1. Create a new directory, for example `tf-amba-alz`.
1. Open Visual Studio Code or another preferred tool.
1. Select `Open Folder...` from the File menu (or Ctrl+K Ctrl+O) and open `tf-amba-alz`
1. Open a Terminal (PowerShell).

    {{< hint type=note >}}
    Depending on the tool being used, it may be necessary to change the terminal to the `tf-amba-alz` directory.
    {{< /hint >}}

1. Download `terraform.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-architecture-definition/terraform.tf -OutFile terraform.tf
    ```

1. Download `main.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-architecture-definition/main.tf -OutFile main.tf
    ```

1. Download `variables.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-architecture-definition/variables.tf -OutFile variables.tf
    ```

1. The source and version of the module need to be updated in `main.tf`. Find `module "amba_alz"` and replace

    ```hcl
    source = "../../"
    ```

    With:

    ```hcl
    source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
    version = "0.1.1"
    ```

1. Review the variables in `variables.tf` and update default values as needed.
1. Set up a directory to store the custom library assets:

    ```powershell
    New-Item -name lib -ItemType directory
    ```

1. Download the `custom.alz_architecture_definition.json` file to the `lib` directory.

    ```cmd
    cd .\lib\
    ```

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-architecture-definition/lib/custom.alz_architecture_definition.json -OutFile custom.alz_architecture_definition.json
    ```

1. Adjust the management group `display name`, `id` and `parent id` in custom.alz_architecture_definition.json.
1. Return to the `tf-amba-alz` directory in the terminal. `cd..`
1. Log in to Azure: `az login`
1. Run: `terraform init`
1. Run: `terraform apply`

## Example of deploying with Custom Policy Assignments

It is possible to tailor the Policy Definitions that are deployed and assigned by developing custom archetypes. This example demonstrates a situation where only Service Health is deployed, but can be applied to other policy assignments as well:

- Deploy using a custom management group hierarchy defined by architecture definition file in the local library.
- Use a custom root archetype to ensure that the Service Health policy definitions and assignments are deployed.

Deployment:

1. Create a new directory, for example `tf-amba-alz`.
1. Open Visual Studio Code or another preferred tool.
1. Select `Open Folder...` from the File menu (or Ctrl+K Ctrl+O) and open `tf-amba-alz`
1. Open a Terminal (PowerShell).

    {{< hint type=note >}}
    Depending on the tool being used, it may be necessary to change the terminal to the `tf-amba-alz` directory.
    {{< /hint >}}

1. Download `terraform.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-policy-assignment/terraform.tf -OutFile terraform.tf
    ```

1. Download `main.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-policy-assignment/main.tf -OutFile main.tf
    ```

1. Download `variables.tf`

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-policy-assignment/variables.tf -OutFile variables.tf
    ```

1. The source and version of the module need to be updated in `main.tf`. Find `module "amba_alz"` and replace

    ```hcl
    source = "../../"
    ```

    With:

    ```hcl
    source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
    version = "0.1.1"
    ```

1. Review the variables in `variables.tf` and update default values as needed.
1. Set up a directory to store the custom library assets:

    ```powershell
    New-Item -name lib -ItemType directory
    ```

1. Download the `custom.alz_architecture_definition.json` file to the `lib` directory.

    ```cmd
    cd .\lib\
    ```

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-policy-assignment/lib/custom.alz_architecture_definition.json -OutFile custom.alz_architecture_definition.json
    ```

1. Adjust the management group `display name`, `id` and `parent id` in custom.alz_architecture_definition.json.
1. Download the `root.alz_archetype_definition.json` file to the `lib` directory.

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/refs/heads/main/examples/custom-policy-assignment/lib/root.alz_archetype_definition.json -OutFile root.alz_archetype_definition.json
    ```

1. Return to the `tf-amba-alz` directory in the terminal. `cd..`
1. Log in to Azure: `az login`
1. Run: `terraform init`
1. Run: `terraform apply`

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).
