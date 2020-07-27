#
# Ops
#

resource "aws_iam_user" "ops" {
  name          = "Ops"
}

resource "aws_iam_user_group_membership" "ops" {
  groups = [aws_iam_group.ops.name]
  user   = aws_iam_user.ops.name
}
