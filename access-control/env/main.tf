data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::${var.root_account_id}:root"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "ops" {
  name                 = "Ops"
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = 14400
}
