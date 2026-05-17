## 02 - Overview + Setup

## Install Terraform

Official installation instructions from HashiCorp: https://developer.hashicorp.com/terraform/install#linux

## AWS Account Setup

AWS Terraform provider documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication

1) create non-root AWS user
2) Add the necessary IAM roles (e.g. AmazonEC2FullAccess)
3) Save Access key + secret key (or use AWS CLI `aws configure` -- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## Hello World

`./main.tf` contains minimal configuration to provision an EC2 instance.

1) `aws configure`
2) `terraform init`
3) `terraform plan`
4) `terraform apply`
5) `terraform destoy`

**NOTE:** We can see that all the EC2 configurations we'd normally have to do via ClickOps is automatically reflected in `terraform.tfstate` file below.

Also, ` ```json ` is used on code blocks to get highlighting since HCL isn't an allowable language.

```json
{
  "version": 4,
  "terraform_version": "1.15.2",
  "serial": 1,
  "lineage": "79658abf-5924-dd46-b6bb-cc8f624d8f94",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "example",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "ami": "ami-0367763820bb4f68b",
            "arn": "arn:aws:ec2:ap-southeast-5:257394479618:instance/i-0eac3035c43ae7596",
            "associate_public_ip_address": true,
            "availability_zone": "ap-southeast-5c",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "nested_virtualization": "",
                "threads_per_core": 2
              }
            ],
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "force_destroy": false,
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_group_id": "",
            "placement_partition_number": 0,
            "primary_network_interface": [
              {
                "delete_on_termination": true,
                "network_interface_id": "eni-"
              }
            ],
            "primary_network_interface_id": "eni-",
            "private_dns": "ip-172-31-42-194.ap-southeast-5.compute.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.42.194",
            "public_dns": "ec2-56-68-95-177.ap-southeast-5.compute.amazonaws.com",
            "public_ip": "56.68.95.177",
            "region": "ap-southeast-5",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/sda1",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-",
                "volume_size": 8,
                "volume_type": "gp3"
              }
            ],
            "secondary_network_interface": [],
            "secondary_private_ips": [],
            "security_groups": [
              "default"
            ],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-",
            "tags": null,
            "tags_all": {},
            "tenancy": "default",
            "timeouts": null,
            "user_data": null,
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-"
            ]
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "identity": {
            "account_id": "",
            "id": "i-",
            "region": "ap-southeast-5"
          },
          "private": ""
        }
      ]
    }
  ],
  "check_results": null
}
```