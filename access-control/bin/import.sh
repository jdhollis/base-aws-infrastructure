#!/usr/bin/env bash

root_profile=$(cat .fenna/root_profile)
service_name=$(cat .fenna/service_name)

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    aws_iam_group.ops Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    aws_iam_group_policy_attachment.administrator Ops/arn:aws:iam::aws:policy/AdministratorAccess

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    aws_iam_user.ops Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    aws_iam_user_group_membership.ops Ops/Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    module.tools.aws_iam_role.ops Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    module.dev.aws_iam_role.ops Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    module.stage.aws_iam_role.ops Ops

terraform import \
    -var "profile=${root_profile}" \
    -var "service_name=${service_name}" \
    module.prod.aws_iam_role.ops Ops
