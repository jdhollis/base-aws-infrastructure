output "env" {
  value = {
    tools = {
      id       = aws_organizations_account.tools.id
      role_arn = "arn:aws:iam::${aws_organizations_account.tools.id}:role/Ops"
    }

    dev = {
      id       = aws_organizations_account.dev.id
      role_arn = "arn:aws:iam::${aws_organizations_account.dev.id}:role/Ops"
    }

    stage = {
      id       = aws_organizations_account.stage.id
      role_arn = "arn:aws:iam::${aws_organizations_account.stage.id}:role/Ops"
    }

    prod = {
      id       = aws_organizations_account.prod.id
      role_arn = "arn:aws:iam::${aws_organizations_account.prod.id}:role/Ops"
    }
  }
}
