provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"

  default_tags {
    tags = {
      Stage      = "DEV"
      Org        = "TBD"
      Service    = "DevOps"
      Owner      = "TBD"
      Project    = "DOS"
      No_managed = "FALSE"
      History    = ""
      System     = ""
      OSType     = ""
    }
  }
}
