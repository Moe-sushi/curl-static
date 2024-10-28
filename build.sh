rm /etc/resolv.conf
echo nameserver 1.1.1.1 > /etc/resolv.conf
echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
apk add wget make clang git xz-dev libintl libbsd-static libsemanage-dev libselinux-utils libselinux-static xz-libs zlib zlib-static libselinux-dev linux-headers libssl3 libbsd libbsd-dev gettext-libs gettext-static gettext-dev gettext python3 build-base openssl-misc openssl-libs-static openssl zlib-dev xz-dev openssl-dev automake libtool bison flex gettext autoconf gettext sqlite sqlite-dev pcre-dev wget texinfo docbook-xsl libxslt docbook2x musl-dev gettext gettext-asprintf gettext-dbg gettext-dev gettext-doc gettext-envsubst gettext-lang gettext-libs gettext-static
apk add upx
mkdir output

# OK
git clone https://github.com/curl/curl
cd curl
autoreconf -fi
./configure LDFLAGS="-static -Wl,--gc-sections -ffunction-sections -fdata-sections" --disable-nss --enable-static --without-shared --with-openssl --with-zlib=/usr/lib --without-libpsl
make -j8 curl_LDFLAGS="-all-static -Wl,--gc-sections -ffunction-sections -fdata-sections"
strip src/curl
upx src/curl
cp src/curl ../output/
cp COPYING ../output/LICENSE-curl
cd ..
cd output
tar -cvf ../$(uname -m).tar .
exit 0
