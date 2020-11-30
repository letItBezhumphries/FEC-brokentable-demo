# backend.hcl
bucket         = "fec-brokentable-tfstate"
region         = "us-west-2"
dynamodb_table = "fec-brokentable-tfstate-locks"
encrypt        = true
