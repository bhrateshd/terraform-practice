1. **Terraform Init:**

    • terraform init initializes a Terraform working directory by downloading and installing 
    the necessary plugins for the configured providers.

    • This command is typically run in the directory containing your Terraform configuration 
    files (*.tf files) before any other Terraform command.

    • During initialization, terraform reads the configuration files and identifies the 
    providers and modules being used. It then downloads the necessary provider plugins 
    and modules from the Terraform Registry or other specified sources.

2. **Terraform Validate:**

    • terraform validate validates the Terraform configuration files for syntax errors and 
    other basic errors before any operation is performed.

    • This command checks the syntax of the configuration files (*.tf files) and ensures that 
    all references to resources and variables are valid.

    • It is a useful command to run to catch errors early in the development process before 
    attempting to apply changes to your infrastructure.

3. **Terraform Plan:**

    • terraform plan creates an execution plan, which shows what actions Terraform will 
    take to change the infrastructure to match the configuration.

    • This command analyzes the Terraform configuration files and the current state of the 
    infrastructure to determine what actions need to be taken to achieve the desired state 
    specified in the configuration.

    • It does not make any changes to the infrastructure but provides a preview of the 
    changes that Terraform will apply when running the terraform apply command.

4. **Terraform Apply:**

    • terraform apply applies the changes required to reach the desired state of the 
    configuration. It executes the actions proposed in the execution plan generated by 
    terraform plan.

    • This command makes changes to the infrastructure according to the configuration 
    specified in the Terraform files.

    • It creates, updates, or deletes resources as necessary to bring the infrastructure into 
    the desired state.

    • After applying the changes, Terraform updates the state file (terraform.tfstate) with 
    the new state of the infrastructure.

5. **Terraform Destroy:**

    • terraform destroy destroys all the resources defined in the Terraform configuration, 
    effectively deleting the infrastructure managed by Terraform.

    • This command is used to tear down the infrastructure provisioned by Terraform and 
    clean up all resources created by the configuration.

    • It reads the Terraform state file (terraform.tfstate) to determine which resources were 
    created and need to be destroyed.

    • It prompts for confirmation before proceeding with the destruction to prevent 
    accidental deletion of resources.

These commands are essential for working with Terraform to manage your infrastructure as code. 
They allow you to initialize your environment, validate your configurations, plan and apply 
changes, and destroy resources when they are no longer needed