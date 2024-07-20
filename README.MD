# AWS Account Onboarding with Terraform

## Modules

- **Organization Module**: Creates an AWS organization, an OU, and sets up permissions.
- **Route 53 Module**: Creates a Route 53 hosted zone and DNS records.
- **Account Module**: Creates a new AWS account and sets up Route 53 resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed with the version 5.58 or higher.
- AWS CLI configured (optional but recommended)
- An AWS account with the necessary permissions

## Usage

1. **Configure AWS credentials**:

    Either run `aws configure` and provision the credentials manually OR
    Provide credentials in the `.env.` file. 
    Be cautious with storing sensitive information in plain text!

2. **Clone the repository**:

    ```sh
    git clone https://github.com/dagrig/AWS_account_onboarding.git
    cd aws_onboarding
    ```

3. **Copy the `env.example` file to `.env`**:

    ```sh
    cp env.example .env
    ```

4. **Edit the `.env` file**:
    
    Open the `.env` file in a text editor and replace the placeholder values with your actual AWS credentials and configuration settings.

5. **Load environment variables**:

    Use the provided shell script to load the environment variables:

    ```sh
    source load_env_variables.sh
    ```

6. **Initialize Terraform**:

    ```sh
    terraform init
    ```

7. **Apply the Terraform configuration**:

    ```sh
    terraform apply
    ```

8. **Check the outputs**:

    ```sh
    terraform output
    ```

## Outputs

- **organization_id**: The ID of the created AWS organization.
- **organization_unit_id**: The ID of the created AWS organization unit.
- **new_account_id**: The ID of the newly created account.

## Notes

Ensure you have the necessary permissions to create AWS organizations, accounts, and Route 53 resources.
This may not work in the root account, because root accounts cannot assume roles needed for this deployment.
Consider creating a new administrator account in the IAM.