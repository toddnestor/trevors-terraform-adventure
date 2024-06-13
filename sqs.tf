resource "aws_sqs_queue" "wolverines" {
  name = "wolverines"
}

resource "aws_apigatewayv2_route" "wolverines" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /v1/polar-bear-face"
  target = "integrations/${aws_apigatewayv2_integration.wolverines.id}"
}

resource "aws_apigatewayv2_integration" "wolverines" {
  api_id              = aws_apigatewayv2_api.main.id
  credentials_arn     = aws_iam_role.bunny.arn
  description         = "SQS example"
  integration_type    = "AWS_PROXY"
  integration_subtype = "SQS-SendMessage"

  request_parameters = {
    "QueueUrl"    = aws_sqs_queue.wolverines.url
    "MessageBody" = "$request.body"
  }
}
