#
# Auto-configuring Makefile for the Netwide Assembler.
#
# The Netwide Assembler is copyright (C) 1996 Simon Tatham and
# Julian Hall. All rights reserved. The software is
# redistributable under the license given in the file "LICENSE"
# distributed in the NASM archive.



top_srcdir	= .
srcdir		= .
objdir		= .

prefix		= C:/Users/manas/Downloads/nasm-2.14.02/_esy/default/store/i/esy_nasm-a9020e02
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
mandir		= ${datarootdir}/man
datarootdir	= ${prefix}/share

CC		= x86_64-w64-mingw32-gcc.exe
CFLAGS		= -g -O3 -fwrapv -U__STRICT_ANSI__ -fno-common -Werror=attributes -fvisibility=hidden -W -Wall -pedantic -Wno-pedantic-ms-format -Wc90-c99-compat -Wno-long-long -Wno-shift-negative-value -Werror=implicit -Werror=missing-braces -Werror=return-type -Werror=trigraphs -Werror=pointer-arith -Werror=missing-prototypes -Werror=missing-declarations -Werror=comment -Werror=vla
CPPFLAGS	= 
BUILD_CFLAGS	= $(CPPFLAGS) $(CFLAGS) -DHAVE_CONFIG_H
INTERNAL_CFLAGS = -I$(srcdir) -I$(objdir) \
		  -I$(srcdir)/include -I$(objdir)/include \
		  -I$(srcdir)/x86 -I$(objdir)/x86 \
		  -I$(srcdir)/asm -I$(objdir)/asm \
		  -I$(srcdir)/disasm -I$(objdir)/disasm \
		  -I$(srcdir)/output -I$(objdir)/output
ALL_CFLAGS	= $(BUILD_CFLAGS) $(INTERNAL_CFLAGS)
LDFLAGS		=  -fvisibility=hidden
LIBS		= 

AR		= 
RANLIB		= :
STRIP		= 

PERL		= perl
PERLFLAGS	= -I$(srcdir)/perllib -I$(srcdir)
RUNPERL         = $(PERL) $(PERLFLAGS)

INSTALL		= /usr/bin/install -c
INSTALL_PROGRAM	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644

NROFF		= nroff
ASCIIDOC	= false
XMLTO		= false

MAKENSIS	= makensis

MKDIR		= mkdir -p
RM_F		= rm -f
RM_RF		= rm -rf
LN_S		= ln -s
FIND		= find

# Binary suffixes
O               = o
X               = .exe
A		= a

# Debug stuff
ifeq ($(TRACE),1)
	CFLAGS += -DNASM_TRACE
endif

.SUFFIXES:
.SUFFIXES: $(X) .$(O) .$(A) .xml .1 .c .i .s .txt

.PHONY: all doc rdf install clean distclean cleaner spotless install_rdf test
.PHONY: install_doc everything install_everything strip perlreq dist tags TAGS
.PHONY: manpages nsis

.c.$(O):
	$(CC) -c $(ALL_CFLAGS) -o $@ $<

.c.s:
	$(CC) -S $(ALL_CFLAGS) -o $@ $<

.c.i:
	$(CC) -E $(ALL_CFLAGS) -o $@ $<

.txt.xml:
	$(ASCIIDOC) -b docbook -d manpage -o $@ $<

.xml.1:
	$(XMLTO) man --skip-validation $< 2>/dev/null

#-- Begin File Lists --#
NASM =	asm/nasm.$(O)
NDISASM = disasm/ndisasm.$(O)

