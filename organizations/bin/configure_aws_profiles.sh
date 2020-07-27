#!/usr/bin/env bash

cp ~/.aws/config ~/.aws/config.bak
cat ~/.aws/config <(echo) <(echo) aws_config.ini > config
mv config ~/.aws/config
