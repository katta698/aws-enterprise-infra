variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Primary AWS region for bootstrapping"
}

variable "github_repository" {
  type        = string
  description = "The GitHub repository in organization/repo format"
}
