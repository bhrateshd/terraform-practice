variable "instance_id" {
    description = "EC2 instance ID"
  
}
variable "email" {
    description = "Email address for notifications"
}
variable "cpu_threshold" {
    description = "CPU utilization threshold for alarms"
    default = 80
}