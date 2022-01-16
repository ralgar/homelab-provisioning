module "dev-containers" {
  // Guest Settings
  source      = "./lxc-container"
  hostname    = "dev-ct-${count.index + 1}"
  title       = "Dev Container #${count.index + 1 }"
  description = <<-EOT
    A simple container for development purposes.
  EOT
  count       = length(var.guest_hostNums)
  countIndex  = count.index
  cores       = 1
  memory      = 256
  swap        = 256
  rootSize    = 8
  startOnBoot = false
  addToDns    = true
  tags        = [ "dev" ]

  // Global Variables
  dnsHostNums      = var.dns_hostNums
  dnsSecretKey     = var.dns_secretKey
  dnsSecretType    = var.dns_secretType
  pveHost          = var.pve_host
  pveUsername      = var.pve_username
  pvePassword      = var.pve_password
  pveTlsInsecure   = var.pve_tlsInsecure
  guestCtImage     = var.guest_ctImage
  guestPubKeyFile  = var.guest_pubKeyFile
  guestTargetNode  = var.guest_targetNode
  guestStoragePool = var.guest_storagePool
  guestVmTemplate  = var.guest_vmTemplate
  netDnsHosts      = [
    "${cidrhost(var.net_prefix, var.dns_hostNums[0])}",
    "${cidrhost(var.net_prefix, var.dns_hostNums[1])}",
    "1.1.1.1"
  ]
  netDomain        = var.net_domain
  netGateway       = var.net_gateway
  netPrefix        = var.net_prefix

  // Module Variables
  netHostNums      = var.guest_hostNums
}