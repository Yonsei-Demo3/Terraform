resource "aws_route53_zone" "main" {
    name = var.domain_name
}

resource "aws_route53_record" "api" {
    zone_id = aws_route53_zone.main.zone_id
    name    = "api.${var.domain_name}"
    type    = "A"

    alias {
        name                   = var.alb_dns_name
        zone_id                = var.alb_zone_id
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "frontend_root" {
    zone_id = aws_route53_zone.main.zone_id
    name    = var.domain_name
    type    = "A"
    ttl    = 600

    records = ["216.198.79.1"]
}

resource "aws_route53_record" "frontend_www" {
    zone_id = aws_route53_zone.main.zone_id
    name    = "www.${var.domain_name}"
    type    = "CNAME"
    ttl    = 600

    records = ["e485a016f2f9bd56.vercel-dns-017.com."]
}