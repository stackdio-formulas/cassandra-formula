# TODO: Add Debian support

{% if grains['os_family'] == 'RedHat' %}

# Set up the CDH4 yum repository
cassandra_repo:
  pkgrepo:
    - managed
    - humanname: 'Cassandra Community Version'
    - baseurl: 'http://rpm.datastax.com/community/'
    - gpgcheck: 0

cassandra_refresh_db:
  module:
    - run
    - name: pkg.refresh_db
    - require:
      - pkgrepo: cassandra_repo

{% endif %}