LIBOBJ = stdlib/snprintf.$(O) stdlib/vsnprintf.$(O) stdlib/strlcpy.$(O) \
	stdlib/strnlen.$(O) stdlib/strrchrnul.$(O) \
	\
	nasmlib/ver.$(O) \
	nasmlib/crc64.$(O) nasmlib/malloc.$(O) nasmlib/errfile.$(O) \
	nasmlib/md5c.$(O) nasmlib/string.$(O) \
	nasmlib/file.$(O) nasmlib/mmap.$(O) nasmlib/ilog2.$(O) \
	nasmlib/realpath.$(O) nasmlib/path.$(O) \
	nasmlib/filename.$(O) nasmlib/srcfile.$(O) \
	nasmlib/zerobuf.$(O) nasmlib/readnum.$(O) nasmlib/bsi.$(O) \
	nasmlib/rbtree.$(O) nasmlib/hashtbl.$(O) \
	nasmlib/raa.$(O) nasmlib/saa.$(O) \
	nasmlib/strlist.$(O) \
	nasmlib/perfhash.$(O) nasmlib/badenum.$(O) \
	\
	common/common.$(O) \
	\
	x86/insnsa.$(O) x86/insnsb.$(O) x86/insnsd.$(O) x86/insnsn.$(O) \
	x86/regs.$(O) x86/regvals.$(O) x86/regflags.$(O) x86/regdis.$(O) \
	x86/disp8.$(O) x86/iflag.$(O) \
	\
	asm/error.$(O) \
	asm/float.$(O) \
	asm/directiv.$(O) asm/directbl.$(O) \
	asm/pragma.$(O) \
	asm/assemble.$(O) asm/labels.$(O) asm/parser.$(O) \
	asm/preproc.$(O) asm/quote.$(O) asm/pptok.$(O) \
	asm/listing.$(O) asm/eval.$(O) asm/exprlib.$(O) asm/exprdump.$(O) \
	asm/stdscan.$(O) \
	asm/strfunc.$(O) asm/tokhash.$(O) \
	asm/segalloc.$(O) \
	asm/preproc-nop.$(O) \
	asm/rdstrnum.$(O) \
	\
	macros/macros.$(O) \
	\
	output/outform.$(O) output/outlib.$(O) output/legacy.$(O) \
	output/strtbl.$(O) \
	output/nulldbg.$(O) output/nullout.$(O) \
	output/outbin.$(O) output/outaout.$(O) output/outcoff.$(O) \
	output/outelf.$(O) \
	output/outobj.$(O) output/outas86.$(O) output/outrdf2.$(O) \
	output/outdbg.$(O) output/outieee.$(O) output/outmacho.$(O) \
	output/codeview.$(O) \
	\
	disasm/disasm.$(O) disasm/sync.$(O)

SUBDIRS  = stdlib nasmlib output asm disasm x86 common macros
XSUBDIRS = test doc nsis rdoff
DEPDIRS  = . include config x86 rdoff $(SUBDIRS)
#-- End File Lists --#

all: nasm$(X) ndisasm$(X) rdf

NASMLIB = libnasm.$(A)

$(NASMLIB): $(LIBOBJ)
	$(RM_F) $(NASMLIB)
	$(AR) cq $(NASMLIB) $(LIBOBJ)
	$(RANLIB) $(NASMLIB)

nasm$(X): $(NASM) $(NASMLIB)
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o nasm$(X) $(NASM) $(NASMLIB) $(LIBS)

ndisasm$(X): $(NDISASM) $(NASMLIB)
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o ndisasm$(X) $(NDISASM) $(NASMLIB) $(LIBS)

#-- Begin Generated File Rules --#

# These source files are automagically generated from data files using
# Perl scripts. They're distributed, though, so it isn't necessary to
# have Perl just to recompile NASM from the distribution.

# Perl-generated source files
PERLREQ = x86/insnsb.c x86/insnsa.c x86/insnsd.c x86/insnsi.h x86/insnsn.c \
	  x86/regs.c x86/regs.h x86/regflags.c x86/regdis.c x86/regdis.h \
	  x86/regvals.c asm/tokhash.c asm/tokens.h asm/pptok.h asm/pptok.c \
	  x86/iflag.c x86/iflaggen.h \
	  macros/macros.c \
	  asm/pptok.ph asm/directbl.c asm/directiv.h \
	  version.h version.mac version.mak nsis/version.nsh

INSDEP = x86/insns.dat x86/insns.pl x86/insns-iflags.ph

