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

variable "subnet_ids" {
  description = "List of subnet ids for Fargate task ENI"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group ids for Fargate task ENI"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign public ip for Fargate task ENI"
  default     = false
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

