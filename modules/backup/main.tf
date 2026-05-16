resource "aws_backup_vault" "vault" {
  name = "${var.environment}-backup-vault"
}

resource "aws_backup_plan" "plan" {
  name = "${var.environment}-backup-plan"

  rule {
    rule_name         = "${var.environment}-daily-backup-rule"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = "CRON(0 12 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }
}

resource "aws_iam_role" "backup" {
  name = "${var.environment}-aws-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "backup.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup.name
}

resource "aws_backup_selection" "selection" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "${var.environment}-backup-selection"
  plan_id      = aws_backup_plan.plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup-Plan"
    value = "Tier-1"
  }
}
