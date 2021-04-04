data "archive_file" "getHeroesLambdaFile" {
  type = "zip"
  source_dir = "${path.module}/../backend/lambda/getHeroes/dist"
  output_path = "${path.module}/../backend/lambda/getHeroes/getHeroes.js.zip"
}

resource "aws_lambda_function" "getHeroesLambda" {
  function_name = "getHeroesLambda"
  handler = "index.handler"
  role = aws_iam_role.tour-of-heroes-lambda-role.arn
  runtime = local.runtime

  filename = data.archive_file.getHeroesLambdaFile.output_path
  source_code_hash = data.archive_file.getHeroesLambdaFile.output_base64sha256

  timeout = 30
  memory_size = local.lambda_memory

  tags = local.tags
}
