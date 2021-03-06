# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

HOMEPAGE="http://txtreader4linux.googlecode.com"

inherit qt4-r2

DESCRIPTION="Txt Reader for linux（小说阅读器 for linux）,and it supports
windows too."

SRC_URI="http://txtreader4linux.googlecode.com/files/${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-core
x11-libs/qt-gui"
RDEPEND="${DEPEND}"


src_install(){
	dodir /usr/bin
	install ${PN} ${D}/usr/bin
}
