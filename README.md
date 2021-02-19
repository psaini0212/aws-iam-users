# aws-iam-users
This code will create IAM users in AWS for multiple environments.
As it is under single organisation (rather multiple AWS accounts), the environment segregation is by creating groups.
The permissions for different resource per environment needs to be managed in the policy attached to groups.

#### Plan
Create users for each environment in the asked format
Creating group for each environment and assign users to the appropriate group so that permissions 
can be assigned on group level rather to individual user.
Output the Username, Access Key Id and Secret Key in single line.

####Things to know
1) I have not used pgp key for encryption for this use case for ease which means 
the Secret Key will be visible (unencrypted) in the state file (in our case it's local).
2) I have used aws module for this purpose for ease but for complex cases if any 
we can write our own module by using the resource providers.
3) I have tested this with Terraform v0.14.7, I have not restricted the terraform version in the terraform block, 
should work versions > 0.12

####Pre-requisites
The User running the code needs to have access to create IAM users in AWS.
You need to set Access Key Id and Secret Access Key of your user.

There are multiple ways to do that

a) Configure it in AWS CLI configuration bu using "aws configure" command if you got aws cli on yor machine.

OR

b) Create a file name terraform.tfvars in the root of the repo and specify the aws secret key and secret access key in it.

AWS_ACCESS_KEY = "xxxxxxxxxxxx"
AWS_SECRET_KEY = "xxxxxxxxxxxxxxxxxxxxxxxx"

OR

c) Export it as Env variable in yoru shell
export AWS_ACCESS_KEY = "xxxxxxxxxxxx"
export AWS_SECRET_KEY = "xxxxxxxxxxxxxxxxxxxxxxxx"


####Steps to follow  -

To initialise a working directory containing Terraform configuration files (provider plugin/module)

`terraform init`

To check the resources it will create (dry run) -

`terraform plan`

To Create Users (actual run) -

`terraform apply`

To delete Users -

`terraform destroy`