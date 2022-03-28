module "postgresql" {
  // Guest Settings
  source      = "./lxc-container"
  hostname    = "postgres"
  title       = "PostgreSQL"
  description = <<-EOT
    The database for homelab services.
  EOT
  count       = 1
  countIndex  = count.index
  cores       = 1
  memory      = 256
  swap        = 256
  rootSize    = 20
  startOnBoot = true
  startOrder  = "order=2"
  addToDns    = true
  dnsWildcard = false
  tags        = [ "db", "prod" ]

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
