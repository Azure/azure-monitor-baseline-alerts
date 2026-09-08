# Diagram sources for the health models adoption page

These mermaid blocks are the source of the SVGs used by
`docs/content/patterns/alz/Overview/Health-Models-Adoption.md`.

This directory is not mounted into Hugo in `config/_default/hugo.toml`, so this
file is never published.

Regenerate the SVGs with [ahm-diagrammo](https://github.com/abossard/ahm-diagrammo). The committed SVGs are the published artifacts:

```bash
# Render into a scratch directory: the CLI also writes gallery.html and
# manifest.json, which do not belong in the media folder.
npx --yes github:abossard/ahm-diagrammo#c9a96d200a92d9f25830eeb1e1ad4f293b84b33c \
  docs/diagram-sources/health-models.md \
  --out /tmp/health-model-svg --strict
cp /tmp/health-model-svg/*.svg docs/content/patterns/alz/media/

# The plain mermaid renderer emits width="100%" and no height, which collapses to
# 300x36 when the SVG is embedded as <img>. Give those files an intrinsic size
# taken from their own viewBox. The swimlane renderer already sets both.
python3 - <<'PY'
import glob, re
for f in glob.glob('docs/content/patterns/alz/media/*.svg'):
    s = open(f).read()
    if 'width="100%"' not in s:
        continue
    w, h = re.search(r'viewBox="[\d.]+ [\d.]+ ([\d.]+) ([\d.]+)"', s).groups()
    s = s.replace('width="100%"', f'width="{round(float(w))}" height="{round(float(h))}"', 1)
    open(f, 'w').write(s)
    print('sized', f)
PY
```

The output file name comes from each block's `title=`. Changing a title renames
the SVG, so update the image reference in the page at the same time.

Node color is set by the `class` assignment, not by the label text:
`blue` is a signal, `green` is healthy, `amber` is degraded, and `red` is unhealthy.

## Diagram 1: AMBA alerts become signals

```mermaid swimlane title="AMBA alerts become health model signals" subtitle="Signals set entity health, entities roll up, only the root carries the objective"
%%| lanes: ["Domain root", "Domain flows", "System flows", "Azure resources and their signals"]
flowchart BT
    erSig["ExpressRoute BGP availability = 98.7% (unhealthy)<br/>Ingress bits = 1.4 Gbps (healthy)"] --> er["ExpressRoute circuit<br/>unhealthy"]
    vpnSig["Azure Resource Health = Available (healthy)"] --> vpn["VPN gateway<br/>healthy"]
    lawSig["Log ingestion latency = 9 min (degraded)"] --> law["Log Analytics workspace<br/>degraded"]

    er --> primary["Primary path<br/>(worst of)<br/>unhealthy"]
    vpn --> backup["Failover path<br/>healthy"]
    law --> diag["Diagnostics pipeline<br/>degraded"]

    primary --> flow["Hybrid connectivity<br/>(not-healthy limit)<br/>degraded"]
    backup --> flow
    diag -. "suppressed" .-> flow

    flow --> root["Connectivity domain<br/>objective 99.9%<br/>degraded"]

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    classDef red fill:#faeceb,stroke:#ba0d16;
    class erSig,vpnSig,lawSig blue;
    class vpn,backup green;
    class law,diag,flow,root amber;
    class er,primary red;
```

## Diagram 2: Entities in a landing zone

```mermaid swimlane title="A health model for a landing zone" subtitle="Platform domains and landing zones roll up into one tenant view"
%%| lanes: ["Tenant root", "Platform and landing zones", "Platform domains and their signals"]
flowchart BT
    idSig["Key Vault availability = 100%<br/>Vault capacity = 12%"] --> identity["Identity<br/>healthy"]
    mgmtSig["Log ingestion latency = 9 min (degraded)<br/>Backup job failures = 0"] --> mgmt["Management<br/>degraded"]
    connSig["ExpressRoute BGP availability = 99.1% (degraded)<br/>Firewall SNAT port usage = 42%<br/>VPN tunnel state = connected"] --> conn["Connectivity<br/>degraded"]

    identity --> platform["Platform<br/>(worst of)<br/>degraded"]
    mgmt --> platform
    conn --> platform

    corpSig["Availability = 99.98%<br/>P95 latency = 210 ms"] --> corp["Corp landing zone<br/>healthy"]
    onlineSig["Availability = 97.1% (unhealthy)<br/>Failed requests = 4.2% (unhealthy)"] --> online["Online landing zone<br/>unhealthy"]

    platform --> tenant["Tenant health<br/>(worst of)<br/>objective 99.5%<br/>degraded"]
    corp --> tenant
    online -. "limited impact" .-> tenant

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    classDef red fill:#faeceb,stroke:#ba0d16;
    class idSig,mgmtSig,connSig,corpSig,onlineSig blue;
    class identity,corp green;
    class mgmt,conn,platform,tenant amber;
    class online red;
```

## Diagram 3: Health models at tenant scale

```mermaid swimlane title="Health models at tenant scale" subtitle="Each child root state rolls up through its discovered parent-domain entity"
%%| lanes: ["Parent model root", "Parent domain entities", "Tagged child-model discovery", "Deployment checks"]
flowchart BT
    secPh["Dummy entity<br/>(deployment check only)<br/>healthy"] --> secHM["ahm-alz-security<br/>healthy"]
    idPh["Dummy entity<br/>(deployment check only)<br/>healthy"] --> idHM["ahm-alz-identity<br/>healthy"]
    connPh["Dummy entity<br/>(deployment check only)<br/>healthy"] --> connHM["ahm-alz-connectivity<br/>healthy"]
    mgmtPh["Dummy entity<br/>(deployment check only)<br/>healthy"] --> mgmtHM["ahm-alz-management<br/>healthy"]
    lzPh["Dummy entity<br/>(deployment check only)<br/>healthy"] --> lzHM["ahm-alz-landing-zones<br/>healthy"]

    secHM --> security["Security<br/>healthy"]
    idHM --> identity["Identity<br/>healthy"]
    connHM --> conn["Connectivity<br/>healthy"]
    mgmtHM --> mgmt["Management<br/>healthy"]
    lzHM --> lz["Landing zones<br/>healthy"]

    security --> platform["ahm-alz-platform<br/>healthy"]
    identity --> platform
    conn --> platform
    mgmt --> platform
    lz --> platform

    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    class secPh,idPh,connPh,mgmtPh,lzPh,secHM,idHM,connHM,mgmtHM,lzHM,security,identity,conn,mgmt,lz,platform green;
```

## Diagram 4: A referenced domain model

```mermaid swimlane title="Connectivity-Contoso-Prod" subtitle="The referenced model carries the entities and the signals"
%%| lanes: ["Model root", "Flows", "System flows", "Azure resources and their signals"]
flowchart BT
    erSig["ExpressRoute BGP availability = 98.7% (unhealthy)<br/>Ingress bits = 1.4 Gbps (healthy)"] --> er["ExpressRoute circuit<br/>unhealthy"]
    vpnSig["Azure Resource Health = Available (healthy)"] --> vpn["VPN gateway<br/>healthy"]
    fwSig["SNAT port utilization = 42% (healthy)<br/>Firewall health = 100%"] --> fw["Azure Firewall<br/>healthy"]

    er --> primary["Primary path<br/>(worst of)<br/>unhealthy"]
    vpn --> backup["Failover path<br/>healthy"]
    fw --> egress["Egress inspection<br/>healthy"]

    primary --> flow["Hybrid connectivity<br/>(not-healthy limit)<br/>degraded"]
    backup --> flow
    egress --> flow

    flow --> root["Connectivity-Contoso-Prod<br/>degraded"]

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    classDef red fill:#faeceb,stroke:#ba0d16;
    class erSig,vpnSig,fwSig blue;
    class vpn,backup,fw,egress green;
    class flow,root amber;
    class er,primary red;
```

## Diagram 5: One resource in two models

```mermaid swimlane title="One resource, two models" subtitle="The same firewall with signals selected for each model"
%%| lanes: ["Portfolio", "Targeted models", "Entities"]
flowchart BT
    connSig["SNAT port utilization = 42%<br/>Tunnel state = connected"] --> fwConn["Azure Firewall<br/>connectivity concern<br/>healthy"]
    excSig["Threat intel hits = 128 (degraded)<br/>Denied partner flows = 4.1k"] --> fwExc["Azure Firewall<br/>partner concern<br/>degraded"]

    fwConn --> connModel["hm-conn-partner<br/>healthy"]
    fwExc --> excModel["hm-partner-exchange<br/>degraded"]

    connModel --> root["Group platform health<br/>objective 99.5%<br/>degraded"]
    excModel --> root

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    class connSig,excSig blue;
    class fwConn,connModel green;
    class fwExc,excModel,root amber;
```

## Diagram 6: Adoption step 1, discovery

Use the plain mermaid renderer here with `%%| renderer: mermaid`. It keeps this
wide, shallow inventory compact and preserves the health classes, so recommended
signal states remain visible.

```mermaid title="Adoption step 1, discovery"
%%| renderer: mermaid
flowchart TB
    root["Contoso-Prod estate"] --> conn["Connectivity"]
    root --> id["Identity"]
    root --> mgmt["Management"]
    root --> lz["Landing zones"]

    conn --> hyb["Hybrid links"]
    conn --> hub["Hub networking"]
    conn --> dns["DNS"]
    id --> dc["Domain services"]
    id --> kv["Key vaults"]
    mgmt --> law["Log Analytics"]
    mgmt --> bak["Backup and recovery"]
    lz --> corp["Corp"]
    lz --> onl["Online"]

    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    classDef red fill:#faeceb,stroke:#ba0d16;
    class hub,dns,dc,law,corp green;
    class hyb,kv,bak,conn,id,mgmt,root amber;
    class onl,lz red;
```

## Diagram 7: Adoption step 2, analyze

```mermaid swimlane title="Adoption step 2, analyze" subtitle="Model system flows and their contributing resources"
%%| lanes: ["Model root", "System flows you offer", "Contributing resources"]
flowchart BT
    erSig["BGP availability = 99.9%"] --> er["ExpressRoute circuit<br/>healthy"]
    vpnSig["Tunnel state = connected"] --> vpn["VPN gateway<br/>healthy"]
    fwSig["Firewall health = 100%<br/>SNAT port utilization = 38%"] --> fw["Azure Firewall<br/>healthy"]
    kvSig["Vault availability = 100%<br/>Certificate expiry = 9 days (degraded)"] --> kv["Key Vault<br/>degraded"]

    er --> hybrid["Hybrid connectivity<br/>healthy"]
    vpn --> hybrid
    fw --> egress["Egress control<br/>healthy"]
    kv --> secrets["Secret management<br/>degraded"]

    hybrid --> root["Platform health<br/>degraded"]
    egress --> root
    secrets --> root

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    class erSig,vpnSig,fwSig,kvSig blue;
    class er,vpn,fw,hybrid,egress green;
    class kv,secrets,root amber;
```

## Diagram 8: Adoption step 3, refine

```mermaid swimlane title="Adoption step 3, refine" subtitle="Separate primary and failover paths, then alert on flow health"
%%| lanes: ["Domain model root", "System flows", "Paths", "Resources and signals"]
flowchart BT
    erSig["BGP availability = 98.7% (unhealthy)"] --> er["ExpressRoute circuit<br/>unhealthy"]
    vpnSig["Tunnel state = connected"] --> vpn["VPN gateway<br/>healthy"]
    fwSig["Firewall health = 100%"] --> fw["Azure Firewall<br/>healthy"]

    er --> primary["Primary path<br/>unhealthy"]
    vpn --> failover["Failover path<br/>healthy"]
    fw --> inspect["Egress inspection<br/>healthy"]

    primary --> hybrid["Hybrid connectivity<br/>(not-healthy limit)<br/>degraded"]
    failover --> hybrid
    inspect --> egress["Egress control<br/>healthy"]

    hybrid --> root["Connectivity-Contoso-Prod<br/>objective 99.5%<br/>degraded"]
    egress --> root

    classDef blue fill:#eff6fc,stroke:#0078D4;
    classDef green fill:#f2f8f2,stroke:#a0d8a0;
    classDef amber fill:#fbf2e7,stroke:#db7500;
    classDef red fill:#faeceb,stroke:#ba0d16;
    class erSig,vpnSig,fwSig blue;
    class vpn,failover,fw,inspect,egress green;
    class hybrid,root amber;
    class er,primary red;
```
