resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.tour-of-heroes-lambda-role.id
  policy = file("policy.json")
}

resource "aws_iam_role" "tour-of-heroes-lambda-role" {
  name = "myrole"
  assume_role_policy = file("assume_role_policy.json")

  tags = local.tags
}

resource "aws_lambda_permission" "apigw" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getHeroesLambda.function_name
  principal = "apigateway.amazonaws.com"
  //  source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/Prod/POST/hero-resource"
  source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*/*"
}

resource "aws_iam_role_policy_attachment" "jive-jia-aws-config" {
  policy_arn = aws_iam_policy.heroes-policies.arn
  role       = aws_iam_role.tour-of-heroes-lambda-role.name
}

resource "aws_iam_policy" "heroes-policies" {
  policy = data.aws_iam_policy_document.heroes-policies-doc.json
}

data "aws_iam_policy_document" "heroes-policies-doc" {
  statement {
    sid    = "AllowCreatingLogGroups"
    effect = "Allow"
    resources = [
      "arn:aws:logs:us-east-1:*:*"]
    actions = [
      "logs:CreateLogGroup"]
  }

  statement {
    sid    = "AllowWritingLogs"
    effect = "Allow"
    resources = [
      "arn:aws:logs:us-east-1:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }

  statement {
    sid    = "AllowIAMPassRole"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "iam:*",
      "iam:PassRole",
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribePolicy",
      "organizations:ListChildren",
      "organizations:ListParents",
      "organizations:ListPoliciesForTarget",
      "organizations:ListRoots",
      "organizations:ListPolicies",
      "organizations:ListTargetsForPolicy"
    ]
  }

  statement {
    sid    = "AllowDynamoDbAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
  }
}
