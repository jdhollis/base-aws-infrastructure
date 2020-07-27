# base-aws-infrastructure

These Terraform modules are for setting up a basic multiple AWS account setup with access control and remote state. While not strictly necessary, they're intended to be used in combination with [`fenna`](https://github.com/jdhollis/fenna).

Roughly, you want to apply them in the following order:

- [`remote-state/root`](https://github.com/jdhollis/base-aws-infrastructure/tree/master/remote-state/root)
- [`organizations`](https://github.com/jdhollis/base-aws-infrastructure/tree/master/organizations)
- [`access-control`](https://github.com/jdhollis/base-aws-infrastructure/tree/master/access-control)
- [`remote-state/tools`](https://github.com/jdhollis/base-aws-infrastructure/tree/master/remote-state/tools)

For detailed instructions, check out "[How to Bootstrap Multiple Environments on AWS with Terraform & Fenna](https://theconsultingcto.com/posts/how-to-bootstrap-multiple-environments-on-aws-with-terraform-and-fenna/)" on my site.
