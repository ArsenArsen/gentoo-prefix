# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.2.0.ebuild,v 1.8 2007/10/14 15:48:05 corsair Exp $

EAPI="prefix"

inherit eutils

IPV6_P="ncftp-320-v6-20061109b"
DESCRIPTION="An extremely configurable ftp client"
HOMEPAGE="http://www.ncftp.com/"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2
	ipv6? ( ftp://ftp.kame.net/pub/kame/misc/${IPV6_P}.diff.gz )"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc-macos ~sparc-solaris ~x86 ~x86-macos"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use ipv6 && epatch "${DISTDIR}"/${IPV6_P}.diff.gz
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e 's:@SFLAG@::' \
		-e 's:@STRIP@:true:' \
		Makefile.in */Makefile.in || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README.txt doc/*.txt
	dohtml doc/html/*.html
}
