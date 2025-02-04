resource "aws_lb" "store_lb" {
  name               = "store-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.store_subnet.id]

  security_groups = [aws_security_group.store_sg.id]

  enable_deletion_protection = false
}

# Listener do ALB
resource "aws_lb_listener" "store_listener" {
  load_balancer_arn = aws_lb.store_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.store_tg.arn
  }
}
