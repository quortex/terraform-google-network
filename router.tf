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

# A list of IP for NAT.
resource "google_compute_address" "nat" {
  count  = var.nat_addresses_count
  name   = "${length(var.nat_addresses_name_prefix) > 0 ? var.nat_addresses_name_prefix : format("${var.name}%s", "-nat-ip")}-${count.index}"
  region = var.region
}

# The Quortex router.
resource "google_compute_router" "quortex" {
  name    = length(var.router_name) > 0 ? var.router_name : var.name
  network = google_compute_network.quortex.self_link

  # An optional description of the router.
  description = var.router_description
}

# A NAT service created in Quortex router.
resource "google_compute_router_nat" "quortex" {
  name = length(var.router_nat_name) > 0 ? var.router_nat_name : var.name

  # The name of the Cloud Router in which this NAT will be configured.
  router = google_compute_router.quortex.name
  region = var.region

  # How external IPs should be allocated for this NAT.
  # MANUAL_ONLY for only user-allocated NAT IP addresses.
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat.*.self_link

  # Minimum number of ports allocated to a VM from this NAT.
  # More infos here https://cloud.google.com/nat/docs/overview#number_of_nat_ports_and_connections
  min_ports_per_vm = var.nat_min_ports_per_vm

  # How NAT should be configured per Subnetwork.
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.quortex.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
