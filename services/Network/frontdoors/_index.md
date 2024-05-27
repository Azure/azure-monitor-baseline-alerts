---
title: frontdoors
geekdocCollapseSection: true
geekdocHidden: false
---
Azure front door includes a number of built in reports and hence its important to check the built-in report in Azure front door.

Azure front door report list and usage scenario:
1. [Traffic by domain](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#traffic-by-domain-report)
2. [Traffic by location](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#traffic-by-location-report)
3. [Usage report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#usage-report)
4. [Caching report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#caching-report)
5. [Top URL report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#top-url-report)
6. [Top referrer report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#top-referrer-report)
7. [Top user agent report](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-reports?tabs=traffic-by-domain#top-user-agent-report)

Every report contains the following key metrics
Peak bandwidth
Requests
Cache hit ratio
Total latency
5XX error rate

For availability total number of 5xx error rate would identify backend dropping request. Carefully analyze the percentage of 5XX over total request to get the percentage of request which had error. In Addition to 5xx, 4xx error rate also contribute to the unavailability of web application and hence analyze 4xx metrics for backend availability and error rate.


Azure front door also integrate with Azure monitor and its important to create [alert](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-monitor-metrics) based on key threshold for availability and performance such as 4XXErrorRate or 5XXErrorRate



```mermaid
flowchart LR
    A[Performance Monitoring]-->A1[Traffic Pattern Analysis]
    A1-->A3[Origin request count]
    A1-->A4[Origin Latency]
    A1-->A5[Cache Hit Ratio]
    A1-->A6[Byte Hit Ratio]
    A1-->A6[Total Latency]
    A1-->A6[Request size]
    A1-->A6[Response size]

    B[Connectivity Monitoring]-->B1[Exception Analysis]
    B1-->B2[Percentage 4xx]
    B1-->B3[Percentage 5xx]
    B1-->B4[Origin Health Percentage]

    D[Security Monitoring]-->D1[Webapplication firewall request count]
    D-->D2[Webapplication firewall JS request count]


```


{{< alertList name="alertList" >}}
