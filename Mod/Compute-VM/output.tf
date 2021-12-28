output "service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = local.service_account
}
