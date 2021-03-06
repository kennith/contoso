variable "GIT_SHA" {
    type = string
    default = env("GITHUB_SHA")
}
