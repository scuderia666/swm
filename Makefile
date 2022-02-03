include config.mk

SRC = draw.c swm.c util.c
OBJ = ${SRC:.c=.o}

all: options swm

options:
	@echo swm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

swm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f swm ${OBJ} swm-${VERSION}.tar.gz

dist: clean
	mkdir -p swm-${VERSION}
	cp -R Makefile config.mk \
		draw.h util.h ${SRC} transient.c swm-${VERSION}
	tar -cf swm-${VERSION}.tar swm-${VERSION}
	gzip swm-${VERSION}.tar
	rm -rf swm-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f swm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/swm

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/swm

.PHONY: all options clean dist install uninstall