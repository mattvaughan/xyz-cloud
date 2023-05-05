resource "buildkite_pipeline" "xyz_cloud" {
    name = "xyz"
    repository = "git@github.com:mattvaughan/xyz-cloud"
    steps = file("../.buildkite/pipeline.yml")

    team {
        slug = "everyone"
        access_level = "READ_ONLY"
    }
}
