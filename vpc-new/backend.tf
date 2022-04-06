terraform{
    backend "s3"{
        bucket = "bucketadmin"
        key = "VPC/terraform.tfstate"
        region = "us-west-2"
    }
}