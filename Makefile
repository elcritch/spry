

NIMBLE := _nimble
NIMLIB := $(shell nim dump file.json 2>&1 | tail -n1)
NIMCACHE := nimcache
# Unsure about this, since we compiled it ourself maybe it's not important
NIM_PROGRAM := src/ispry.nim


nim: clean
	nim cpp \
		-d:debug \
		--passC:"-g " \
		--debugger:native \
		--gc:arc \
		--exceptions:cpp \
		--dead_code_elim:on \
		--threads:on \
		--threadanalysis:off \
		--tls_emulation:off \
		--verbosity:2 \
		--multimethods:on \
		-d:nimOldCaseObjects \
		-d:spryMathNoRandom \
		--stackTrace:on \
		--lineTrace:on \
		--assertions:on \
		-d:no_signal_handler \
		-d:use_malloc \
		-d:dorepl \
		--nim_cache:"$(PWD)/$(NIMCACHE)" \
		--nimble_path:"$(PWD)/$(NIMBLE)/pkgs" \
		--compileOnly \
		--genScript:on \
		$(NIM_PROGRAM)


clean:
	rm -Rf src/ispry 
	rm -Rf $(NIMCACHE)
	rm -f *.bin *.elf
	rm -f *.cpp *.h
	# rm -Rf $(PWD)/*.cpp
	# rm -Rf $(PWD)/*.h

distclean: clean
	rm -Rf _nimble 


deps:
	nimble install -y --nimbleDir:"_nimble" https://github.com/elcritch/spryvm.git
	# nimble install -y --nimbleDir:"_nimble" https://github.com/gokr/spryvm.git
	rm -Rf $(NIMBLE)/bin/temp_file $(NIMBLE)/bin/tempfile_seeder



