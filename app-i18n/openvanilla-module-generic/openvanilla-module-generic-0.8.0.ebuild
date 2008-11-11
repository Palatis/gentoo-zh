# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion
DESCRIPTION="OpenVanilla Module for Generic Table"

HOMEPAGE="http://openvanilla.org/"
SRC_URI=""
ESVN_REPO_URI="http://openvanilla.googlecode.com/svn/trunk/Modules"
LICENSE="bsd"
SLOT="0"
KEYWORDS="~x86"
DEPEND="app-i18n/openvanilla-framework"
RDEPEND="${DEPEND}"

src_unpack() {

	local repo_uri=${ESVN_REPO_URI}

	subversion_fetch ${repo_uri}/OVIMGeneric
	subversion_fetch ${repo_uri}/Mk ../Mk
	subversion_fetch ${repo_uri}/SharedHeaders ../SharedHeaders
	subversion_fetch ${repo_uri}/SharedSource ../SharedSource
	cd "${S}"
	mkdir ../SharedHeaders/OpenVanilla
	wget --continue --directory-prefix=../SharedHeaders/OpenVanilla	${repo_uri}/../Framework/Headers/OpenVanilla.h 
	wget --continue --directory-prefix=../SharedHeaders/OpenVanilla	${repo_uri}/../Framework/Headers/OVLibrary.h
	wget --continue --directory-prefix=../SharedHeaders/OpenVanilla	${repo_uri}/../Framework/Headers/OVUtility.h

	mkdir ../SharedData/
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/cj.cin
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/dayi3.cin
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/ehq-symbols.cin
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/pinyin.cin
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/simplex.cin
	wget --continue --directory-prefix=../SharedData ${repo_uri}/SharedData/wubizixing.cin
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX="${D}/usr" INSTALL_LIBPREFIX="lib" install 
}