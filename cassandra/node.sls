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
    {% if salt['pillar.get']('cassandra:version', '') %}
    - version: {{ pillar.cassandra.version }}
    {% endif %}
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

{{ pillar.cassandra.data_file_directory }}:
  file:
    - directory
    - user: cassandra
    - group: cassandra
    - mode: 755
    - makedirs: true
    - recurse:
      - user
      - group
      - mode
    - require:
      - pkg: cassandra12

{{ pillar.cassandra.commitlog_directory }}:
  file:
    - directory
    - user: cassandra
    - group: cassandra
    - mode: 755
    - makedirs: true
    - recurse:
      - user
      - group
      - mode
    - require:
      - pkg: cassandra12

{{ pillar.cassandra.saved_caches_directory }}:
  file:
    - directory
    - user: cassandra
    - group: cassandra
    - mode: 755
    - makedirs: true
    - recurse:
      - user
      - group
      - mode
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
      - file: {{ pillar.cassandra.data_file_directory }}
      - file: {{ pillar.cassandra.commitlog_directory }}
      - file: {{ pillar.cassandra.saved_caches_directory }}
    - watch:
      - file: /etc/cassandra/conf/cassandra.yaml
      - file: /etc/cassandra/conf/cassandra-env.sh
      - file: {{ pillar.cassandra.data_file_directory }}
      - file: {{ pillar.cassandra.commitlog_directory }}
      - file: {{ pillar.cassandra.saved_caches_directory }}

