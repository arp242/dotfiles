# $FreeBSD: src/etc/csh.login,v 1.22.2.1 2011/09/23 00:51:37 kensmith Exp $
#
# System-wide .login file for csh(1).
# Uncomment this to give you the default 4.2 behavior, where disk
# information is shown in K-Blocks
# setenv BLOCKSIZE	K
#
# For the setting of languages and character sets please see
# login.conf(5) and in particular the charset and lang options.
# For full locales list check /usr/share/locale/*
#
# Check system messages
# msgs -q
# Allow terminal messages
# mesg y

if (-X fortune ) then
	fortune -a
endif

