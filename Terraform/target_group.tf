resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  region = "us-east-1"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  region = "us-east-1"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_target_group_attachment" "backend_attach" {

  target_group_arn = aws_lb_target_group.backend_tg.arn

  target_id = aws_instance.backend.id

  port = 5000
}

resource "aws_lb_target_group_attachment" "frontend_attach" {

  target_group_arn = aws_lb_target_group.frontend_tg.arn

  target_id = aws_instance.frontend.id

  port = 80
}