resource "aws_iam_group" "ops" {
  name = "Ops"
}

resource "aws_iam_group_policy_attachment" "administrator" {
  group      = aws_iam_group.ops.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#
# tools
#

data "aws_iam_policy_document" "assume_tools_ops" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${module.tools.account_id}:role/Ops"]
  }
}

resource "aws_iam_policy" "assume_tools_ops" {
  name   = "assume-tools-ops"
  policy = data.aws_iam_policy_document.assume_tools_ops.json
}

resource "aws_iam_group_policy_attachment" "assume_tools_ops" {
  group      = aws_iam_group.ops.name
  policy_arn = aws_iam_policy.assume_tools_ops.arn
}

#
# dev
#

data "aws_iam_policy_document" "assume_dev_ops" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${module.dev.account_id}:role/Ops"]
  }
}

resource "aws_iam_policy" "assume_dev_ops" {
  name   = "assume-dev-ops"
  policy = data.aws_iam_policy_document.assume_dev_ops.json
}

resource "aws_iam_group_policy_attachment" "assume_dev_ops" {
  group      = aws_iam_group.ops.name
  policy_arn = aws_iam_policy.assume_dev_ops.arn
}

#
# stage
#

data "aws_iam_policy_document" "assume_stage_ops" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${module.stage.account_id}:role/Ops"]
  }
}

resource "aws_iam_policy" "assume_stage_ops" {
  name   = "assume-stage-ops"
  policy = data.aws_iam_policy_document.assume_stage_ops.json
}

resource "aws_iam_group_policy_attachment" "assume_stage_ops" {
  group      = aws_iam_group.ops.name
  policy_arn = aws_iam_policy.assume_stage_ops.arn
}

#
# prod
#

data "aws_iam_policy_document" "assume_prod_ops" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${module.prod.account_id}:role/Ops"]
  }
}

resource "aws_iam_policy" "assume_prod_ops" {
  name   = "assume-prod-ops"
  policy = data.aws_iam_policy_document.assume_prod_ops.json
}

resource "aws_iam_group_policy_attachment" "assume_prod_ops" {
  group      = aws_iam_group.ops.name
  policy_arn = aws_iam_policy.assume_prod_ops.arn
}
