output "get-heroes-curl" {
  value = "curl ${aws_api_gateway_deployment.apideploy.invoke_url}/${aws_api_gateway_resource.HeroesResource.path_part}"
}
