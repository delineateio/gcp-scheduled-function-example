variable "name" {
  description = "base name of the function"
  type        = string
}

variable "entry_point" {
  description = "function entry point name"
  type        = string
}

variable "runtime" {
  description = "language runtime & version (e.g. nodejs10)"
  type        = string
  default     = "nodejs10"
}

variable "function_source" {
  description = "local source of the function code"
  type        = string
}

variable "available_memory_mb" {
  description = "available memory for the function (e.g. 128mb)"
  type        = number
  default     = 128
}

variable "time_zone" {
  description = "time zone for the scheduler (e.g. Europe/London)"
  type        = string
  default     = "Europe/London"
}

variable "schedule" {
  description = "schedule on which to run the function"
  type        = string
}

variable "attempt_deadline" {
  description = "the deadline for attempting"
  type        = string
  default     = "360s"
}

variable "http_method" {
  description = "http method to use for calling the function (e.g. POST)"
  type        = string
  default     = "POST"
}
