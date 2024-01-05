ifndef __swift_mk
__swift_mk=1

include $(BUILDER)/git.mk

format:: swift-format
lint:: swift-lint

.PHONY: swift-format swift-lint

swift-format:
	@echo "$(c.INF)$@$(c.RST)"
	@swift-format --configuration $(BUILDER)/swift-format.json --in-place --recursive .

swift-lint:
	@echo "$(c.INF)$@$(c.RST)"
	swift-format lint --configuration $(BUILDER)/swift-format.json --recursive .

endif # __swift_mk
