# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="http://dev/null/${P/_pre/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="truetype"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	truetype? ( x11-libs/libXft )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RESTRICT="fetch"

S="${WORKDIR}/${P/_pre*}"

pkg_nofetch() {
	echo
	ewarn "内部测试版本!"
	ewarn "请自己下载相关源码包，放置在${DISTDIR}"
	ewarn "并更名为${P/-pre/-}.tar.bz2谢谢! ;-)"
	ewarn ";-) 如有任何问题，请咨询 Yuking!别找我来着^.^"
	echo
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Quick and dirty hack, ensure we never install
	# the empty /usr/share/fcitx/xpm dir.
	sed -i -e 's:xpm[[:space:]]::g' Makefile.am
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautomake
}

src_compile() {
	econf $(use_enable truetype xft)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO

	rm -rf "${D}"/usr/share/fcitx/doc/
	dodoc doc/pinyin.txt doc/cjkvinput.txt
	dohtml doc/wb_fh.htm
}

pkg_postinst() {
	echo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog ""
	elog "If you want to use WuBi or ErBi"
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	echo
}
