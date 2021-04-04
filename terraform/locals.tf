locals {
  name = "tour-of-heroes-serverless"
  lambda_memory = 256
  runtime = "nodejs12.x"

  tags = {
    Name = "tour-of-heroes-serverless"
    GitRepo = "https://github.com/palerique/serverless-app"
  }
}
