/**
 * Copyright 2020 Quortex
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  type        = string
  description = "The GCP project in which to create the cluster."
}

variable "region" {
  type        = string
  description = "The region in wich to create network regional resources (subnet, router, nat...)."
}

variable "name" {
  type        = string
  description = "A name from which the name of the resources will be chosen. Note that each resource name can be set individually."
}

variable "network_name" {
  type        = string
  description = "The name of the network (must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?)."
  default     = ""
}

variable "network_description" {
  type        = string
  description = "An optional description of the VPC network."
  default     = ""
}

variable "network_routing_mode" {
  type        = string
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions."
  default     = "REGIONAL"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet (must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?)."
  default     = ""
}

variable "subnet_description" {
  type        = string
  description = "An optional description of the subnetwork. This field can be set only at resource creation time."
  default     = ""
}

variable "subnet_ip_cidr_range" {
  type        = string
  description = "The range of internal addresses that are owned by the quortex subnetwork. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported."
  default     = "10.0.16.0/20"
}

variable "master_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet."
  default     = "10.0.0.0/28"
}

variable "pod_range_name" {
  type        = string
  description = "The name associated with the subnetwork secondary range for cluster pods usage. (must be unique within the subnetwork, 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?)"
  default     = ""
}

variable "pod_ip_cidr_range" {
  type        = string
  description = "The range of IP addresses belonging to the subnetwork secondary range used for cluster pods. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network. Only IPv4 is supported."
  default     = "10.0.32.0/20"
}

variable "svc_range_name" {
  type        = string
  description = "The name associated with the subnetwork secondary range for cluster services usage. (must be unique within the subnetwork, 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?)"
  default     = ""
}

variable "svc_ip_cidr_range" {
  type        = string
  description = "The range of IP addresses belonging to the subnetwork secondary range used for cluster services. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network. Only IPv4 is supported."
  default     = "10.0.48.0/20"
}

variable "router_name" {
  type        = string
  description = "The name of the router (must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?)."
  default     = ""
}

variable "router_description" {
  type        = string
  description = "An optional description of the router."
  default     = ""
}

variable "router_nat_name" {
  type        = string
  description = "The name of the router nat (must be 1-63 characters long and comply with RFC1035)."
  default     = ""
}

variable "nat_addresses_name_prefix" {
  type        = string
  description = "A prefix for compute addresses name used for NAT. Compute addresses names will be computde from this prefix and a counter for each address. Each compute address name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?"
  default     = ""
}

variable "nat_addresses_count" {
  type        = number
  description = "The number of IP address to use for NAT."
  default     = 1
}

variable "nat_min_ports_per_vm" {
  type        = number
  description = "Minimum number of ports allocated to a VM from this NAT. More infos here https://cloud.google.com/nat/docs/overview#number_of_nat_ports_and_connections"
  default     = 64
}

variable "firewall_allowed_from_master" {
  type = list(
    object({
      protocol = string,
      ports    = list(string)
    })
  )
  description = "The list of protocols / ports to allow traffic from master in the VPC."
  default     = []
}

variable "ssh_whitelisted_ips" {
  type        = set(string)
  description = "A list of IP ranges to whitelist for ssh access on the cluster."
  default     = []
}
