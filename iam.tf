data "aws_iam_policy_document" "apigateway" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "bunny" {
  name = "bunny-role"

  assume_role_policy = data.aws_iam_policy_document.apigateway.json
}

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    actions = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.wolverines.arn]
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "sqs-policy"
  description = "Allow sending messages to the wolverines queue"
  policy      = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_iam_role_policy_attachment" "sqs_policy" {
  role = aws_iam_role.bunny.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}
