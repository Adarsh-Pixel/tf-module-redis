# Creates Elastic Cache cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis.name
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.allows_redis.id]
  engine_version       = "6.2"
  port                 = 6379
}

resource "aws_elasticache_parameter_group" "redis" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = "redis2.8"
}

# Creates DOCDB cluster
# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   skip_final_snapshot     = true            # value will be false in production. In lab, we will be using true
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
#   vpc_security_group_ids  = [aws_security_group.allows_docdb.id]
# }
# # Creates DocDB instances and adds to the cluster

# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}-docdb"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }


# # Create DocDB subnet group

# resource "aws_docdb_subnet_group" "docdb" {
#   name       = "roboshop-${var.ENV}-docdb-subnet-group"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "roboshop-${var.ENV}-docdb-subnet-group"
#   }
# }

resource "aws_elasticache_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  tags = {
    Name = "roboshop-${var.ENV}-redis-subnet-group"
  }
}

