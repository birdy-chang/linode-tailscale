# linode-tailscale
Deploy a tailscale node on a linode instance with terraform

## Prerequisites
- [terraform](https://www.terraform.io/downloads)
- [linode](https://www.linode.com/) account
- [tailscale](https://tailscale.com/) account

## Usage
1. Clone this repository
2. Create a terraform.tfvars file with the following variables:
    - `linode_token`: your linode api token
    - `linode_root`: the root password for the linode instance
    - `tailscale_auth_key`: your tailscale auth key
    - `tailscale_up_arg`: the arguments for the tailscale up command
3. Run `terraform init`
4. Run `terraform apply -var-file=terraform.tfvars`

## tailscale exit node
Please uncomment the following lines in the linode.tf file if you want to deploy a tailscale exit node.
```hcl
# Uncomment here if the tailscale node is an exit node
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf
```
