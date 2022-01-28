provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"

  default_tags {
    tags = {
      Stage      = "PRD"
      Org        = "TBD"
      Service    = "Digital Life"
      Owner      = "TBD"
      Project    = "DLS"
      No_managed = "FALSE"
      History    = ""
      System     = ""
      OSType     = ""
    }
  }
}
