resource "aws_instance" "prometheus" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.monitoring_sg.id]

  tags = {
    Name = "Prometheus"
  }
}

resource "aws_instance" "grafana" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.monitoring_sg.id]

  tags = {
    Name = "Grafana"
  }
}
