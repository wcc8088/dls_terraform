data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_kms_key" "this" {
}

locals {
  name = "dlsec2"

  multiple_instances = {
    CGW = {
      instance_type = "t3.micro"
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "SHBW-AN2-DLS-PRD-EBS-CGW-DB-01"
          }
        }
      ]
      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp3"
          volume_size = 5
          throughput  = 200
          encrypted   = true
          kms_key_id  = aws_kms_key.this.arn
        }
      ]
    }
    CVT = {
      instance_type = "t3.micro"
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "SHBW-AN2-DLS-PRD-EBS-CVT-DB-01"
          }
        }
      ]
      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp3"
          volume_size = 5
          throughput  = 200
          encrypted   = true
          kms_key_id  = aws_kms_key.this.arn
        }
      ]
    }
    CPN = {
      instance_type = "t3.micro"
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "SHBW-AN2-DLS-PRD-EBS-CPN-DB-01"
          }
        }
      ]
      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp3"
          volume_size = 5
          throughput  = 200
          encrypted   = true
          kms_key_id  = aws_kms_key.this.arn
        }
      ]
    }
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "security_group"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "ec2_multiple0" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = local.multiple_instances

  name = "${var.name}-${each.key}-DB-11"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  availability_zone      = element(module.vpc.azs, 0)
  subnet_id              = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids = [module.security_group.security_group_id]

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])
  ebs_block_device   = lookup(each.value, "ebs_block_device", [])
}

module "ec2_multiple1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = local.multiple_instances

  name = "${var.name}-${each.key}-DB-21"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  availability_zone      = element(module.vpc.azs, 1)
  subnet_id              = element(module.vpc.private_subnets, 1)
  vpc_security_group_ids = [module.security_group.security_group_id]

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])
  ebs_block_device   = lookup(each.value, "ebs_block_device", [])
}

module "ec2_multiple2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = local.multiple_instances

  name = "${var.name}-${each.key}-DB-31"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  availability_zone      = element(module.vpc.azs, 2)
  subnet_id              = element(module.vpc.private_subnets, 2)
  vpc_security_group_ids = [module.security_group.security_group_id]

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])
  ebs_block_device   = lookup(each.value, "ebs_block_device", [])
}
