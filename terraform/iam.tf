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
