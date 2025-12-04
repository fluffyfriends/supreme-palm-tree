all:
  vars:
    ansible_user: ${user}
    ansible_connection: ssh
    ansible_ssh_private_key_file: ${private_key}
    codeserver_password: ${codeserver_password}
  hosts:
    mydroplet:
      ansible_host: ${hosts}