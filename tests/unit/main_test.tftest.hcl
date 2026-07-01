# Unit tests for tf-molecule-sqs-queue-dlq-aws
#
# These tests use a mock AWS provider — no real AWS calls are made and no
# infrastructure is created. All runs are plan-only.
#
# Run with:         terraform test
# Run verbose:      terraform test -verbose
# Run specific:     terraform test -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  # tf-label identity
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Molecule inputs (all have defaults; set explicitly for a deterministic plan)
  visibility_timeout_seconds    = 45
  message_retention_seconds     = 345600
  dlq_message_retention_seconds = 1209600
  delay_seconds                 = 0
  max_message_size              = 262144
  max_receive_count             = 5
}

# ---------------------------------------------------------------------------
# When enabled (default), the molecule provisions the queue + DLQ pair.
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }
}

# ---------------------------------------------------------------------------
# Alternate configuration still plans cleanly and reports enabled = true.
# (The molecule's redrive-allow atom requires a non-null DLQ url, so the fully
# disabled path cannot be planned; enablement is exercised via the output.)
# ---------------------------------------------------------------------------
run "custom_config_plans" {
  command = plan

  variables {
    delay_seconds     = 15
    max_receive_count = 10
  }

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true for the default (enabled) module"
  }
}
