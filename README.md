# Ansible Rolle "Checkmk-Agent"

Installiert einen Checkmk-Agent auf Debian-basierten Systemen.

## Anforderungen

Es muss ein Checkmk-Server zum Download der DEB-Pakete bereitstehen.

## Variablen

- `checkmk_agent__agent_debian_10_download_URL`: (*Erforderlich*)

  Download-URL des Checkmk-Agent für Debian 10 von lokalem Server.
  ~~~yaml
  # Beispiel:
  checkmk_agent__agent_debian_10_download_URL:
    "http://<IP/FQDN>/<SITE>/check_mk/agents/check-mk-agent.deb"
  ~~~

## Abhängigkeiten

Keine.

## Beispiel

    - hosts: servers
      roles:
        - checkmk-agent

## Lizenz

MIT
