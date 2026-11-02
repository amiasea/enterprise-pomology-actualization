
output "organization_variable_names" {
  description = "Names of the GitHub Actions organization variables managed for this solution."
  value = {
    for key, variable in local.organization_variables :
    key => variable.name
  }
}
