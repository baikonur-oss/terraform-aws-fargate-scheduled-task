# AWS Fargate Scheduled Task Terraform Module

Terraform module for scheduling Fargate tasks with CloudWatch Event Rules.

![terraform v0.11.x](https://img.shields.io/badge/terraform-v0.11.x-brightgreen.svg)

## Usage

```HCL
module "fargate-scheduled-task" {
  source  = "baikonur-oss/fargate-scheduled-task/aws"
  version = "0.1.3"

  name                = "dev-batch-foo"
  schedule_expression = "cron(40 1 * * ? *)"
  is_enabled          = "true"

  target_cluster_arn = "dev"

  task_definition_arn = "${aws_ecs_task_definition.ecs_task_definition.arn}"
  task_role_arn       = "${module.iam_ecs_tasks.arn}"
  task_count          = "1"

  subnets         = "subnet-***1,subnet-***2"
  security_groups = "sg-***1,sg-***2"
}

module "iam_ecs_tasks" {
  source = "baikonur-oss/iam-nofile/aws"
  version = "1.0.2"
  type = "ecs-tasks"
  name = "${var.env}${var.env_num}-${var.role}"

  policy_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
EOF
}
```

### Version pinning
#### Terraform Module Registry
Use `version` parameter to pin to a specific version, or to specify a version constraint when pulling from [Terraform Module Registry](https://registry.terraform.io) (`source = baikonur-oss/aws-fargate-scheduled-task/aws`).
For more information, refer to [Module Versions](https://www.terraform.io/docs/configuration/modules.html#module-versions) section of Terraform Modules documentation.

#### GitHub URI
Make sure to use `?ref=` version pinning in module source URI when pulling from GitHub.
Pulling from GitHub is especially useful for development, as you can pin to a specific branch, tag or commit hash.
Example: `source = github.com/baikonur-oss/terraform-aws-fargate-scheduled-task?ref=v1.0.0`

For more information on module version pinning, see [Selecting a Revision](https://www.terraform.io/docs/modules/sources.html#selecting-a-revision) section of Terraform Modules documentation.


<!-- Documentation below is generated by pre-commit, do not overwrite manually -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| execution\_role\_arn | ARN of IAM Role for task execution (see: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_execution_IAM_role.html ) | string | n/a | yes |
| iam\_ecs\_run\_task\_resource | Field for overriding ecs:RunTask resource identifier in Events IAM role (defaults to task_definition_arn) | string | `""` | no |
| is\_enabled | Rule enabled flag | string | `"true"` | no |
| name | CloudWatch Event Rule name | string | n/a | yes |
| schedule\_expression | CloudWatch schedule expression (see: https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/events/ScheduledEvents.html ) | string | n/a | yes |
| security\_group\_ids | List of security group ids for Fargate task ENI | list | n/a | yes |
| subnet\_ids | List of subnet ids for Fargate task ENI | list | n/a | yes |
| target\_cluster\_arn | Target ECS cluster ARN | string | n/a | yes |
| task\_count | Number of tasks to execute at once | string | `"1"` | no |
| task\_definition\_arn | ARN of Task Definition to run | string | n/a | yes |
| task\_role\_arn | ARN of IAM Role for task (see: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task-iam-roles.html ) | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

Make sure to have following tools installed:
- [Terraform](https://www.terraform.io/)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/)

### macOS
```bash
brew install pre-commit terraform terraform-docs

# set up pre-commit hooks by running below command in repository root
pre-commit install
```
