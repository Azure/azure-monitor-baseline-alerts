---
title: Contributor Guide
weight: 15
geekdocCollapseSection: true
---
{{< hint type=note >}}

*Currently we can only accept contributions from Microsoft FTEs. In the future we will look to change this*

{{< /hint >}}

Looking to contribute to the Azure Monitor Baseline Alerts (AMBA) repo, well you have made it to the right place/page 👍

Follow the below instructions, especially the pre-requisites, to get started contributing to the library.

## Quickstart Guide

If you are looking to help contribute to the definition and guidance for Baseline Alerts, then this section will give you the shortcut way without having deal with the more advance components of this site.

The example folder structure below highlights all of the key assets that define and/or support the content of this site:

```plaintext
├── patterns
│   └── alz
│
└── services
    ├── _index.md
    └── Compute
        ├── _index.md
        └── virtualMachines
            ├── _index.md
            ├── alerts.yaml
            ├── Deploy-VM-AvailableMemory-Alert.json
            └── Deploy-VM-DataDiskReadLatency-Alert.json
```

**patterns:** *This folder contains assets for pattern/scenario specific guidance that leverages the baseline alerts in this repo.  This guide does not cover contributions to the patterns/scenarios section.  There will be specific guides within each pattern/scenarios section.*

**services:** *This folder contains the baseline alert definitions, guidance, and example deployment scripts. It is grouped by resource provider (e.g. Compute), and then by resource type (e.g. virtualMachines).*

