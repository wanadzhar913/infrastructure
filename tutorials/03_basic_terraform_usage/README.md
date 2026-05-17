# 03 - Basics

## 1.0 Remote Backends

Remote backends **enable storage of TF state in a remote location** to enable secure collaboration (and not having to keep config files locally).

To overcome the "chicken-and-egg" problem (where you want to use a remote backend, but you need Terraform to create that backend), we employ a standard workflow using AWS S3.

We detail this here:
- **Write Initial Config:** Create a [minimal Terraform configuration]() to provision the bucket and/or database.
- **Run with Local State:** Execute terraform apply using a local state file to create these "seed" resources.
- **Migrate State:** Update your configuration to use the newly created remote backend and run terraform init. Terraform will ask if you want to migrate your local state to the new remote backend e.g., `terraform init -migrate-state`.
- **Secure the State:** Commit the bootstrap code to your repository, but ensure the sensitive local state file generated during the first step is deleted or ignored.

We can then use our remote backend as needed.

### AWS S3

Steps to initialize backend in AWS and manage it with Terraform:

1) Use config from `./aws-backend/` (init, plan, apply) to provision and bootstrap **shared state bucket** s3 bucket and dynamoDB table with local state

```bash
cd tutorials/03_basic_terraform_usage/aws_backend
terraform init
terraform plan
terraform apply
```

2) Uncomment the remote backend configuration
3) Reinitialize with `terraform init`:

```
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes 
```

Now the S3 bucket and dynamoDB* table are provisioned and are able to be used as the state backend!

*In older versions of Terraform, dynamoDB was used to provide **state locking** (refer [here](/tutorials/03_basic_terraform_usage/aws_backend/main.tf.deprecated)). While the S3 bucket stores the actual state file, DynamoDB acts as a lock manager to prevent data corruption and race conditions. In a team environment, multiple people or automated CI/CD pipelines might try to run terraform apply at the same time, resulting in the state file becoming corrupted or one user overwriting the changes made by another, leading to inconsistent infrastructure*

## 2.0 Web-App

We can then set up a generic web application that uses the above remote backend.

```bash
cd tutorials/03_basic_terraform_usage/web_app
terraform init
terraform plan
terraform apply
terraform output -json alb_dns_name

# for testing if the ALB is working properly (if via browser,
# the browser may be reusing a connection or caching the response)
ALB=$(terraform output -raw alb_dns_name)
for i in $(seq 1 20); do curl -s "http://$ALB/"; echo; done

# Example output
# >> Hello, World 2
# >> Hello, World 1
# >> Hello, World 2
# >> Hello, World 2
```

The generic web application architecture includes:
- EC2 instances
- S3 bucket
- RDS instance
- Load balancer

## 3.0 Architecture
![Architecture diagram for simple EC2, ALB, RDS provisioning on AWS](/tutorials/03_basic_terraform_usage/web_app/architecture.png)

***NOTE:** we are excluding Route 53 from this practice.*

## 4.0 Other
- `terraform init --migrate-state`: When you have existing infrastructure recorded in a local `terraform.tfstate` file or a remote backend
- `terraform init --reconfigure`: When the state already exists at the target location and you simply need Terraform to "forget" its current local cache and reconnect