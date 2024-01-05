ifndef __color_mk
__color_mk=1

c.INF := $(shell tput setaf 2)# green
c.WRN := $(shell tput setaf 3)# yellow
c.ERR := $(shell tput setaf 1)# red
c.RST := $(shell tput sgr0)# reset to default color

dump::
	@echo "$(c.INF)c.INF$(c.RST)"
	@echo "$(c.WRN)c.WRN$(c.RST)"
	@echo "$(c.ERR)c.ERR$(c.RST)"

endif # __color_mk
