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

# A firewall rule allowing traffic in network from master source.
resource "google_compute_firewall" "quortex_api" {
  name = "${google_compute_router.quortex.name}-api"

  count = length(var.firewall_allowed_from_master) > 0 ? 1 : 0

  # An optional description of the firewall rule.
  description = "The firewall rule allowing traffic in network from master source."

  # Master apiservice access to prometheus-adapter pod.
  source_ranges = [var.master_cidr_block]

  # The network to attach this firewall to.
  network = google_compute_network.quortex.self_link

  # The firewall allowed configuration.
  dynamic "allow" {
    for_each = var.firewall_allowed_from_master

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}

# A firewall rule allowing ssh into the VPC.
resource "google_compute_firewall" "ssh" {
  name = "${google_compute_router.quortex.name}-ssh"

  # The network to attach this firewall to.
  network = google_compute_network.quortex.self_link

  allow {
    protocol = "tcp"
    ports    = [22]
  }
  source_ranges = var.ssh_whitelisted_ips
}

resource "google_compute_firewall" "health_checks" {
  name = "${google_compute_router.quortex.name}-health-checks"

  # The network to attach this firewall to.
  network = google_compute_network.quortex.self_link

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
}
