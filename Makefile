# HMHDA-0115-2026W1: Health Data and Visualization.
#
#   make        same as `make help`
#   make help   list the targets

.PHONY: help

help:  ## List the targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-12s %s\n", $$1, $$2}'
