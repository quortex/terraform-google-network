[![Quortex][logo]](https://quortex.io)
# terraform-google-network
A terraform module for Quortex infrastructure GCP network layer.

It provides a set of resources necessary to provision the Quortex infrastructure network topology on Google Cloud Platform.

This module is available on [Terraform Registry][registry_tf_google_network].

Get all our terraform modules on [Terraform Registry][registry_tf_modules] or on [Github][github_tf_modules] !

## Created resources

This module creates the following resources in GCP:

- a dedicated VPC
- a subnet with dedicated ranges for VPC native cluster pods and services
- firewall rules to apply on VPC
- a router with NAT and some external ip addresses for VPC outbound traffic


## Usage example

```hcl
module "network" {
  source = "quortex/network/google"

  # required variables
  project_id = "project_id"
  region     = "region"
  name       = "quortex"
}
```
---

## Related Projects

This project is part of our terraform modules to provision a Quortex infrastructure for Google Cloud Platform.

![infra_gcp]

Check out these related projects.

- [terraform-google-gke-cluster][registry_tf_google_gke_cluster] - A terraform module for Quortex infrastructure GKE cluster layer.

- [terraform-google-load-balancer][registry_tf_google_load_balancer] - A terraform module for Quortex infrastructure GCP load balancing layer.

- [terraform-google-storage][registry_tf_google_storage] - A terraform module for Quortex infrastructure GCP persistent storage layer.

## Help

**Got a question?**

File a GitHub [issue](https://github.com/quortex/terraform-google-network/issues) or send us an [email][email].


  [logo]: https://storage.googleapis.com/quortex-assets/logo.webp
  [email]: mailto:info@quortex.io
  [infra_gcp]: https://storage.googleapis.com/quortex-assets/infra_gcp_002.jpg
  [registry_tf_modules]: https://registry.terraform.io/modules/quortex
  [registry_tf_google_network]: https://registry.terraform.io/modules/quortex/network/google
  [registry_tf_google_gke_cluster]: https://registry.terraform.io/modules/quortex/gke-cluster/google
  [registry_tf_google_load_balancer]: https://registry.terraform.io/modules/quortex/load-balancer/google
  [registry_tf_google_storage]: https://registry.terraform.io/modules/quortex/storage/google
  [github_tf_modules]: https://github.com/quortex?q=terraform-