# recovery_window_in_days = 0   #  this disables retention policy and usually used only for testing.
# usernames must be between  1 and 16 characters.
# reserved usernames: admin, root, postgres, rdsadmin, resrepladmin, rdsproxy and cannot be used.
# all characters must be alphanumeric, no special characters
# a valid password also, must not contain characters like "/", "@", "'", 

## CREATE A DB USERNAME AND PASSWORD
# username          = data.aws_secretsmanager_secret_version.db_username.secret_string
# password          = data.aws_secretsmanager_secret_version.db_password.secret_string