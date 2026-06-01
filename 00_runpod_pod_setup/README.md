# About

This setup provisions a RunPod pod for us to rent a GPU server. Do ensure you set your `terraform.tfvars` file to set your `runpod_api_key`.

```bash
terraform plan
terraform apply

# Public IP is assigned after the pod finishes starting — refresh before reading it
terraform refresh
POD_PUBLIC_IP=$(terraform output -raw pod_public_ip)
echo "Pod IP: ${POD_PUBLIC_IP}"
```

Then we can SSH into our server (use SSH exposed over TCP on VS Code) after adding our SSH public keys on RunPod.

```bash
ssh root@"${POD_PUBLIC_IP}" -p 16352 -i ~/.ssh/id_ed25519
```

# Steps to set up VM server

1. Set up GitHub CLI [here](https://docs.github.com/en/github-cli/github-cli/quickstart)
2. Run the shell script to set up your environment*.
   ```bash
   chmod +x setup_ray_pr_branch.sh
   ./setup_ray_pr_branch.sh
   ```

***NOTE:** Adjust the environment variables as needed!*

### Resources
- [GitHub CLI quickstart](https://docs.github.com/en/github-cli/github-cli/quickstart)
- [RunPod Terraform package](https://registry.terraform.io/providers/decentralized-infrastructure/runpod/1.0.1)
- [Runpod Setup FULL Tutorial – Run Large AI Models On The Cloud!](https://youtu.be/JEWKmm1VjeU?si=elguDAeN7lmgtM2p)