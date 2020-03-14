# Collect information to build as sensible package name
name = script.module.boto3
version = $(shell xmllint --xpath 'string(/addon/@version)' addon.xml)
git_branch = $(shell git rev-parse --abbrev-ref HEAD)
git_hash = $(shell git rev-parse --short HEAD)
zip_name = $(name)-$(version)-$(git_branch)-$(git_hash).zip
include_files = addon.xml icon.png lib/
include_paths = $(patsubst %,$(name)/%,$(include_files))
exclude_files = \*.new \*.orig \*.pyc \*.pyo

all: build

build:
	@echo ">>> Building package"
	@rm -f ../$(zip_name)
	cd ..; zip -r $(zip_name) $(include_paths) -x $(exclude_files)
	@echo "Successfully wrote package as: ../$(zip_name)"

update:
	pip3 install --no-deps -t lib --upgrade boto3 botocore jmespath s3transfer
	rm -rf lib/bin lib/*.dist-info

.PHONY: build update
