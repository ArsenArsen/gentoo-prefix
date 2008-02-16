# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8.12.ebuild,v 1.6 2008/02/14 13:12:49 jer Exp $

EAPI="prefix"

inherit toolchain-funcs multilib

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="nls python"

DEPEND="python? ( dev-lang/python )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--with-default-dict='$(libdir)/cracklib_dict' \
		$(use_enable nls) \
		$(use_with python) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -r "${ED}"/usr/share/cracklib

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${ED}"/usr/$(get_libdir)/*$(get_libname)* "${ED}"/$(get_libdir)/ || die "could not move shared"
	gen_usr_ldscript libcrack$(get_libname)

	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"

	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict "${EPREFIX}"/usr/share/dict/* > /dev/null
		eend $?
	fi
}
