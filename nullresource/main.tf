resource "aws_db_instance" "keerthi" {
  identifier = "mydb"
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  db_name = "mydatabse"
  username = "admin"
  password = "praneeth123"
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.keerthi.id]
  db_subnet_group_name = aws_db_subnet_group.keerthi.name

}

resource "aws_security_group" "keerthi" {
    name = "mysg"

ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_db_subnet_group" "keerthi" {
    name = "mysubnetgroup"
    subnet_ids = ["subnet-0dd91e82b7e334de5","subnet-03317ad106af544c4"]
}

resource "null_resource" "keerthi" {
    depends_on = [ aws_db_instance.keerthi ]
  provisioner "local-exec" {
    command = <<EOT
  mysql -h ${aws_db_instance.keerthi.address}
  -u admin
  -p praneethn123
  -e "soruce ./initialize_db.sql"
  EOT
    }
    triggers = {
      aws_db_instance_id = aws_db_instance.keerthi.id
    }
}