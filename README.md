# kafka-dr-runbook-example

## Playbooks

[2DC DR Playbook](./2DC/playbook.adoc)

## How to update DR Playbook
1. If you need to update the recovery steps for a particular scenario, say `N1` for example, open the asciidoc file `2DC/scenarios/N1/runbook.adoc`.
2. Update the sections `Failover steps to degraded state` and `Recovery steps to normal state`
You can include reusable steps that can be found in `steps/.`.
For example:
```
=== Failover steps to degraded state

. Ensure there are no offline partitions, i.e. partitions whose leader is not available.
+
====
include::../../../steps/ensure_no_offline_partitions.adoc[]
====
. If there are offline partitions and availability of data requires prioritization over other factors, then trigger unclean election with care.
+
====
include::../../../steps/unclean_leader_election.adoc[]
====

```

## Stretched cluster options
2DC: 3+3 Kafka brokers; 3+3 Zookeeper nodes in Hierarchical Quorum

2.5DC: 3+3 Kafka brokers; 2+2+1 Zookeeper nodes

3DC: 2+2+2 Kafka brokers; 2+2+1 ZK

## Scenarios
| | | | |
|-|-|-|-|
|scenario-id|category|name|description|
|ZK1|Single node failure|Zookeeper Outage|One ZooKeeper goes offline. Server breaks or maintenance restart|
|K1|Single node failure|Kafka Outage|One Kafka server goes offline. Server breaks or maintenance restart|
|KD1|Single node failure|Kafka Disk Failure|Single disk failure. SAN storage with redundancy guarantee.|
|ZK2|Two nodes failure|ZooKeeper Outage|Two ZooKeeper instances within a DC go offline.|
|K2|Two nodes failure|Kafka Outage|Two broker servers within a DC go offline. Server breaks or human error during maintenance.|
|DC1|Single DC failure|Full datacenter failure|Full datacenter (e.g. disaster, power outage, DC switch failure) outage|
|R1|Single region failure|Full regional failure|Full regional (e.g. disaster, power outage, catastrophic network issue) outage resulting in both DCs within the region to be offline.|
|N1|Intra-DC network failure|Network segmentation within DC|Network segmentation within a DC, e.g. rack switch failure, that affects some of the DC's brokers, ZK nodes, SR instance, or C3 instance.|
|N2|Inter-DC network segmentation|Network segmentation between DC|Network segmentation between 2 DCs, e.g. DC switch failure, affecting entire region.|
|N3|Inter-region network segmentation|Network segmentation between Regions|Network segmentation between regions, resulting in loss of connectivity between the (stretched) cluster in each region.|
|KS1|Single node failure|Kafka Streams Application failure|One Kafka Streams application instance failure resulting in tasks running in failed instance to be reassigned to other instances (if any).|
|US1|Complete upstream failure|Channel failure|A complete failure for upstream system resulting in the inability for Producers to pull and produce into Kafka topics.|
|DS1|Complete downstream failure|Channel failure|A complete failure for downstream system resulting in the inability for downstream Consumers to sink processed events.|
|Q1|Partial downstream failure|Channel failure|A partial failure for downstream (for e.g. full queue) resulting in the inability for downstream Consumer to sink some of the processed events.|
|CW1|Single node failure|Connect worker failure|One connect worker failure resulting in tasks running in the failed worker to be reassigned to remaining workers (if any).|
