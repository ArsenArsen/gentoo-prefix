# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes/xfce4-notes-1.6.1.ebuild,v 1.9 2008/11/04 01:00:26 vapier Exp $

EAPI="prefix"

inherit xfce44

DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~x86-freebsd ~amd64-linux ~x86-linux"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44
xfce44_goodies_panel_plugin
