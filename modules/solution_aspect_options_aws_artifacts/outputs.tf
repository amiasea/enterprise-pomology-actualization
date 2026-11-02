output "ecr_repository_names" {
  description = "ECR repository names keyed by aspect option codename."
  value = {
    for codename, repository in aws_ecr_repository.ecr_repository :
    codename => repository.name
  }
}

output "ecr_repository_arns" {
  description = "ECR repository ARNs keyed by aspect option codename."
  value = {
    for codename, repository in aws_ecr_repository.ecr_repository :
    codename => repository.arn
  }
}

output "ecr_repository_urls" {
  description = "ECR repository URLs keyed by aspect option codename."
  value = {
    for codename, repository in aws_ecr_repository.ecr_repository :
    codename => repository.repository_url
  }
}

output "package_repository_names" {
  description = "CodeArtifact package repository names keyed by aspect option codename."
  value = {
    for codename, repository in aws_codeartifact_repository.package_repository :
    codename => repository.repository
  }
}

output "package_repository_arns" {
  description = "CodeArtifact package repository ARNs keyed by aspect option codename."
  value = {
    for codename, repository in aws_codeartifact_repository.package_repository :
    codename => repository.arn
  }
}

output "codeartifact_package_arns" {
  description = "CodeArtifact package ARN patterns keyed by aspect option codename."
  value = {
    for codename, repository in aws_codeartifact_repository.package_repository :
    codename => "${replace(repository.arn, ":repository/", ":package/")}/*/*/*"
  }
}