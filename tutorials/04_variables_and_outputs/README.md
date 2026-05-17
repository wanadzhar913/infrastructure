# 1.0 Variables (`variable`)

## Variable block

This is a way to give inputs to our instances e.g., what `instance_type` to use for EC2, etc. Essentially, **they are parameters for customization.** Think of them as function arguments.

```
variable "var_name" {
  type = string
}
```

## Variable types
- string
- number
- bool
- list(<TYPE>)
- set(<TYPE>)
- map(<TYPE>)
- object({<ATTR NAME> = <TYPE>, ... })
- tuple([<TYPE>, ...])

## Variable files
`variables.tfvars` (or `<FILENAME>.auto.tfvars`) automatically applied 

## Apply default
`terraform apply`

## Apply a different variable file
`terraform apply -var-file=another-variable-file.tfvars`

## Passing Variable via Prompt
If value not specified, Terraform will prompt for value. (this is okay for testing... but don't depend on it since you should be automating things!)
```
  var.db_pass
  password for database

  Enter a value:
```

## Passing Variables via CLI
`terraform apply -var="db_pass=$DB_PASS_ENV_VAR"`

# 2.0 Local Variables (`locals`)

Allows you to store the value of expression for reuse but doesn't allow for passing in values. Local values assign a name to an expression, allowing you to reuse that expression multiple times within a single module without repeating it. They're **like a temporary variable (local value) used only in the scope of functions.**
```
locals {
  extra_tag = "extra-tag"
}
```

# 3.0 Output Variables (`output`)

Allows you to output some value (which might not be known ahead of time). **This is like the output of a function.**

Output values export information about your infrastructure, making it visible to the CLI or usable by other Terraform configurations. For example it might be useful to know the IP address of a VM that was created:

```
output "instance_ip_addr" {
  value = aws_instance.instance.private_ip
}
```

Sample output:
```
db_instance_addr = "terraform-20210504182745335900000001.cr2ub9wmsmpg.us-east-1.rds.amazonaws.com"
instance_ip_addr = "172.31.24.95"
```

Will be output after `terraform apply` or `terraform output`

# 4.0 Setting Input Variables

The below is in order of precedence // lowest -> highest.

- Manual entry during plan/apply
- Default value in declaration block
- `TF_VAR_<name>` environment variables
- `terraform.tfvars` file (also loaded **automatically** but with standard naming convention. Use normally for simple local default setup. **Non-sensitive data.**)
- `*auto.tfvars` file (flexible named file loaded **automatically** when you run `terraform apply` or `terraform plan`)
- Command line `-var` or `-var-file`