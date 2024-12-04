module "any" {
  source = "github.com/CloudTechDevOps/terraform-10-30am/day-2-basic-ec2"
  ami = "ami-0453ec754f44f9a4a"
  key_name = "newkey"
  instance_type = "t2.micro"
}