# Terraform AWS EC2

## Arguments
ami_id - (Mandatory), User must provide AMI ID. This is in String format

instance_type - (Optional), default is t3.micro

security_group_ids - (Mandatory), User must provide list of SG ID

## Outputs
public_ip - Public IP of the instance created

private_ip - Private IP of the instance created

instance_id - Instance ID of the instance created

### Clarification

#### Resource creation
While creating terraform resource, left side things are called as arguments, we have to use the same name as per terraform aws documentation. We can't change them. For example

```
resource "aws_instance" "terraform" {

    ami = "ami-09c813fb71547fc4f"
}
```
Here argument `ami` is from the documentation, right side is the value. You can directly provide the value.

You may also keep the value in variable. Variable name is completely your wish. It may or many not be same argument name.
* It can be same name like `ami`
* It can be different name like `ami_id`

```
resource "aws_instance" "terraform" {

    ami = var.ami_id
}

variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}
```

or

```
resource "aws_instance" "terraform" {

    ami = var.ami
}

variable "ami" {
    default = "ami-09c813fb71547fc4f"
}
```

#### Module creation

While creating module, we need to follow the module definition. We have to read the documentation of module and provide the values. For example module is expecting `ami_id`

You need to provide like

```
module "mysql" {
    source = "path-to-your-module"
    ami_id = "ami-09c813fb71547fc4f"
}
```

You can also use variables if you like, variable name need not be same as argument name.
* It can be same name like ami_id
* It can be different name like ami

```
module "mysql" {
    source = "path-to-your-module"
    ami_id = var.ami
}

variable "ami"{
    default = "ami-09c813fb71547fc4f"
}
```

or

```
module "mysql" {
    source = "path-to-your-module"
    ami_id = var.ami_id
}

variable "ami_id"{
    default = "ami-09c813fb71547fc4f"
}
```