resource "aws_key_pair" "my-server-ssh-key" {
    key_name   = "my-server-ssh-key"
    public_key = "<ssh_public_key>"
}

resource "aws_instance" "my-server" {
    ami = "ami-0e1ce3e0deb8896d2"
    
    instance_type = "t2.micro"
    
    key_name = "my-server-ssh-key"
    
    tags = {
      Name = "webserver"
    }
}

resource "aws_eip" "my-server" {
  instance = aws_instance.my-server.id
  vpc      = false
}

output "instance_id" {
  value       = aws_instance.my-server.id
}

output "public_ip" {
  value       = aws_eip.my-server.public_ip
}

output "key_name" {
  value       = aws_instance.my-server.key_name
}