# AI4NG_VPC Infrastructure
This repository contains the CloudFormation templates for the core networking infrastructure.

## Deployment

Changes merged to `main` will automatically deploy via GitHub Actions.

### Manual Deployment
```bash
aws cloudformation deploy \
  --stack-name NetworkStack \
  --template-file infra/vpc-main.yaml \
  --region eu-west-2 \
  --capabilities CAPABILITY_IAM
```

## Architecture
- VPC with private subnets across 2 AZs
- VPC endpoints for S3, DynamoDB, ECR, and EventBridge
- Restricted security groups