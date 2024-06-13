provider "aws" {
  region = "us-east-1"
}

resource "aws_apigatewayv2_api" "main" {
  name          = "pangolin"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
}
