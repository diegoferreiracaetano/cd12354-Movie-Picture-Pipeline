variable "k8s_version" {
  # AWS deprecated 1.25; keep this in sync with `aws eks describe-cluster-versions`
  default = "1.36"
}

variable "enable_private" {
  default = false
}

variable "public_az" {
  type        = string
  description = "Change this to a letter a-f only if you encounter an error during setup"
  default     = "a"
}

variable "private_az" {
  type        = string
  description = "Change this to a letter a-f only if you encounter an error during setup"
  default     = "b"
}