{{< hint type=note >}}
You may need to add new resource provider and/or resource type folders as you define new baseline alerts. These folders are case-sensitive and follow the naming conventions defined by the [Azure Resource Reference](https://learn.microsoft.com/azure/templates/) documentation. For example: Alert guidance for  Microsoft.Compute/virtualMachines would go under 'services/Compute/virtualMachines'
{{< /hint >}}

**_index.md:** *These files control the menu structure and the content layout for GitHub Pages site. There are only two versions of these files, one for the resource providers, which just controls the friendly name in the menu and title.  The other version is at the resource type level and it controls the layout of the GitHub Pages site.  As you create new folders, just copy the respective versions and change the title in the metadata section at the top of the file.*

**alerts.yaml:** *This YAML-based file contains the detailed definition and guidance for the baseline alerts within each resource provider/type folder. Below is the general structure of the file.*

```yaml
- name: <alert name>
  description: <alert description>
  type: <alert type>
  properties:
    <list of properties that define the alert base on type>
  references:
  - <list of urls the contain additional guidance for the alert>
  deployments:
  - <a list of example deployment templates for the alert>
```

Here is an example of an alert definition for an Azure Virtual Machine (Microsoft.Compute/virtualMachines).

```yaml
- name: Available Memory Bytes (MBytes)
  description: Metric Alert for Virtual Machine Available Memory Bytes (MBytes)
  type: Metric
  verified: true
  visible: true
  tags:
  - alz
  properties:
    metricName: Available Memory Bytes
    metricNamespace: Microsoft.Compute/virtualMachines
    severity: 2
    windowSize: PT5M
    evaluationFrequency: PT5M
    timeAggregation: Average
    operator: LessThan
    threshold: 1000
    criterionType: StaticThresholdCriterion
  references:
  - name: Supported Metrics for Microsoft.Compute/virtualMachines
    urls: https://learn.microsoft.com/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics
  deployments:
  - description: Policy to audit/deploy VM Available Memory Bytes (MBytes) Alert
    template: Deploy-VM-AvailableMemory-Alert.json
```

{{< hint type=note >}}
Please note the following settings in the alert definition:

- *verified:* Alert has verified by the PG.
- *visible:* Alert is visible on the website.
- *tags:* Tags for filtering alerts based on scenario/pattern (e.g. alz)
{{< /hint >}}

## Auto-Generated Alert Rules

A script was run to automatically generate alert rules based on top usage and settings trends.  These rules have been added to their respective *alerts.yaml* files and have two tags associated with them: *auto-generated* and *agc-xxxx*.  The *agc-xxxx* tag indicates the number of results found for that alert rule in the query used to analyze the top trends.  This number should be used to evaluate the importance of including that alert rule as guidance in the repo.  Once an auto-generated alert rule has been verified and updated with reference documentation, the *visible* property should be set to *true*.  This will make the alert rule visible on the site.  Resource providers and types that do not have visible alerts are currently hidden from the table of contents.  To make those resource providers and types visible, edit their respective *_index.md* files and remove the *geekdocHidden: true* metadata from the top of the file.

## Context/Background

Before jumping into the pre-requisites and specific section contribution guidance, please familiarize yourself with this context/background on how this library is built to help you contribute going forward.

This [site](https://azure.github.io/azure-monitor-baseline-alerts) is built using [Hugo](https://gohugo.io/), a static site generator, that's source code is stored in the [AMBA GitHub repo](https://github.com/Azure/azure-monitor-baseline-alerts) (link in header of this site too) and is hosted on [GitHub Pages](https://pages.github.com), via the repo.

The reason for the combination of Hugo & GitHub pages is to allow us to present an easy to navigate and consume library, rather than using a native GitHub repo, which is not easy to consume when there are lots of pages and folders. Also Hugo generates the site in such a way that it is also friendly for mobile consumers.

### But I don't have any skills in Hugo?

That's okay and you really don't need them. Hugo just needs you to be able to author markdown (`.md`) files and it does the rest when it generates the site 👍

## Pre-Requisites

Read and follow the below sections to leave you in a "ready state" to contribute to AMBA.

A "ready state" means you have a forked copy of the [`Azure/azure-monitor-baseline-alerts` repo](https://github.com/Azure/azure-monitor-baseline-alerts) cloned to your local machine and open in VS Code.

## Run and Access a Local Copy of AMBA During Development

When in VS Code you should be able to open a terminal and run the below commands to access a copy of the AMBA website from a local web server, provided by Hugo, using the following address [`http://localhost:1313/azure-monitor-baseline-alerts/`](http://localhost:1313/azure-monitor-baseline-alerts/):

```text
hugo server -D
```

### Software/Applications

To contribute to this project/repo/library, you will need the following installed:

{{< hint type=note >}}

You can use `winget` to install all the pre-requisites easily for you. See the [below section](#winget-install-commands)

{{< /hint >}}

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Visual Studio Code (VS Code)](https://code.visualstudio.com/Download)
  - Extensions:
    - `editorconfig.editorconfig`, `streetsidesoftware.code-spell-checker`, `ms-vsliveshare.vsliveshare`, `medo64.render-crlf`, `vscode-icons-team.vscode-icons`
    - VS Code will recommend automatically to install these when you open this repo, or a fork of it, in VS Code.
- [Hugo Extended](https://gohugo.io/installation/)

### winget Install Commands

To install `winget` follow the [install instructions here.](https://learn.microsoft.com/windows/package-manager/winget/#install-winget)

```text
winget install --id 'Git.Git'
winget install --id 'Microsoft.VisualStudioCode'
winget install --id 'Hugo.Hugo.Extended'
```

### Other requirements

- [A GitHub profile/account](https://github.com/join)
- A fork of the [`Azure/azure-monitor-baseline-alerts` repo](https://github.com/Azure/azure-monitor-baseline-alerts) into your GitHub org/account and cloned locally to your machine
  - Instructions on forking a repo and then cloning it can be found [here](https://docs.github.com/get-started/quickstart/fork-a-repo)

## Useful Resources

Below are links to a number of useful resources to have when contributing to AMBA:

- [GeekDocs Documentation Theme (that we use) - Docs](https://geekdocs.de/usage/getting-started/)
- [Hugo Quick Start](https://gohugo.io/getting-started/quick-start/)
- [Hugo Docs](https://gohugo.io/documentation/)
- [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)

## Steps to do before contributing anything (after pre-requisites)

Run the following commands in your terminal of choice from the directory where your fork of the repo is located:

```text
git checkout main
git pull
git fetch -p
git fetch -p upstream
git pull upstream main
git push
```

Doing this will ensure you have the latest changes from the upstream repo and you are ready to now create a new branch from `main` by running the below commands:

```text
git checkout main
git checkout -b <YOUR-DESIRED-BRANCH-NAME-HERE>
```

## Creating a pull request

Once you have committed changes to your fork of the AMBA repo, you create a pull request to merge your changes into the AMBA repo.

- [GitHub - Creating a pull request from a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/)

## Top Tips

1. Sometimes the local version of the website may show some inconsistencies that don't reflect the content you have created.

- If this happens, kill the Hugo local web server by pressing <kbd>CTRL</kbd>+<kbd>C</kbd> and then restart the Hugo web server by running `hugo server -D` from the root of the repo.
