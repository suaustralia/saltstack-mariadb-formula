{% from "mariadb/map.jinja" import mariadb with context %}
{% set settings = salt['pillar.get']('mariadb', {}) %}

{% set os = salt['grains.get']('os', None) %}
{% set os_family = salt['grains.get']('os_family', None) %}


{% if os == 'Ubuntu' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo {{ mariadb.repo_version }}
    - name: deb {{ mariadb.repo }}{{ mariadb.repo_version }}/ubuntu/ {{ salt['grains.get']('oscodename', 'trusty') }} main
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/mariadb.{{ mariadb.repo_version }}.list
    - keyid: F1656F24C74CD1D8
    - refresh: True
    - clean_file: True

{% elif os_family == 'Debian' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo {{ mariadb.repo_version }}
    - name: deb {{ mariadb.repo }}{{ mariadb.repo_version }}/debian/ {{ salt['grains.get']('oscodename', 'trusty') }} main
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/mariadb.{{ mariadb.repo_version }}.list
    - keyid: F1656F24C74CD1D8
    - refresh: True
    - clean_file: True

{% elif os_family == 'Redhat' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo {{ mariadb.repo_version }}
    - baseurl: {{ mariadb.repo }}{{ mariadb.repo_version }}/{{ mariadb.repo_dir }}
	- skip_if_unavailable: True
	- enabled: 1
{% endif %}
