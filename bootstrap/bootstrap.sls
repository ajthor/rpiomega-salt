# This state file is used by salt-ssh to install Salt and configure the files
# necessary for our system to work properly. It is only used when bootstrapping
# new nodes.

# Install Salt on the target system.
install-salt:
  salt.state:
    - sls: bootstrap.install
    - tgt: '*'
    - unless:
      - which salt-master
      - which salt-minion

# Set up the services for salt-minion.
salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - watch:
      - file: /etc/salt/minion

configure-salt:
  salt.state:
    - sls: bootstrap.configure
    - tgt: '*'
