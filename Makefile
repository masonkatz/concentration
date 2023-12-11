BUILDER=./.builder
RULES=swift
include $(BUILDER)/rules.mk
$(BUILDER)/rules.mk:
	-go run github.com/endobit/builder@latest init

