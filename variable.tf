variable "githubtoken" {
  type = string
}

variable "gitlabtoken" {
  type = string
}

variable "git_runners" {
  type    = number
  default = 3
}

variable "linuxuser" {
  type    = string
  default = "runner"
}

variable "publicssh" {
  type = string
}

variable "gitorg" {
  type = string
}

variable "gitproject" {
  type = string
}

variable "timezone" {
  type = string
}

variable "lang" {
  type = string
}

variable "release" {
  type = string
}

variable "oid" {
  type = string
}

variable "osecret" {
  type = string
}
