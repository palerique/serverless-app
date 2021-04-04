resource "aws_dynamodb_table" "heroes-dynamodb-table" {
  name = "Heroes"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5
  hash_key = "HeroId"
  range_key = "HeroName"

  attribute {
    name = "HeroId"
    type = "S"
  }

  attribute {
    name = "HeroName"
    type = "S"
  }

  tags = local.tags
}
