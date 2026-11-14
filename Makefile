# Usage: make SERVICE=ec2 plan
SERVICE ?= ec2

init:
	@terraform -chdir=$(SERVICE) init

plan:
	@terraform -chdir=$(SERVICE) plan

apply:
	@terraform -chdir=$(SERVICE) apply -auto-approve

destroy:
	@terraform -chdir=$(SERVICE) destroy

destroy-all:
	@for svc in ec2 alb ebs efs s3; do \
	  echo "=== $$svc ==="; \
	  terraform -chdir=$$svc destroy -auto-approve; \
	done
