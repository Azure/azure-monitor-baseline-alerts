---
title: frontdoors
geekdocCollapseSection: true
geekdocHidden: false
---
Azure Front Door includes built in reports and hence its important to check built-in report for Azure Front Door and use them where it’s possible before creating any custom reports.

Below are some of the reports with the list of usage and scenario:

1. [Traffic by domain](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#traffic-by-domain-report)
2. [Traffic by location](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#traffic-by-location-report)
3. [Usage report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#usage-report)
4. [Caching report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#caching-report)
5. [Top url report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#top-url-report)
6. [Top referrer report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#top-referrer-report)
7. [Top user agent report](https://learn.microsoft.com/azure/frontdoor/standard-premium/)

Each report contains the following key metrics which are helpful in determining performance and availability of Azure Front Door and origin.

Peak bandwidth. <br>
Requests. <br>
Cache hit ratio. <br>
Total latency. <br>
5XX error rate. <br>

For availability total number of 5xx error rate would identify origin which is dropping requests. For detailed availability, analyze percentage of 5XX over total request to get the percentage of request and it will give you which origin or back-end requires further troubleshooting. In addition to 5xx, 4xx error rate also contributes to unavailability of web application and hence analyze 4xx metrics further aide in analyzing back-end availability.
Azure Front Door also integrate with Azure monitor, and it is important to create [alert](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-monitor-metrics) based on key threshold for availability and performance such as 4XXErrorRate or 5XXErrorRate.
The following workflow chart will also help in the selection of key metrics for each use case.


```mermaid
flowchart LR
    AFD[Azure Front Door]-->A[Performance monitoring]
    A-->A1[Traffic pattern analysis]
    A1-->A3[Origin request count]
    A1-->A4[Origin latency]
    A1-->A5[Cache hit ratio]
    A1-->A6[Byte hit ratio]
    A1-->A7[Total latency]
    A1-->A8[Request size]
    A1-->A9[Response size]
    AFD-->B[Connectivity monitoring]
    B-->B1[Exception analysis]
    B1-->B2[Percentage 4xx]
    B1-->B3[Percentage 5xx]
    B-->B4[Availability]
    B4-->B5[Origin health percentage]
    AFD-->D[Security monitoring]
    D-->D1[Webapplication firewall request count]
    D-->D2[Webapplication firewall JS request count]
```
{{< alertList name="alertList" >}}
{{ if .Store.Get "hasMermaid" }}
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
    mermaid.initialize({ startOnLoad: true });
  </script>
{{ end }}
