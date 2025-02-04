resource "aws_lb_target_group" "store_tg" {
  name     = "store-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.store_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}
