resource "aws_instance" "thala" {
 ami = "ami-0453ec754f44f9a4a"
  key_name = "newkey"
  instance_type = "t2.micro" 
  for_each = toset(var.sandboxes)

tags = {
    Name = each.value
}
}

variable "sandboxes" {
    type = list(string)
  default = ["first" ,  "third"]
}