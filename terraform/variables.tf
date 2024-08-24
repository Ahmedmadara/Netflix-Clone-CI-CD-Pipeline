variable "region" {
  default = "us-east-1"
}

variable "ami" {
  description = "The AMI ID to use for the instances"
  default     = "ami-0c55b159cbfafe1f0"  # Update this with a valid AMI ID
}
