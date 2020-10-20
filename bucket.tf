resource "aws_s3_bucket" "nestjs_app_bucket" {
  bucket = "${var.env_name}-bucket"

  tags = {
    Name = "${var.env_name}-bucket"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.nestjs_app_bucket.id

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowWriteObjectPolicy",
      "Effect": "Allow",
      "Principal": {
          "AWS": "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-ec2-role"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.nestjs_app_bucket.bucket}/resources/environments/logs/*"
    },
    {
      "Sid": "AllowReadBucketObjectPolicy",
      "Effect": "Allow",
      "Principal":{
          "AWS": "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-ec2-role"
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.nestjs_app_bucket.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.nestjs_app_bucket.bucket}/resources/environments/*"
      ]
    },
    {
      "Sid": "DenyDeletBucketPolicy",
      "Effect": "Deny",
      "Principal": {
        "AWS":"*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.nestjs_app_bucket.bucket}"
    }
  ]
}
POLICY

}
