---
title: loadBalancers
geekdocCollapseSection: true
geekdocHidden: false
---

Load Balancer Monitoring Design

Load balancer(Internal & external ) in Azure distribute traffic to the backend applications and hence when it come to monitoring there are multiple use cases for monitoring. Usually the intent of monitoring is either to monitor application or the availability of the load balancer. Load balancer is exposed internally & externally and therefore data path availability is another dimension which may requires monitoring. Telemetry from session analysis, response time analysis and connectivity analysis aid in analyzing root cause of performance issue of a load balancer and underlying application.

We could look in detail into snat port exhausting or port already in used When load balancer is not responding or accepting new connection to see and understand the pattern of traffic.

the following diagram explains some of the most common scenario and use cases for load balancer monitoring.


```mermaid
flowchart LR
    A[Performance Monitoring]-->B[Bandwidth Usage Analysis]
    A-->C[Session Analysis]
    A-->D[Response Time Analysis]
    B-->R2[Bytecount]
    B-->R13[Packetcount]
    C-->R3[SnatconnectionCount]
    C-->R4[DipAvailability]
    D-->PM[Use Network Performance Monitor]
    A-->CA[Connectivity Analysis]
    CA-->CNN[Concurrent Connection]
    CA-->NC[New Connection]
    CA-->CE[Connection Error Rate]
    CNN-->R5[Allocatedsnatports]
    CNN-->R6[Usedsnartports]
    NC-->R7[SnatconnectionCount]
    CE-->R8[SynCount]
    AA[Availability Analysis]-->HC[Backend availability]
    AA-->FOD[Failover Detection]
    AA-->AR[Load Balancer Availability]
    HC-->R10[DipAvailability]
    FOD-->R11[HealthProbLog]
    AR-->R12[VipAvailability]



```

{{< alertList name="alertList" >}}

{{ if .Store.Get "hasMermaid" }}
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
    mermaid.initialize({ startOnLoad: true });
  </script>
{{ end }}
