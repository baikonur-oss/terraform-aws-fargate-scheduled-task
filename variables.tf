variable "name" {
  description = "CloudWatch Event Rule name"
}

variable "schedule_expression" {
  description = "CloudWatch schedule expression (see: https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/events/ScheduledEvents.html )"
}

variable "is_enabled" {
  description = "Rule enabled flag"
  default     = true
}

variable "target_cluster_arn" {
  description = "Target ECS cluster ARN"
}

variable "task_definition_arn" {
  description = "ARN of Task Definition to run"
}

variable "task_count" {
  description = "Number of tasks to execute at once"
  default     = 1
}

variable "subnets" {
  description = "List of subnets for Fargate task ENI"
  type        = "list"
}

variable "security_groups" {
  description = "List of security groups for Fargate task ENI"
}

variable "task_role_arn" {
  description = "ARN of IAM Role for task (see: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task-iam-roles.html )"
}

variable "execution_role_arn" {
  description = "ARN of IAM Role for task execution (see: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_execution_IAM_role.html )"
}

variable "iam_ecs_run_task_resource" {
  description = "Field for overriding ecs:RunTask resource identifier in Events IAM role (defaults to task_definition_arn)"
  default     = ""
}
