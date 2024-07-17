# AWS Account Onboarding with Terraform - OPTION 1

## Modules

- **Organization Module**: Creates an AWS organization, an OU, and sets up permissions.
- **Route 53 Module**: Creates a Route 53 hosted zone and DNS records.
- **Account Module**: Creates a new AWS account and sets up Route 53 resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured (optional but recommended)
- An AWS account with the necessary permissions

## Usage

1. **Clone the repository**:

    ```sh
    git clone <repository-url>
    cd aws-onboarding
    ```

2. **Copy the `env.example` file to `.env`**:

    ```sh
    cp env.example .env
    ```

3. **Edit the `.env` file**:
    
    Open the `.env` file in a text editor and replace the placeholder values with your actual AWS credentials and configuration settings.

4. **Load environment variables**:

    Use the provided shell script to load the environment variables:

    ```sh
    source load_env_variables.sh
    ```

5. **Initialize Terraform**:

    ```sh
    terraform init
    ```

6. **Apply the Terraform configuration**:

    ```sh
    terraform apply
    ```

7. **Check the outputs**:

    ```sh
    terraform output
    ```

## Outputs

- **account_id**: The ID of the created AWS account.
- **zone_id**: The ID of the created Route 53 hosted zone.

## Notes

Ensure you have the necessary permissions to create AWS organizations, accounts, and Route 53 resources.