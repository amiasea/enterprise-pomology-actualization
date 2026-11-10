output "pomology" {
  description = "Solution pomology."

  value = jsondecode(base64decode(data.github_release_asset.pomology.file_contents))
}

output "release_tag" {
  description = "Release tag from which the solution definitions were retrieved."
  value       = data.github_release.this.release_tag
}