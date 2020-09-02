provider "aws" {
 region = "ap-south-1"
 profile = "sachin"
}

resource "aws_db_subnet_group" "default" {
    name = "main"
    subnet_ids = ["subnet-563f852d","subnet-ae1517c6","subnet-e53645a9"]

    tags = {
      Name = "my subnets"
    }
  
}


resource "aws_db_instance" "sqldb" {
 engine = "mysql"
 engine_version = "5.7.30"
 instance_class = "db.t2.micro"
 allocated_storage = 10
 storage_type = "gp2"
 name = "prodb"
 username = "sachin"
 password = "sachin123"
 port = "3306"
 publicly_accessible = true
 skip_final_snapshot = true
parameter_group_name = "default.mysql5.7"
db_subnet_group_name = "${aws_db_subnet_group.default.name}"
 tags = {
  Name = "prodDB"
 }
}

output "ip" {
    value = aws_db_instance.sqldb.address
}