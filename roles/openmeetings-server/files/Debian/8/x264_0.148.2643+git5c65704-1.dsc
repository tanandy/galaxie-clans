-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Format: 3.0 (quilt)
Source: x264
Binary: x264, libx264-148, libx264-dev
Architecture: any
Version: 2:0.148.2643+git5c65704-1
Maintainer: Debian Multimedia Maintainers <pkg-multimedia-maintainers@lists.alioth.debian.org>
Uploaders:  Reinhard Tartler <siretart@tauware.de>, Fabian Greffrath <fabian+debian@greffrath.com>, Rico Tzschichholz <ricotz@ubuntu.com>
Homepage: http://www.videolan.org/developers/x264.html
Standards-Version: 3.9.6
Vcs-Browser: http://anonscm.debian.org/gitweb/?p=pkg-multimedia/x264.git
Vcs-Git: git://anonscm.debian.org/pkg-multimedia/x264.git
Testsuite: autopkgtest
Build-Depends: debhelper (>= 9.20141010), autotools-dev, dpkg-dev (>= 1.17.14), libavformat-dev (>= 6:9) <!stage1>, libffms2-dev <!stage1>, libgpac-dev (>= 0.5.0+svn4288~) <!stage1>, yasm [any-i386 any-amd64]
Package-List:
 libx264-148 deb libs optional arch=any
 libx264-dev deb libdevel optional arch=any
 x264 deb graphics optional arch=any profile=!stage1
Checksums-Sha1:
 25736c133a486a08138e7fb0a2554acd4e051aa3 884605 x264_0.148.2643+git5c65704.orig.tar.gz
 ca744d319458b24be871b35ae0f9b8599928ace1 22548 x264_0.148.2643+git5c65704-1.debian.tar.xz
Checksums-Sha256:
 a2dfed165837bf901652a8f13f06ff2e2bba72fb729dee0faaafb791efa4f319 884605 x264_0.148.2643+git5c65704.orig.tar.gz
 9d1ee42fc46701d3613bb4eb12162e20e390d6719183bb93754c06d53a6a022b 22548 x264_0.148.2643+git5c65704-1.debian.tar.xz
Files:
 0e3d43f35f6662b30b19f9d6cac9242d 884605 x264_0.148.2643+git5c65704.orig.tar.gz
 5789fd02127db47e5d9e42159e3c120a 22548 x264_0.148.2643+git5c65704-1.debian.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJWnSceAAoJEGny/FFupxmTmb0P/RB6kqxOFLyyF8ufG/rGmsA9
l1Z51o6ltyrX9VNRCL+dTmCRo4GzFnKvQ9eyhBOcIzMfSvXe21FE1XuI0jkVYIAU
PnHjUR6L/OVW/Li8ARo/E2KbfsPw1NYKj37ukr/d90nLh3I9snppowvuRB59MyQW
Bq5Vzwv+SfVUbFVYyrUjG5nS1c5U61CVkcHYh15uLcZOsTEwe3UUIqiv86oYafce
/+4OkbBdG3tIMFutQiCDF+aXzzM1hVlgEdjjCHQ2GyADlsvnVZJCI7hDCAk+y5C8
ISkjK7VP9m71WbaociASq298lfA6wst1GCb2/kW7HsKhFHyZZHDqnnC0Wnq0L1H1
MEARNJybHvCG8eAF1fRTdBEYPDKCa/mZhlZmAbHb+BTxJSzRfSfTpECdRiOtrC78
nmV7fhT5zD6z80l2dd7iX6426t6aEqEZANGC2U17XYTFlcV/ftZopSuWrKK9CW3F
GDPj/1F8zDI5eCR/9/TYfCIc6P55uMb4h2wz9+hIf0sGTza/Ix0KN/JE7JPDtlgu
qU5RdcWQj5ECebZl51UzD4t0mlsajY9aTpaOOrwoRmOxnMhdVdpOOxmTuYZOTNZi
ovykWNLUH/zMwoZIsfu1kwuE7ZuPDsy/N7/N+ouQReOOZc36RkuOInDmYEZ/BT9P
pG7B1GMfnupyDeu0ZLhV
=ICfa
-----END PGP SIGNATURE-----
