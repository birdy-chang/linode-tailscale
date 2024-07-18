resource "linode_stackscript" "tailscale" {
  label = "tailscale"
  description = "Installs a tailscale"
  script = <<EOF
#!/bin/bash
# <UDF name="package" label="System Package to Install" example="tailscale" default="">
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

apt-get update
apt-get install tailscale -y

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf

echo 'tailscale up --advertise-exit-node --authkey=${var.tailscale_auth_key}' > start-tailscale.sh
crontab -l > my-crontab
echo '@reboot /root/start-tailscale.sh' >> my-crontab
crontab my-crontab
EOF
  images = ["linode/ubuntu20.04"]
}

resource "linode_instance" "tailscale" {
  image = "linode/ubuntu20.04"
  label = "tailscale"
  region = "jp-osa"
  type = "g6-nanode-1"
  root_pass = "${var.linode_root}"

  stackscript_id = linode_stackscript.tailscale.id
}