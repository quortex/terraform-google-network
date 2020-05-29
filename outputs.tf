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

output "project_id" {
  value       = var.project_id
  description = "The GCP project in which networking resources resides."
}

output "region" {
  value       = var.region
  description = "The region in wich regional resources resides (subnet, router, nat...)."
}

output "master_cidr_block" {
  value       = var.master_cidr_block
  description = "The IP range in CIDR notation to use for the hosted master network."
}

output "network" {
  value       = google_compute_network.quortex.self_link
  description = "The self_link of the managed VPC."
}

output "subnetwork" {
  value       = google_compute_subnetwork.quortex.self_link
  description = "The self_link of the managed subnetwork."
}

output "pod_range_name" {
  value       = local.pod_range_name
  description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses."
}

output "svc_range_name" {
  value       = local.svc_range_name
  description = "The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs."
}
