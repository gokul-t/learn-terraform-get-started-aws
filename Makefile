# Usage: make SERVICE=ec2 plan
SERVICE ?= ec2

plan:
	@terraform -chdir=$(SERVICE) plan

apply:
	@terraform -chdir=$(SERVICE) apply -auto-approve

destroy:
	@terraform -chdir=$(SERVICE) destroy
