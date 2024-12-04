resource "aws_instance" "dep" {
  ami = "ami-0453ec754f44f9a4a"
  key_name = "newkey"
  instance_type = "t2.micro"
}


resource "aws_instance" "any" {
  ami = "ami-0453ec754f44f9a4a"
  key_name = "newkey"
  instance_type = "t2.micro"
  provider = aws.vzm
  depends_on = [ aws_instance.dep ]
}