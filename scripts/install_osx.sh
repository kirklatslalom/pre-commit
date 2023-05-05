#!/bin/bash

DIR=/opt/homebrew/bin/

# Install prerequisites
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ ! -f $DIR/pylint ]; then
    brew install pylint
  fi
  if [ ! -f $DIR/ansible-lint ]; then
    brew install ansible-lint
  fi
  if [ ! -f $DIR/ansible ]; then
    brew install ansible
  fi
  if [ ! -f $DIR/pre-commit ]; then
    brew install pre-commit
  fi
  if [ ! -f $DIR/black ]; then
    brew install black
  fi
  if [ ! -f $DIR/terraform-docs ]; then
    brew install terraform-docs
  fi
  if [ ! -f $DIR/tflint ]; then
    brew install tflint
  fi
  if [ ! -f $DIR/gbase64 ]; then
    brew install coreutils
  fi
  if [ ! -f $DIR/gawk ]; then
    brew install gawk
  fi
  if [ ! -f $DIR/tfsec ]; then
    brew tap liamg/tfsec
    brew install tfsec
  fi
  if [ ! -f $DIR/hadolint ]; then
    brew install hadolint
  fi
  if [ ! -f $DIR/jq ]; then
    brew install jq
  fi
  if [ ! -f $DIR/terraform ]; then
    brew install tfenv
    tfenv init
    LATEST=`tfenv list-remote | head -1`
    tfenv install $LATEST
    tfenv use $LATEST
  fi
  if [ ! -f $DIR/infracost ]; then
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
