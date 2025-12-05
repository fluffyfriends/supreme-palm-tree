all:
  vars:
    ansible_user: ${ansible_user}
    ansible_connection: ssh
    ansible_ssh_private_key_file: ${ansible_ssh_private_key_file}
    codeserver_password: ${codeserver_password}
    server_domain: ${server_domain}
  hosts:
    codeserver:
      ansible_host: ${ansible_host}