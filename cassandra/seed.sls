# A seed node is merely a regular node, installed and configured the same
# but we separate them so we can easily query between the two. This is
# mainly useful when using the peer system to identify what nodes in the
# ring/cluster are seeds.

include:
  - cassandra.node
