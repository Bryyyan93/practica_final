resource "aws_lb" "main" {
  name               = "${var.cluster_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}
resource "aws_lb_target_group" "php_app" {
  # Configuración para el target group
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.php_app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}
