DIRS=GIMX

all:
	+for i in $(DIRS); do cd $$i; make all; cd ..; done

clean:
	for i in $(DIRS); do cd $$i; make clean; cd ..; done

install: all
	for i in $(DIRS); do cd $$i; make install; cd ..; done

uninstall:
	-for i in $(DIRS); do cd $$i; make uninstall; cd ..; done

really-clean: clean uninstall
