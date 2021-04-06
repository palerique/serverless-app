resource "aws_api_gateway_rest_api" "apiLambda" {
  name = "heroAPI"
  tags = local.tags
}

resource "aws_api_gateway_resource" "HeroesResource" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
  path_part   = "heroes"
}

resource "aws_api_gateway_method" "GetMethod" {
  rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
  resource_id   = aws_api_gateway_resource.HeroesResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambdaInt" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.HeroesResource.id
  http_method = aws_api_gateway_method.GetMethod.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.getHeroesLambda.invoke_arn
}

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on = [
  aws_api_gateway_integration.lambdaInt]

  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  stage_name  = "api"
}
