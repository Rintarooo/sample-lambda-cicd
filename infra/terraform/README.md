# Terraform

## Usage

### login [Terraform Cloud](https://app.terraform.io/session)

```bash
$ terraform login
```

### init

```bash
$ cd envs/dev/lambda
$ terraform init
```

### plan

```bash
$ aws-vault exec terraform plan
```

### apply

```bash
$ aws-vault exec terraform apply --auto-approve
```
