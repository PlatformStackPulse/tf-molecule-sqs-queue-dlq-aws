# Molecule: SQS Queue with Dead Letter Queue
module "dlq" {
  source                    = "git::https://github.com/PlatformStackPulse/tf-atom-sqs-queue-aws.git?ref=0fc607b4161d90e581137af1c5f5528d15e36e26"
  context                   = module.this.context
  attributes                = ["dlq"]
  message_retention_seconds = var.dlq_message_retention_seconds
}

module "queue" {
  source                     = "git::https://github.com/PlatformStackPulse/tf-atom-sqs-queue-aws.git?ref=0fc607b4161d90e581137af1c5f5528d15e36e26"
  context                    = module.this.context
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  redrive_policy = jsonencode({
    deadLetterTargetArn = module.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
  depends_on = [module.dlq]
}

module "redrive_allow" {
  source            = "git::https://github.com/PlatformStackPulse/tf-atom-sqs-queue-redrive-allow-policy-aws.git?ref=2c307e9351866f6ac395cc859f522cc1888688b3"
  context           = module.this.context
  queue_url         = module.dlq.url
  source_queue_arns = [module.queue.arn]
  depends_on        = [module.dlq, module.queue]
}
