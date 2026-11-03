output "solution_variety_topologies" {
  description = "Actualized repository topology partitioned by solution and variety."

  type = map(object({
    definition_release = string

    varieties = map(object({
      cordons = map(object({
        repository = object({
          name    = string
          id      = number
          node_id = string
        })

        leaves = map(object({
          repository = object({
            name    = string
            id      = number
            node_id = string
          })

          option = string
        }))
      }))
    }))
  }))

  value = {
    for solution_name, pomology in component.solution_definitions.pomologies :
    solution_name => {
      definition_release = var.solution_definitions_release_tag

      varieties = {
        for variety_name in toset(pomology.varieties) :
        variety_name => {
          cordons = {
            for cordon_name, cordon in component.espalier[solution_name].variety_cordon_repositories :
            cordon_name => {
              repository = {
                name    = cordon.cordon.repository_name
                id      = cordon.cordon.repository_id
                node_id = cordon.cordon.repository_node_id
              }

              leaves = {
                for leaf_name, leaf in cordon.varieties[variety_name].leaves :
                leaf_name => {
                  repository = {
                    name    = leaf.repository_name
                    id      = leaf.repository_id
                    node_id = leaf.repository_node_id
                  }

                  option = leaf.option
                }
              }
            }
            if contains(keys(cordon.varieties), variety_name)
          }
        }
      }
    }
  }
}