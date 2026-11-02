data "github_release" "this" {
  owner       = var.github_organization
  repository  = var.repository
  retrieve_by = "tag"
  release_tag = var.release_tag
}

locals {
  pomology_assets = {
    for asset in data.github_release.this.assets :
    trimsuffix(asset.name, "-pomology.json") => asset
    if endswith(asset.name, "-pomology.json")
  }
}

data "github_release_asset" "pomologies" {
  for_each = local.pomology_assets

  owner = var.github_organization
  repository = var.repository
  asset_id = each.value.id

  download_file_contents = true
}