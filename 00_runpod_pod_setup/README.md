# 1.0 About

This setup provisions a RunPod pod for us to rent a GPU server. Do ensure you create a `terraform.tfvars` file to set your `runpod_api_key`.

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

# 2.0 Steps to set up VM server

1. Set up GitHub CLI [here](https://docs.github.com/en/github-cli/github-cli/quickstart)
2. Run the shell script to set up your environment*.
   ```bash
   cd ../workspace
   chmod +x setup_ray_pr_branch.sh
   ./setup_ray_pr_branch.sh

   cd ray
   source .venv/bin/activate
   RAY_LLM_BENCHMARK_ARTIFACT_PATH=/workspace/ray/release/llm_tests/batch/test_batch_single_nodel_vllm.json \
      RAY_DATA_LLM_BENCHMARK_MIN_THROUGHPUT=4 \
      pytest -s release/llm_tests/batch/test_batch_single_node_vllm.py
   ```
3. Test GPU access by running `nvidia-smi`. I wish it outputed something like this for free 🥹.
   ```markdown
   +-----------------------------------------------------------------------------------------+
   | NVIDIA-SMI 580.126.09             Driver Version: 580.126.09     CUDA Version: 13.0     |
   +-----------------------------------------+------------------------+----------------------+
   | GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
   |                                         |                        |               MIG M. |
   |=========================================+========================+======================|
   |   0  NVIDIA H100 80GB HBM3          On  |   00000000:19:00.0 Off |                    0 |
   | N/A   38C    P0             75W /  700W |       0MiB /  81559MiB |      0%      Default |
   |                                         |                        |             Disabled |
   +-----------------------------------------+------------------------+----------------------+
   ```
4. `terraform destroy` to clean up all your resources.

***NOTE:** Adjust the environment variables as needed!*

# 3.0 Resources
- [GitHub CLI quickstart](https://docs.github.com/en/github-cli/github-cli/quickstart)
- [RunPod Terraform package](https://registry.terraform.io/providers/decentralized-infrastructure/runpod/1.0.1)
- [Runpod Setup FULL Tutorial – Run Large AI Models On The Cloud!](https://youtu.be/JEWKmm1VjeU?si=elguDAeN7lmgtM2p)
