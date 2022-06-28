resource "random_pet" "this" {
  prefix = "${var.name}-functions"
  length = 13
}

resource "aws_s3_bucket" "this" {
  bucket        = random_pet.this.id
  force_destroy = true
}

output "test" {
  value = aws_s3_bucket.this.id
}