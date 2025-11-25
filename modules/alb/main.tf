resource "aws_lb" "this" {
    name               = "${var.project_name}-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.alb_sg_id]
    subnets            = var.subnet_ids
    
    tags = {
        Name = "${var.project_name}-alb"
    }
}

resource "aws_lb_target_group" "api_tg" {
    name     = "${var.project_name}-api-tg"
    port     = 8080
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        path                = "/healthz"
    }
}

resource "aws_lb_target_group" "socket_tg" {
    name     = "${var.project_name}-socket-tg"
    port     = 3000
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    stickiness {
        type            = "lb_cookie"
        cookie_duration = 86400
        enabled         = true
    } 

    health_check {
        path = "/healthz" # 소켓 서버 헬스체크 경로
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.this.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.socket_tg.arn
    }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.this.arn
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.acm_certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.socket_tg.arn
    }
  
}

resource "aws_lb_listener_rule" "api_rule" {
    listener_arn = aws_lb_listener.https.arn
    priority     = 100

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.api_tg.arn
    }

    condition {
        path_pattern {
            values = ["/api/*"]
        }
    }
}

resource "aws_lb_listener_rule" "http_api_rule" {
    listener_arn = aws_lb_listener.http.arn # 80번 리스너에 연결
    priority     = 100

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.api_tg.arn
    }

    condition {
        path_pattern {
            values = ["/api/*"]
        }
    }
}

resource "aws_lb_target_group_attachment" "api_attachment" {
    target_group_arn = aws_lb_target_group.api_tg.arn
    target_id        = var.api_instance_id
    port             = 8080
}

resource "aws_lb_target_group_attachment" "socket_attachment" {
    target_group_arn = aws_lb_target_group.socket_tg.arn
    target_id        = var.socket_instance_id
    port             = 3000
}