x86/iflag.c: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -fc \
		$(srcdir)/x86/insns.dat x86/iflag.c
x86/iflaggen.h: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -fh \
		$(srcdir)/x86/insns.dat x86/iflaggen.h
x86/insnsb.c: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -b \
		$(srcdir)/x86/insns.dat x86/insnsb.c
x86/insnsa.c: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -a \
		$(srcdir)/x86/insns.dat x86/insnsa.c
x86/insnsd.c: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -d \
		$(srcdir)/x86/insns.dat x86/insnsd.c
x86/insnsi.h: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -i \
		$(srcdir)/x86/insns.dat x86/insnsi.h
x86/insnsn.c: $(INSDEP)
	$(RUNPERL) $(srcdir)/x86/insns.pl -n \
		$(srcdir)/x86/insns.dat x86/insnsn.c

# These files contains all the standard macros that are derived from
# the version number.
version.h: version version.pl
	$(RUNPERL) $(srcdir)/version.pl h < $(srcdir)/version > version.h
version.mac: version version.pl
	$(RUNPERL) $(srcdir)/version.pl mac < $(srcdir)/version > version.mac
version.sed: version version.pl
	$(RUNPERL) $(srcdir)/version.pl sed < $(srcdir)/version > version.sed
version.mak: version version.pl
	$(RUNPERL) $(srcdir)/version.pl make < $(srcdir)/version > version.mak
nsis/version.nsh: version version.pl
	$(RUNPERL) $(srcdir)/version.pl nsis < $(srcdir)/version > nsis/version.nsh

