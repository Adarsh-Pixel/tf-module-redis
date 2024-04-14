# Creates security group
resource "aws_security_group" "allows_redis" {
  name                      = "allows_redis"
  description               = "Allows Only private traffic"
  vpc_id                    = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description              = "redis from private network"
    from_port                = 6379
    to_port                  = 6379
    protocol                 = "tcp"
    cidr_blocks              = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    cidr_blocks              = ["0.0.0.0/0"]
  }

  tags = {
    Name                     = "roboshop-${var.ENV}-redis-sg"
  }
}