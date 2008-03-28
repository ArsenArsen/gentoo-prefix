# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.2.0.ebuild,v 1.7 2008/03/27 21:59:52 maekke Exp $

EAPI="prefix 1"

inherit autotools eutils

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.vorbis.com"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="flac nls +ogg123 speex"

RDEPEND=">=media-libs/libvorbis-1.1
	flac? ( media-libs/flac )
	ogg123? ( media-libs/libao net-misc/curl )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-with-args.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf --docdir=/usr/share/doc/${PF} --enable-vcut \
		$(use_enable nls) $(use_enable ogg123) \
		$(use_with flac) $(use_with speex)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CHANGES README
	prepalldocs
}
