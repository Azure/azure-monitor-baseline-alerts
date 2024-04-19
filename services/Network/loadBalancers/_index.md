---
title: loadBalancers
geekdocCollapseSection: true
geekdocHidden: false
---

Load Balancer Monitoring Design

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
    CE-->R8[SyncCount]
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
