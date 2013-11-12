include:
  - cassandra.repo
  # TODO- cdh4.landing_page

##
# Installs Cassandra
#
# Depends on: JDK6
##

cassandra12:
  pkg:
    - installed 
    - version: {{ pillar.cassandra.version }}
    - require:
      - module: cassandra_refresh_db

##
# Configure Cassandra
#
# Depends on: Cassandra package
##
/etc/cassandra/conf/cassandra.yaml:
  file:
    - managed
    - source: salt://cassandra/etc/cassandra/conf/cassandra.yaml
    - user: cassandra
    - group: cassandra
    - mode: 644
    - template: jinja
    - require:
      - pkg: cassandra12

/etc/cassandra/conf/cassandra-env.sh:
  file:
    - managed
    - source: salt://cassandra/etc/cassandra/conf/cassandra-env.sh
    - user: cassandra
    - group: cassandra
    - mode: 644
    - template: jinja
    - require:
      - pkg: cassandra12

##
# Cassandra service management
#
# Depends on: Cassandra package
##

cassandra:
  service:
    - running
    - require: 
      - pkg: cassandra12
      - file: /etc/cassandra/conf/cassandra.yaml
      - file: /etc/cassandra/conf/cassandra-env.sh
    - watch:
      - file: /etc/cassandra/conf/cassandra.yaml
      - file: /etc/cassandra/conf/cassandra-env.sh

