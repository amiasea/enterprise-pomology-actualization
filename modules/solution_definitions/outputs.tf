output "pomologies" {
  description = "Solution pomologies keyed by solution name."

  value = {
    for solution_name, asset in data.github_release_asset.pomologies :
    solution_name => jsondecode(base64decode(asset.file_contents))
  }
}

output "release_tag" {
  description = "Release tag from which the solution definitions were retrieved."
  value       = data.github_release.this.release_tag
}