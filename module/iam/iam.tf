# Define a list of usernames
variable "user_list" {
  default = [ "Donald", "Ahmed", "Hillary" ]
}

# Create the STUDENT-GROUP
resource "aws_iam_group" "hr_dept"  {
  name =  var.aws_iam_group
}

# Create IAM Users
resource "aws_iam_user" "users" {
  for_each = toset(var.user_list)

  name = each.key

  tags = merge(var.tags, {
    Name = each.key })
  }

# Add each user to the STUDENT-GROUP
resource "aws_iam_group_membership" "group_membership" {
  name = "hr-dept-membership"

  group = aws_iam_group.hr_dept.name

  users = [for user in aws_iam_user.users : user.name]
}

# Attach the AdministratorAccess policy to the group
resource "aws_iam_group_policy_attachment" "admin_policy_attachment" {
  group      = aws_iam_group.hr_dept.name
  policy_arn = var.policy_arn
}