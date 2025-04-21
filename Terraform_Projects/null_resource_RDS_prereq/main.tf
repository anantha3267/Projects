provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username             = "admin"
  password             = "Admin12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true
  identifier           = "my-custom-db"
}

resource "null_resource" "create_simple_db" {
  depends_on = [aws_db_instance.rds]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/sh", "-c"]
    command     = <<EOT
mysql -h ${split(":", aws_db_instance.rds.endpoint)[0]} -u ${aws_db_instance.rds.username} -p${aws_db_instance.rds.password} -e "
CREATE DATABASE IF NOT EXISTS nikhil;
USE nikhil;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP USER IF EXISTS 'appuser'@'%';
CREATE USER 'appuser'@'%' IDENTIFIED BY 'AppUser123!';
GRANT ALL PRIVILEGES ON nikhil.* TO 'appuser'@'%';
FLUSH PRIVILEGES;

INSERT INTO users (name, email) VALUES 
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Brown', 'bob.brown@example.com');

SELECT * FROM users;
"
EOT
  }
}


# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_db_instance" "rds" {
#   allocated_storage    = 20
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   db_name              = "mydatabase"
#   username             = "admin"
#   password             = "Admin12345"
#   parameter_group_name = "default.mysql8.0"
#   skip_final_snapshot  = true
#   publicly_accessible  = true
#   identifier           = "my-custom-db"
# }

# resource "null_resource" "create_simple_db" {
#   depends_on = [aws_db_instance.rds]

#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     interpreter = ["/bin/sh", "-c"]
#     command     = <<EOT
# mysql -h ${split(":", aws_db_instance.rds.endpoint)[0]} -u ${aws_db_instance.rds.username} -p${aws_db_instance.rds.password} < /home/nikhil/terraform-rds/db-init.sql
# EOT
#   }
# }
