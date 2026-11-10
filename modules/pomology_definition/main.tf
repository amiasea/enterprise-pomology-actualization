data "github_release" "this" {
  owner       = var.github_organization
  repository  = var.repository
  retrieve_by = "tag"
  release_tag = var.release_tag
}

locals {
  pomology_asset = one([
    for asset in data.github_release.this.assets : asset
    if endswith(asset.name, "-pomology.json")
  ])
}

data "github_release_asset" "pomology" {
  owner = var.github_organization
  repository = var.repository
  asset_id = local.pomology_asset.id

  download_file_contents = true
}