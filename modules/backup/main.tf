resource "aws_backup_vault" "vault" {
  name        = "${var.environment}-backup-vault"
  kms_key_arn = var.kms_key_arn
}

resource "aws_backup_plan" "plan" {
  name = "${var.environment}-backup-plan"

  rule {
    rule_name         = "${var.environment}-backup-rule"
    target_vault_name = aws_backup_vault.vault.name
    
    # Corrected to standard AWS 6-field cron syntax (Runs daily at midnight UTC)
    schedule          = "cron(0 0 * * ? *)"

    lifecycle {
      delete_after = var.retention_days
    }
  }
}

resource "aws_backup_selection" "selection" {
  iam_role_arn = var.backup_role_arn
  name         = "${var.environment}-backup-selection"
  plan_id      = aws_backup_plan.plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
