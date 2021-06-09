# kafka-dr-runbook-example


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
