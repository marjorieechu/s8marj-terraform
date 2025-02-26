# Get the root directory of the repository
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

cd $REPO_ROOT
cd terraform/resources/dev/bastion-host
terraform destroy -auto-approve

cd $REPO_ROOT
cd terraform/resources/dev/vpc
terraform destroy -auto-approve

# delete everything that depends on the vpc before deleting the vpc