output "name" {
 description= "desc of output"
 value = aws_instance.name.public_ip
}