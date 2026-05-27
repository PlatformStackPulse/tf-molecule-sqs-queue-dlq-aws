output "enabled" {
  description = "Whether enabled"
  value       = local.enabled
}

output "queue_arn" {
  description = "Main queue ARN"
  value       = module.queue.arn
}

output "queue_url" {
  description = "Main queue URL"
  value       = module.queue.url
}

output "queue_name" {
  description = "Main queue name"
  value       = module.queue.name
}

output "dlq_arn" {
  description = "DLQ ARN"
  value       = module.dlq.arn
}

output "dlq_url" {
  description = "DLQ URL"
  value       = module.dlq.url
}