# This source file is generated from the standard macros file
# `standard.mac' by another Perl script. Again, it's part of the
# standard distribution.
macros/macros.c: macros/macros.pl asm/pptok.ph version.mac \
	$(srcdir)/macros/*.mac $(srcdir)/output/*.mac
	$(RUNPERL) $(srcdir)/macros/macros.pl version.mac \
		$(srcdir)/macros/*.mac $(srcdir)/output/*.mac

# These source files are generated from regs.dat by yet another
# perl script.
x86/regs.c: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl c \
		$(srcdir)/x86/regs.dat > x86/regs.c
x86/regflags.c: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl fc \
		$(srcdir)/x86/regs.dat > x86/regflags.c
x86/regdis.c: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl dc \
		$(srcdir)/x86/regs.dat > x86/regdis.c
x86/regdis.h: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl dh \
		$(srcdir)/x86/regs.dat > x86/regdis.h
x86/regvals.c: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl vc \
		$(srcdir)/x86/regs.dat > x86/regvals.c
x86/regs.h: x86/regs.dat x86/regs.pl
	$(RUNPERL) $(srcdir)/x86/regs.pl h \
		$(srcdir)/x86/regs.dat > x86/regs.h

# Assembler token hash
asm/tokhash.c: x86/insns.dat x86/regs.dat asm/tokens.dat asm/tokhash.pl \
	perllib/phash.ph
	$(RUNPERL) $(srcdir)/asm/tokhash.pl c \
		$(srcdir)/x86/insns.dat $(srcdir)/x86/regs.dat \
		$(srcdir)/asm/tokens.dat > asm/tokhash.c

# Assembler token metadata
asm/tokens.h: x86/insns.dat x86/regs.dat asm/tokens.dat asm/tokhash.pl \
	perllib/phash.ph
	$(RUNPERL) $(srcdir)/asm/tokhash.pl h \
		$(srcdir)/x86/insns.dat $(srcdir)/x86/regs.dat \
		$(srcdir)/asm/tokens.dat > asm/tokens.h

# Preprocessor token hash
asm/pptok.h: asm/pptok.dat asm/pptok.pl perllib/phash.ph
	$(RUNPERL) $(srcdir)/asm/pptok.pl h \
		$(srcdir)/asm/pptok.dat asm/pptok.h
asm/pptok.c: asm/pptok.dat asm/pptok.pl perllib/phash.ph
	$(RUNPERL) $(srcdir)/asm/pptok.pl c \
		$(srcdir)/asm/pptok.dat asm/pptok.c
asm/pptok.ph: asm/pptok.dat asm/pptok.pl perllib/phash.ph
	$(RUNPERL) $(srcdir)/asm/pptok.pl ph \
		$(srcdir)/asm/pptok.dat asm/pptok.ph

# Directives hash
asm/directiv.h: asm/directiv.dat nasmlib/perfhash.pl perllib/phash.ph
	$(RUNPERL) $(srcdir)/nasmlib/perfhash.pl h \
		$(srcdir)/asm/directiv.dat asm/directiv.h
asm/directbl.c: asm/directiv.dat nasmlib/perfhash.pl perllib/phash.ph
	$(RUNPERL) $(srcdir)/nasmlib/perfhash.pl c \
		$(srcdir)/asm/directiv.dat asm/directbl.c

#-- End Generated File Rules --#

perlreq: $(PERLREQ)

# This rule is only used for RDOFF
.$(O)$(X):
	$(CC) $(ALL_CFLAGS) -o $@ $< $(LDFLAGS) $(RDFLIB) $(NASMLIB) $(LIBS)

RDFLN    = cd rdoff && ln -s
RDFLNPFX =

#-- Begin RDOFF Shared Rules --#

RDFLIBOBJ = rdoff/rdoff.$(O) rdoff/rdfload.$(O) rdoff/symtab.$(O) \
	    rdoff/collectn.$(O) rdoff/rdlib.$(O) rdoff/segtab.$(O) \
	    rdoff/hash.$(O)

RDFPROGS = rdoff/rdfdump$(X) rdoff/ldrdf$(X) rdoff/rdx$(X) rdoff/rdflib$(X) \
	   rdoff/rdf2bin$(X)
RDF2BINLINKS = rdoff/rdf2com$(X) rdoff/rdf2ith$(X) \
	    rdoff/rdf2ihx$(X) rdoff/rdf2srec$(X)

RDFLIB = rdoff/librdoff.$(A)
RDFLIBS = $(RDFLIB) $(NASMLIB)

rdoff/rdfdump$(X): rdoff/rdfdump.$(O) $(RDFLIBS)
rdoff/ldrdf$(X): rdoff/ldrdf.$(O) $(RDFLIBS)
rdoff/rdx$(X): rdoff/rdx.$(O) $(RDFLIBS)
rdoff/rdflib$(X): rdoff/rdflib.$(O) $(RDFLIBS)
rdoff/rdf2bin$(X): rdoff/rdf2bin.$(O) $(RDFLIBS)
rdoff/rdf2com$(X): rdoff/rdf2bin$(X)
	$(RM_F) rdoff/rdf2com$(X)
	$(RDFLN) $(RDFLNPFX)rdf2bin$(X) $(RDFLNPFX)rdf2com$(X)
rdoff/rdf2ith$(X): rdoff/rdf2bin$(X)
	$(RM_F) rdoff/rdf2ith$(X)
	$(RDFLN) $(RDFLNPFX)rdf2bin$(X) $(RDFLNPFX)rdf2ith$(X)
rdoff/rdf2ihx$(X): rdoff/rdf2bin$(X)
	$(RM_F) rdoff/rdf2ihx$(X)
	$(RDFLN) $(RDFLNPFX)rdf2bin$(X) $(RDFLNPFX)rdf2ihx$(X)
rdoff/rdf2srec$(X): rdoff/rdf2bin$(X)
	$(RM_F) rdoff/rdf2srec$(X)
	$(RDFLN) $(RDFLNPFX)rdf2bin$(X) $(RDFLNPFX)rdf2srec$(X)

#-- End RDOFF Shared Rules --#

rdf: $(RDFPROGS) $(RDF2BINLINKS)

$(RDFLIB): $(RDFLIBOBJ)
	$(RM_F) $(RDFLIB)
	$(AR) cq $(RDFLIB) $(RDFLIBOBJ)
	$(RANLIB) $(RDFLIB)

#-- Begin NSIS Rules --#

# NSIS is not built except by explicit request, as it only applies to
# Windows platforms
nsis/arch.nsh: nsis/getpearch.pl nasm$(X)
	$(PERL) $(srcdir)/nsis/getpearch.pl nasm$(X) > nsis/arch.nsh

# Should only be done after "make everything".
# The use of redirection here keeps makensis from moving the cwd to the
# source directory.
nsis: nsis/nasm.nsi nsis/arch.nsh nsis/version.nsh
	$(MAKENSIS) -Dsrcdir="$(srcdir)" -Dobjdir="$(objdir)" - < nsis/nasm.nsi

#-- End NSIS Rules --#

# Generated manpages, also pregenerated for distribution
manpages: nasm.1 ndisasm.1

install: nasm$(X) ndisasm$(X)
	$(MKDIR) $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) nasm$(X) $(DESTDIR)$(bindir)/nasm$(X)
	$(INSTALL_PROGRAM) ndisasm$(X) $(DESTDIR)$(bindir)/ndisasm$(X)
	$(MKDIR) $(DESTDIR)$(mandir)/man1
	$(INSTALL_DATA) $(srcdir)/nasm.1 $(DESTDIR)$(mandir)/man1/nasm.1
	$(INSTALL_DATA) $(srcdir)/ndisasm.1 $(DESTDIR)$(mandir)/man1/ndisasm.1

clean:
	for d in . $(SUBDIRS) $(XSUBDIRS); do \
		$(RM_F) "$$d"/*.$(O) "$$d"/*.s "$$d"/*.i "$$d"/*.$(A) ; \
	done
	$(RM_F) nasm$(X) ndisasm$(X)
	$(RM_F) nasm-*-installer-*.exe
	$(RM_F) tags TAGS
	$(RM_F) nsis/arch.nsh
	$(RM_F) perlbreq.si
	$(RM_F) $(RDFPROGS) $(RDF2BINLINKS)

distclean: clean
	$(RM_F) config.log config.status config/config.h
	for d in . $(SUBDIRS) $(XSUBDIRS); do \
		$(RM_F) "$$d"/*~ "$$d"/*.bak "$$d"/*.lst "$$d"/*.bin ; \
	done
	$(RM_F) test/*.$(O)
	$(RM_RF) autom4te*.cache
	$(RM_F) Makefile *.dep

cleaner: clean
	$(RM_F) $(PERLREQ) *.1 nasm.spec
	$(MAKE) -C doc clean
	$(RM_F) *.dep

spotless: distclean cleaner
	$(RM_F) doc/Makefile

strip:
	$(STRIP) --strip-unneeded nasm$(X) ndisasm$(X)

TAGS:
	$(RM_F) TAGS
	$(FIND) . -name '*.[hcS]' -print | xargs etags -a

tags:
	$(RM_F) tags
	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a

cscope:
	$(RM_F) cscope.out cscope.files
	$(FIND) . -name '*.[hcS]' -print > cscope.files
	cscope -b -f cscope.out

rdf_install install_rdf install_rdoff:
	$(MKDIR) $(DESTDIR)$(bindir)
	for f in $(RDFPROGS); do \
		$(INSTALL_PROGRAM) "$$f" '$(DESTDIR)$(bindir)'/ ; \
	done
	cd '$(DESTDIR)$(bindir)' && \
	for f in $(RDF2BINLINKS); do \
		bn=`basename "$$f"` && $(RM_F) "$$bn" && \
		$(LN_S) rdf2bin$(X) "$$bn" ; \
	done
	$(MKDIR) $(DESTDIR)$(mandir)/man1
	$(INSTALL_DATA) $(srcdir)/rdoff/*.1 $(DESTDIR)$(mandir)/man1/

doc:
	$(MAKE) -C doc all

doc_install install_doc:
	$(MAKE) -C doc install

everything: all manpages doc rdf

install_everything: everything install install_doc install_rdf

dist:
	$(MAKE) alldeps
	$(MAKE) spotless perlreq manpages spec
	autoheader
	autoconf
	$(RM_RF) ./autom4te*.cache

tar: dist
	tar -cvj --exclude CVS -C .. -f ../nasm-`cat version`-`date +%Y%m%d`.tar.bz2 `basename \`pwd\``

spec: nasm.spec

ALLPERLSRC := $(shell find $(srcdir) -type f -name '*.p[lh]')

perlbreq.si: $(ALLPERLSRC)
	sed -n -r -e 's/^[[:space:]]*use[[:space:]]+([^[:space:];]+).*$$/BuildRequires: perl(\1)/p' $(ALLPERLSRC) | \
	sed -r -e '/perl\((strict|warnings|Win32.*)\)/d' | \
	sort | uniq > perlbreq.si || ( rm -f perlbreq.si ; false )

nasm.spec: nasm.spec.in nasm.spec.sed version.sed perlbreq.si
	sed -f version.sed -f nasm.spec.sed \
	< nasm.spec.in > nasm.spec || ( rm -f nasm.spec ; false )

splint:
	splint -weak *.c

test: nasm$(X)
	cd test && $(RUNPERL) performtest.pl --nasm=../nasm *.asm

golden: nasm$(X)
	cd test && $(RUNPERL) performtest.pl --golden --nasm=../nasm *.asm

#
# Rules to run autoreconf if necessary
#
configure: configure.ac aclocal.m4
	autoreconf

config.status: configure
	@if [ ! -f config.status ]; then \
		echo "*** ERROR: Need to run configure!" 1>&2 ; \
		exit 1; \
	fi
	sh config.status --recheck

Makefile: config.status Makefile.in doc/Makefile.in
	sh config.status

doc/Makefile: Makefile

config/config.h: config.status

#
# Does this version of this file have external dependencies?  This definition
# will be automatically updated by mkdep.pl as needed.
#
EXTERNAL_DEPENDENCIES = 1

#
# Generate dependency information for this Makefile only.
# If this Makefile has external dependency information, then
# the dependency information will remain external, so it doesn't
# pollute the git logs.
#
Makefile.dep: $(PERLREQ) tools/mkdep.pl config.status
	$(RUNPERL) tools/mkdep.pl -M Makefile.in -- $(DEPDIRS)

dep: Makefile.dep

#
# This build dependencies in *ALL* makefiles, and forces all
# dependencies to be inserted inline.  For that reason, it should only
# be invoked manually or via "make dist".  It should be run before
# creating release archives.
#
alldeps: $(PERLREQ) tools/syncfiles.pl tools/mkdep.pl
	$(RUNPERL) tools/syncfiles.pl Makefile.in Mkfiles/*.mak
	$(RUNPERL) tools/mkdep.pl -i -M Makefile.in Mkfiles/*.mak -- \
		$(DEPDIRS)
	$(RM_F) *.dep
	if [ -f config.status ]; then \
		if [ $(EXTERNAL_DEPENDENCIES) -eq 1 ]; then \
			sh config.status --recheck; \
		fi; \
		sh config.status; \
	fi

# Strip internal dependency information from all Makefiles; this makes
# the output good for git checkin
cleandeps: $(PERLREQ) tools/syncfiles.pl tools/mkdep.pl
	$(RUNPERL) tools/syncfiles.pl Makefile.in Mkfiles/*.mak
	$(RUNPERL) tools/mkdep.pl -e -M Makefile.in Mkfiles/*.mak -- \
		$(DEPDIRS)
	$(RM_F) *.dep
	if [ -f config.status ]; then \
		if [ $(EXTERNAL_DEPENDENCIES) -eq 0 ]; then \
			sh config.status --recheck; \
		fi; \
		sh config.status; \
	fi

#-- Magic hints to mkdep.pl --#
# @object-ending: ".$(O)"
# @path-separator: "/"
# @external: "Makefile.dep"
# @include-command: "-include"
# @selfrule: "1"
#-- Everything below is generated by mkdep.pl - do not edit --#
-include Makefile.dep
