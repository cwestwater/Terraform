# Login variables
variable "username" {
    type = "string"
}

variable "password" {
    type = "string"
}

variable "vcenter" {
    type = "string"
}

# Data variables
variable "datacenter" {
    type = "string"
}

variable "datastore" {
    type = "string"
}

variable "iso_datastore" {
    type = "string"
}

variable "pool" {
    type = "string"
}

variable "network" {
    type = "string"
}

# 2012 R2 variables
variable "vmname" {
    type = "string"
    description = "What is the name of the VM"
}

variable "numcpus" {}

variable "ostype" {
    type = "string"
}

variable "timeout"{}

variable "diskname" {
    type = "string"
}

variable "size"{}

variable "iso" {
    type = "string"
}