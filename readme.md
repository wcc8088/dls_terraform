# Terraform 개요
Terraform은 HashiCorp사가 만든 오픈 소스 "코드형 인프라(IaC ; Infrastructure as Code)" 툴 입니다. 
AWS, Azure, GCP, OCP 등 퍼블릭 클라우드를 비롯하여 Docker, Kubernetes, vSphere 등 컨테이너 환경까지 지원하고 있습니다.

# Terraform 환경 구성
Terraform 을 실행하는 CLI 환경을 Linux 환경에 설치합니다.

## CentOS/RHEL
1. yum-config-manager 를 설치합니다.
>$> sudo yum install -y yum-utils

2. yum에 HashiCorp Linux repository를 추가합니다.
>$>sudo yum-config-manager --add-repo \ https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

3. 패키지를 설치합니다.
>$> sudo yum -y install terraform

## Ubuntu/Debian
1. 필요한 패키지들을 설치합니다.
>$> sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

2. HashiCorp GPG key를 추가합니다.
>$> curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

3. HashiCorp Linux repository를 추가합니다.
>$> sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

4. Terraform CLI를 설치합니다.
>$> sudo apt-get update && sudo apt-get install terraform

# Terraform for AWS 기본
AWS 클라우드를 지원하는 Terraform 코드에 대한 기본적인 정보입니다. Terraform에서는 기본적으로 AWS CLI 

## AWS CLI 설치
다음 문서를 참고하여 AWS에 가입하고 AWS CLI를 사용할 유저와 키를 생성합니다.
>https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html
- Step 1: Sign up to AWS
- Step 2: Create an IAM user account
- Step 3: Create an access key ID and secret access key

1. 설치파일을 다운로드합니다.
>$> curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

2. zip 파일을 unzip 합니다.
>$> unzip awscliv2.zip

3.설치 파일을 실행합니다.
>$> sudo ./aws/install

4. 버전을 확인합니다.
>$> aws --version

5. AWS 계정 환경을 구성합니다.
>$> aws configure
설정된 계정정보는 $HOME/.aws/credentials 위치에 저장되어 Terraform profile에서 사용됩니다.

## Terraform 기초
실행 디렉토리의 모든 .tf 파일을 로드하여 환경을 구성합니다. 따라서 환경에 대한 profile, variable, output 등을 별도의 파일로 저장하여 재활용 가능합니다.
1. 테라폼 버전을 확인합니다.
>$> terraform version

2. main.tf 라는 이름으로 테라폼 설정 파일을 생성합니다.
<pre>
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0d59252a0322103a5"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
</pre>
* Terraform {} - 실행에 필요한 버전들을 정의합니다.
* provider “aws” {} - aws 환경에 필요한 계정정보, region 정보를 정의합니다.
* resource “module” “name” {} - module을 이용하여 name 이름으로 resource를 생성합니다.

3. 테라폼 실행 디렉토리를 초기화합니다.
>$> terraform init

4. 테라폼 설정파일을 포멧에 맞게 수정합니다. 정상일 경우에는 아무 값도 보여주지 않습니다.
>$> terraform fmt

5. 테라폼 설정파일을 검사합니다. 정상일 경우 success 메시지가 보입니다.
>$> terraform validate

6. 테라폼 설정파일을 적용합니다. 실제 리소스가 생성됩니다.
>$> terraform apply

7. 테라폼으로 생성된 리소스 정보를 출력합니다.
>$> terraform show

8. 테라폼으로 만들어진 리소스를 삭제합니다.
>$> terraform destroy

# 참고 링크
* 테라폼 Registry / provider 정보
https://registry.terraform.io/browse/providers?tier=official
* AWS 모듈 정보
https://registry.terraform.io/browse/modules?provider=aws
* 테라폼 튜토리얼
https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started
