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

locals {
  pod_range_name = length(var.pod_range_name) > 0 ? var.pod_range_name : "${var.name}-pod"
  svc_range_name = length(var.svc_range_name) > 0 ? var.svc_range_name : "${var.name}-svc"
}

# The quortex VPC network.
resource "google_compute_network" "quortex" {
  name = length(var.network_name) > 0 ? var.network_name : var.name

  # An optional description of this resource.
  # The resource must be recreated to modify this field.
  description = var.network_description

  # The network-wide routing mode to use.
  # If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router.
  # If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions.
  routing_mode = var.network_routing_mode

  auto_create_subnetworks = false
}

# The subnetwork in wich to deploy the Quortex resources.
resource "google_compute_subnetwork" "quortex" {
  name = length(var.subnet_name) > 0 ? var.subnet_name : var.name

  # An optional description of this resource.
  # Provide this property when you create the resource.
  # This field can be set only at resource creation time.
  description = var.subnet_description

  # The network this subnet belongs to.
  network = google_compute_network.quortex.self_link

  # The range of internal addresses that are owned by this subnetwork.
  ip_cidr_range = var.subnet_ip_cidr_range

  secondary_ip_range {

    # The name associated with the subnetwork secondary range used for cluster pods.
    # The name must be 1-63 characters long, and comply with RFC1035.
    # The name must be unique within the subnetwork.
    range_name = local.pod_range_name

    # The range of IP addresses belonging to the subnetwork secondary range used for cluster pods.
    # Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network.
    # Only IPv4 is supported.
    ip_cidr_range = var.pod_ip_cidr_range
  }

  secondary_ip_range {

    # The name associated with the subnetwork secondary range used for cluster services.
    # The name must be 1-63 characters long, and comply with RFC1035.
    # The name must be unique within the subnetwork.
    range_name = local.svc_range_name

    # The range of IP addresses belonging to the subnetwork secondary range used for cluster services.
    # Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network.
    # Only IPv4 is supported.
    ip_cidr_range = var.svc_ip_cidr_range
  }

  private_ip_google_access = true
}
