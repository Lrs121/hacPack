include config.mk

.PHONY: clean

INCLUDE = -I ./mbedtls/include
LIBDIR = ./mbedtls/library
CFLAGS += -Wno-implicit-fallthrough -Wno-missing-braces
CFLAGS += -D_BSD_SOURCE -D_POSIX_SOURCE -D_POSIX_C_SOURCE=200112L -D_DEFAULT_SOURCE -D__USE_MINGW_ANSI_STDIO=1 -D_FILE_OFFSET_BITS=64

all:
	cd mbedtls && $(MAKE) lib
	$(MAKE) hacpack

.c.o:
	$(CC) $(INCLUDE) -c $(CFLAGS) -o $@ $<

hacpack: sha.o aes.o extkeys.o pki.o utils.o main.o filepath.o ConvertUTF.o nca.o romfs.o pfs0.o ivfc.o nacp.o npdm.o cnmt.o ticket.o rsa.o
	$(CC) -o $@ $^ $(LDFLAGS) -L $(LIBDIR)

aes.o: src/aes.h src/types.h

extkeys.o: src/extkeys.h src/types.h src/settings.h

filepath.o: src/filepath.c src/types.h

main.o: src/main.c src/pki.h src/types.h src/version.h

pki.o: src/pki.h src/aes.h src/types.h

nca.o: src/nca.h

romfs.o: src/romfs.h

pfs0.o: src/pfs0.h

cnmt.o: src/cnmt.h

nacp.o: src/nacp.h

npdm.o: src/npdm.h

ivfc.o: src/ivfc.h

sha.o: src/sha.h src/types.h

utils.o: src/utils.h src/types.h

ticket.o: src/ticket.h src/ticket_files.h

ConvertUTF.o: src/ConvertUTF.h

rsa.o: src/rsa.h src/rsa_keys.h

clean:
	rm -f *.o hacpack hacpack.exe

clean_full:
	rm -f *.o hacpack hacpack.exe
	cd mbedtls && $(MAKE) clean

dist: clean_full
	$(eval HACPACKVER = $(shell grep '\bHACPACK_VERSION\b' version.h \
		| cut -d' ' -f3 \
		| sed -e 's/"//g'))
	mkdir hacpack-$(HACPACKVER)
	cp -R *.c *.h config.mk.template Makefile README.md LICENSE mbedtls hacpack-$(HACPACKVER)
	tar czf hacpack-$(HACPACKVER).tar.gz hacpack-$(HACPACKVER)
	rm -r hacpack-$(HACPACKVER)

