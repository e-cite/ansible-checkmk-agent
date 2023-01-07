# Ansible Rolle "Checkmk-Agent"

Installiert einen Checkmk-Agent auf Debian-basierten Systemen.

## Anforderungen

Es muss ein Checkmk-Server zum Download der DEB-Pakete, Plugins und lokalen
Checks bereitstehen.

## Variablen

- `checkmk_agent__agent_debian_download_URL`: (*Erforderlich*)

  Download-URL des Checkmk-Agent für Debian von lokalem Server.
  ~~~yaml
  # Beispiel:
  checkmk_agent__agent_debian_download_URL:
    "http://<IP/FQDN>/<SITE>/check_mk/agents/check-mk-agent.deb"
  ~~~

- `checkmk_agent__plugins`: (*Optional*)

  Liste mit zu installierenden Checkmk-Plugins, deren URLs und ggf. die
  `cache_time` (default 3600 Sek.).
  ~~~yaml
  # Beispiel:
  checkmk_agent__plugins:
  - name: mk_apt
    url: http://<IP/FQDN>/<SITE>/check_mk/agents/plugins/mk_apt
    cache_time: 3600  # default
  ~~~

- `checkmk_agent__logwatch`: (*Optional*)

  Liste mit Logfiles und Checks, die vom Plugin mk_logwatch überwacht werden
  sollen. Das Plugin muss dazu mittels `checkmk_agent__plugins`
  installiert werden.
  ~~~yaml
  # Beispiel:
  checkmk_agent__logwatch:
    - logfile: /var/log/syslog
      checks:
        - C \[error\]
        - W \[warn\]
  ~~~

- `checkmk_agent__local_checks`: (*Optional*)

  Liste mit zu installierenden lokalen Check-Skripten und ggf. der
  `cache_time` (default 3600 Sek.).
  ~~~yaml
  # Beispiel:
  checkmk_agent__local_checks:
    - name: needrestart
      src: files/local/needrestart.sh
      cache_time: 3600  # default
  ~~~
## Abhängigkeiten

Keine.

## Beispiel

    - hosts: servers
      roles:
        - checkmk-agent

## Lizenz

MIT
