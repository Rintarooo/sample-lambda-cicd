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
$ perman-aws-vault exec terraform plan
```

### apply

```bash
$ perman-aws-vault exec terraform apply --auto-approve
```
