# cassandra-formula

Formula for stackd.io that provisions a cluster with Cassandra 1.2.x (DataStax Community Edition)

## Installable components:

### Seed Node

Seed nodes in Cassandra are the gatekeepers of the cluster topology and network
addresses for all the other nodes in the cluster. When nodes are brought online
they must know at least one seed node so they can figure out where all the other
nodes are and where in the cluster they themselves fit. Most of this is handled
by Cassandra, but we explicitly separate regular and seed nodes so we can target
them individually. This makes it much simpler to write the SLS and obtain the
seed node hostnames.

*NOTE*: The order here should be lower than both regular nodes and OpsCenter nodes
to ensure that seeds are available before regular nodes and OpsCenter attempts to
connect.

### Cassandra Node

This component will provision a machine as a regular Cassandra node. They will be
configured to connect to Seed Nodes, so their order must be higher than any seed
nodes' order.

### OpsCenter Node

[Optional]

DataStax's OpsCenter provides a great dashboard to help you manage your Cassandra
cluster. Simply designate one of your nodes to use this component (or use an
entirely separate machine), set its order to be higher than seed and regular nodes,
and you'll have a web application to help you with all of your Cassandra needs.

*PLEASE NOTE*: Only one of these should be set for any given cluster and the order
for OpsCenter should be higher than any other component because it depends on the
complete Cassandra cluster to be up and running first.
