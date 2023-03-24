# Zone settings
variable "application" {
  type = map
}
variable "policy" {
  type = any
}
variable "group" {
  type = map
}
variable "zone_id" {
  type = string
  default = "zone_id"
}