output "instance_id" {
  description = "This is aws instance id"
  value       = aws_instance.demo.id
}

output "instance_ip" {
  description = "This is aws instance public ip"
  value       = aws_instance.demo.public_ip
}
