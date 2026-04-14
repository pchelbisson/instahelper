variable "yc_token" {
  description = "OAuth token for accessing Yandex Cloud"
  sensitive   = true
}
variable "yc_cloud_id" {
  description = "Cloud ID"
}
variable "yc_folder_id" {
  description = "Folder ID"
}
variable "yc_zone" {
  description = "Availability zone"
  default     = "ru-central1-a"
}
variable "image_family" {
  description = "Family of images for VM"
  default     = "ubuntu-2204-lts"
}
variable "vm_name" {
  description = "VM name"
  default     = "instahelper-vm"
}