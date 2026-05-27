variable "visibility_timeout_seconds" {
  description = "Visibility timeout"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Message retention"
  type        = number
  default     = 345600
}

variable "dlq_message_retention_seconds" {
  description = "DLQ retention"
  type        = number
  default     = 1209600
}

variable "delay_seconds" {
  description = "Delay seconds"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "Max message size bytes"
  type        = number
  default     = 262144
}

variable "max_receive_count" {
  description = "Max receives before DLQ"
  type        = number
  default     = 3
}
