#!/bin/bash
# Install prerequisites
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ ! -f /usr/local/bin/pylint ]; then
    brew install pylint
  fi
  if [ ! -f /usr/local/bin/pre-commit ]; then
    brew install pre-commit
  fi
  if [ ! -f /usr/local/bin/black ]; then
    brew install black
  fi
  if [ ! -f /usr/local/bin/terraform-docs ]; then
    brew install terraform-docs
  fi
  if [ ! -f /usr/local/bin/tflint ]; then
    brew install tflint
  fi
  if [ ! -f /usr/local/bin/gbase64 ]; then
    brew install coreutils
  fi
  if [ ! -f /usr/local/bin/gawk ]; then
    brew install gawk
  fi
  if [ ! -f /usr/local/bin/tfsec ]; then
    brew tap liamg/tfsec
    brew install tfsec
  fi
  if [ ! -f /usr/local/bin/hadolint ]; then
    brew install hadolint
  fi
  if [ ! -f /usr/local/bin/jq ]; then
    brew install jq
  fi
  if [ ! -f /usr/local/bin/terraform ]; then
    brew install tfenv
    tfenv init
    LATEST=`tfenv list-remote | head -1`
    tfenv install $LATEST
    tfenv use $LATEST
  fi
  if [ ! -f /usr/local/bin/infracost ]; then
    brew install infracost
  fi
fi

python3 -m pip install -r requirements.txt
if [ $? -eq 0 ]; then
  if [ -f .git/hooks/pre-commit ]; then
  pre-commit uninstall
  fi
  pre-commit install
fi

DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}

# GCP auth
#gcloud auth application-default login
