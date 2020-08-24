output "publicIP" {
  value = "${aws_instance.web.public_ip}"
}


