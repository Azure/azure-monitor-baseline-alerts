---
title: Adopting Azure Monitor health models
weight: 20
---

> [!important]
> [Azure Monitor health models](https://learn.microsoft.com/azure/azure-monitor/health-models/overview) are in public preview. Product capabilities and this guidance may change.

### In this page

> [Overview](../Health-Models-Adoption#overview) </br>
> [What AMBA-ALZ delivers](../Health-Models-Adoption#what-amba-alz-delivers) </br>
> [What a health model adds](../Health-Models-Adoption#what-a-health-model-adds) </br>
> [AMBA alerts become signals](../Health-Models-Adoption#amba-alerts-become-signals) </br>
> [Health models at Landing Zone scale](../Health-Models-Adoption#health-models-at-landing-zone-scale) </br>
> [Health model adoption path](../Health-Models-Adoption#health-model-adoption-path) </br>
> [References](../Health-Models-Adoption#references) </br>

## Overview

Azure Landing Zones provide a repeatable structure for Azure at scale. AMBA-ALZ uses Azure Policy to deploy alert rules across the management group hierarchy. Azure Monitor health models organize monitoring data into a graph of entities that shows the current health of a workload or platform.

AMBA alert rules and health model signals can evaluate the same Azure Monitor data, but they use the result differently:

- **AMBA alert rule:** Creates an alert when a metric, log query, or activity log event meets its criteria.

- **Health model signal:** Sets an entity's health state. Relationships roll that state up to the system flows and services that depend on the entity. You choose which entity state changes create alerts.

This page compares the two and describes how to introduce a health model into a landing zone.

## What AMBA-ALZ delivers

AMBA-ALZ deploys alert rules with Azure Policy, scoped to the Azure Landing Zones management group hierarchy:

- **An alert catalog for Azure services.** AMBA-ALZ deploys the subset of AMBA alert definitions tagged for ALZ. See [Alerts Details](../../getting-started/Alerts-Details) and the [metric](../../getting-started/Metric-Alerts-Table), [log search](../../getting-started/Log-Search-Alerts-Table), and [activity log](../../getting-started/Activity-Log-Alerts-Table) tables.
- **Initiatives for management groups and resource families.** AMBA-ALZ groups related policies into initiatives for management group archetypes and resource families. See [Policy Initiatives](../../getting-started/Policy-Initiatives).
- **Policy-based deployment.** Most policy definitions use `DeployIfNotExists` to deploy missing alert rules. See [Remediate Policies](../../HowTo/deploy/Remediate-Policies).
- **Tag-based configuration.** Tags can disable monitoring for a resource or override one of its alert thresholds. See [Disable Policies](../../HowTo/Disabling-Policies) and [Override alert thresholds](../../HowTo/Threshold-Override).
- **Central notification configuration.** AMBA-ALZ can deploy an action group and an alert processing rule to each subscription, or use resources that you provide. See [Bring Your Own Notifications](../../HowTo/Bring-your-own-Notifications).

Assigning an initiative at a management group applies a consistent alert baseline to subscriptions in that scope.

AMBA-ALZ does not model dependencies between alert rules. An ExpressRoute circuit, a firewall, and a gateway can support one connectivity service, but their alerts remain independent. An operator must assess their combined effect.

## What a health model adds

A health model is a `Microsoft.CloudHealth/healthmodels` resource. It contains a graph of entities and rules that turn monitoring data into a health state for each entity.

Entities can represent Azure resources, platform components, user flows, or system flows. Health models use these entities to add:

- **Consolidated alerts.** Multiple signals determine one entity state. An alert on that entity fires once when its state changes to degraded or unhealthy.
- **Explicit dependencies.** Relationships describe which components a service depends on and how their health affects the parent entity.
- **Health history.** Graph and timeline views show current and past entity states.

![A health model for a landing zone](../../media/a-health-model-for-a-landing-zone.svg)

The Online landing zone uses **Limited** impact in this example. Its unhealthy state degrades the tenant without making the tenant unhealthy.

AMBA does not represent a landing zone, platform domain, or system flow as an entity. A health model can represent each one and connect it to Azure resources through [relationships](https://learn.microsoft.com/azure/azure-monitor/health-models/rollup). Each entity has a [health state](https://learn.microsoft.com/azure/azure-monitor/health-models/concepts). You can set a [health objective](https://learn.microsoft.com/azure/azure-monitor/health-models/concepts) on the root and create [alerts](https://learn.microsoft.com/azure/azure-monitor/health-models/alerts) for entity state changes.

Use the [designer](https://learn.microsoft.com/azure/azure-monitor/health-models/designer) to build the model, the [health state views](https://learn.microsoft.com/azure/azure-monitor/health-models/analyze-health) to inspect it, or the [Azure CLI](https://learn.microsoft.com/azure/azure-monitor/health-models/cli) to configure it.

## AMBA alerts become signals

The health model designer can import an existing alert rule for the Azure resource represented by an entity. The import creates a signal with the alert rule's criteria.

![AMBA alerts become health model signals](../../media/amba-alerts-become-health-model-signals.svg)

Read the diagram from bottom to top. Signals determine resource entity state. Resource entities roll up into system flows, then into a domain flow and the domain root.

Hybrid connectivity uses a **not-healthy limit** because it has a failover path. Configure the limit to degrade the flow when one path is unhealthy and mark it unhealthy when both paths are unhealthy. The diagnostics pipeline uses **Suppressed** impact, so its degraded state remains visible without affecting the connectivity flow.

| AMBA-ALZ construct | Health model equivalent | Notes |
| --- | --- | --- |
| Metric alert | Azure resource signal | Direct equivalent. Namespace, metric name and aggregation carry over. |
| Log search alert | Log Analytics workspace signal | Equivalent in principle. The AMBA query logic often needs adaptation. |
| Resource Health activity log alert | Azure Resource Health signal | Uses the resource's platform-reported availability as an entity signal. |
| Service Health activity log alert | No equivalent | Service Health is a subscription-level activity log event, not an entity signal type. |
| Monitored Azure resource | Azure resource entity | One resource can appear in multiple models, with an independent state in each model. |
| A service built from several resources | Generic entity with children | No AMBA-ALZ counterpart. Dependency between resources is what the entity graph expresses. |
| ALZ platform domain | Parent domain entity with a child domain model | The parent discovers the tagged child health model. The child model discovers scoped Azure resources where configured. |
| `MonitorDisable` tag | A `where` clause in the discovery query | Resource Graph discovery filters on tags, so one tag can govern both. |
| Threshold override tag | No equivalent | Set thresholds directly on each health model signal. |
| Action group | The same action group | Health model alerts use the action groups you already have. |

## Health models at Landing Zone scale

Use nested health models to separate tenant, domain, platform, and system flow ownership. A parent model at tenant scale holds one entity per landing zone domain. Each domain entity receives the root state of a separately deployed child model, not the child's internal entity graph.

The [Azure Landing Zones Bicep accelerator](https://github.com/Azure/alz-bicep-accelerator) deploys this shape as a starter topology in [draft pull request 167](https://github.com/Azure/alz-bicep-accelerator/pull/167). It creates one parent model, `ahm-alz-platform`, and one child model per ALZ domain: `ahm-alz-security`, `ahm-alz-identity`, `ahm-alz-connectivity`, `ahm-alz-management`, and `ahm-alz-landing-zones`.

![Health models at tenant scale](../../media/health-models-at-tenant-scale.svg)

Each parent domain entity runs a tag-filtered Resource Graph discovery rule that finds the matching child health model resource. The child's root state rolls up through that discovered entity. The parent does not contain or own the child's entities, so each domain team changes its own model independently.

The current pull request gives every child model one healthy dummy entity to confirm the deployment succeeded. The diagram labels that entity as a deployment check because it does not measure domain health. Replace it with the platform and system flows the domain provides.

Child models run their own discovery rules, a separate layer from the parent's tag discovery. The four platform domains can discover configured Azure resource types and add recommended signals. The landing zones domain discovers other health models only after you configure management groups and deploy Reader access to them. Cross-subscription Reader is opt-in.

Pull request 167 is a draft. Treat its resource names, scopes, and permissions as a starting point rather than a supported contract.

![A referenced connectivity domain health model](../../media/connectivity-contoso-prod.svg)

A refined child model carries the flows, resources, and signals for its domain. Its root state is what the parent domain entity receives.

The same Azure resource can appear in multiple health models. Each model evaluates its own signals and maintains an independent state for that resource.

![One resource, two models](../../media/one-resource-two-models.svg)

The hub firewall is one resource. The connectivity model evaluates SNAT port use and tunnel state. The partner exchange model evaluates threat intelligence hits and denied flows.

## Health model adoption path

Start from an empty or placeholder child model and build it out in three stages:

1. **Discovery:** Inventory Azure resources in each platform domain and nested health models in the landing zones domain.
2. **Analyze and model:** Define the platform and system flows you provide, their dependencies, and the signals that measure them.
3. **Refine:** Adjust topology, signals, rollup settings, objectives, and alerts as you validate the model.

### 1. Discovery

Configure an Azure resource discovery rule in each platform child model. For the landing zones child, configure the management groups that contain the health models you want to discover and grant Reader access. Inventory each domain before you define the health of a platform or system flow.

![Adoption step 1, discovery](../../media/adoption-step-1-discovery.svg)

A [Resource Graph discovery rule](https://learn.microsoft.com/azure/azure-monitor/health-models/discoveries) can add matching Azure resources and their recommended signals to the domain.

- The **Add recommended signals** option adds predefined signals for supported resource types.
- An entity uses the worst state of its signals. The default **Worst of** dependencies setting then propagates the worst child state to its parent. Tune thresholds, impact, and dependency settings before using the model for alerting.

### 2. Analyze and model

Define the platform and system flows that you provide, such as egress control, secret management, and hybrid connectivity.

Add the Azure resources that support each flow, then select signals that measure whether those resources perform their role. Relationships roll resource state up to the parent flow and domain.

![Adoption step 2, analyze](../../media/adoption-step-2-analyze.svg)

Repeat this process for each platform child model. Compare the result with the discovery inventory to find resources that you have not assigned to a flow. In the landing zones child, organize the discovered health models around the services they represent.

### 3. Refine

Combine manually modeled entities with discovery rules where resources change often. Split paths that fail independently, set the rollup behavior on each parent entity, then set an objective on the root.

![Adoption step 3, refine](../../media/adoption-step-3-refine.svg)

In this example, hybrid connectivity has primary and failover paths. The **not-healthy limit** degrades the flow when one path is unhealthy and marks it unhealthy when both paths are unhealthy. Configure alerts on the system flow or root when those states represent an operational issue.

## References

Azure Monitor health models:

- [Health models in Azure Monitor (preview)](https://learn.microsoft.com/azure/azure-monitor/health-models/overview)
- [Health model concepts](https://learn.microsoft.com/azure/azure-monitor/health-models/concepts)
- [Signals](https://learn.microsoft.com/azure/azure-monitor/health-models/signals)
- [Alerts](https://learn.microsoft.com/azure/azure-monitor/health-models/alerts)
- [Create discovery rules](https://learn.microsoft.com/azure/azure-monitor/health-models/discoveries)
- [Create a health model](https://learn.microsoft.com/azure/azure-monitor/health-models/create)
- [Configure health rollup](https://learn.microsoft.com/azure/azure-monitor/health-models/rollup)
- [Configure using the designer](https://learn.microsoft.com/azure/azure-monitor/health-models/designer)
- [Analyze health state](https://learn.microsoft.com/azure/azure-monitor/health-models/analyze-health)
- [Create a health model with the Azure CLI](https://learn.microsoft.com/azure/azure-monitor/health-models/cli)
- [Health models FAQ](https://learn.microsoft.com/azure/azure-monitor/health-models/health-models-faq)

Resource provider reference:

- [Microsoft.CloudHealth/healthmodels](https://learn.microsoft.com/azure/templates/microsoft.cloudhealth/healthmodels)
- [az monitor health-models](https://learn.microsoft.com/cli/azure/monitor/health-models)

Wider guidance:

- [Well-Architected health modeling design guide](https://learn.microsoft.com/azure/well-architected/design-guides/health-modeling)
