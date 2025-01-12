From cleanup.sh line 1, REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
git rev-parse --show-toplevel ==> takes you to the root, however, a pwd prints your current directory.
so echo $REPO_ROOT ==> will always print the root file of your repo.


to run the commands in the plan.sh file, you will need to navigate to the root directory and run
commands
chmod +x plan.sh  ==> gives it execute permission
bash plan.sh  ==> will run commands in the that bash script and each block will run one after the other.
Same applies to the deploy.sh and the destroy.sh
however, in the destroy.sh the blocks are arranged based on resource dependency, for e.g the vpc should
not be destroyed before the bastion host.


in general terraform self manages dependencies so there is no need for line after line arrangement
while bas scripts run line after lines -block and block as it is written.