#!/bin/bash

bundle exec rspec || exit 1

git push origin master
