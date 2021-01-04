# CloudWatch Event on Fargate

locals {
  iam_ecs_run_task_resource = var.iam_ecs_run_task_resource != "" ? var.iam_ecs_run_task_resource : var.task_definition_arn
}

resource "aws_cloudwatch_event_rule" "schedule_rule" {
  name                = var.name
  schedule_expression = var.schedule_expression
  is_enabled          = var.is_enabled
}

resource "aws_cloudwatch_event_target" "fargate_scheduled_task" {
  rule     = aws_cloudwatch_event_rule.schedule_rule.name
  arn      = var.target_cluster_arn
  role_arn = module.iam.arn

  ecs_target {
    task_definition_arn = var.task_definition_arn
    task_count          = var.task_count
    launch_type         = "FARGATE"
    platform_version    = "1.4.0"

    network_configuration {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = true
    }
  }
}

module "iam" {
  source  = "baikonur-oss/iam-nofile/aws"
  version = "2.0.0"

  type = "events"
  name = var.name

  policy_json = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:RunTask"
            ],
            "Resource": [
                "${local.iam_ecs_run_task_resource}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": [
                "${var.task_role_arn}",
                "${var.execution_role_arn}"
            ]
        }
    ]
}
EOF

}

