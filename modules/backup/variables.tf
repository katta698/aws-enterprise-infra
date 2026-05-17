variable "environment" {
  type        = string
  description = "The target deployment environment configuration name (dev or prod)"
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key used to encrypt the backup vault storage assets"
}

variable "backup_role_arn" {
  type        = string
  description = "The IAM Role ARN utilized by AWS Backup to snapshot compute storage data"
}

variable "retention_days" {
  type        = number
  description = "The total number of days to keep snapshots active before lifecycle deletion"
}
