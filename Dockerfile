FROM ubuntu:20.04

ENV R_VERSION=${R_VERSION:-4.0.4}

RUN apt-get update

RUN apt-get install -y --no-install-recommends locales \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

RUN apt-get install -y --no-install-recommends \ 
	curl \
	default-jdk \
	file \
	fonts-texgyre \
	g++ \
	gfortran \
	git \
	gsfonts \
	less \
	libbz2-dev \
	libblas-dev \
	libcairo2-dev \
	libcurl4-openssl-dev \
	libjpeg-turbo8-dev \
	libopenblas-dev \
	libpango1.0-dev \
	libpcre2-dev \
	libpng-dev \
	libreadline-dev \
	libssl-dev \
	libtiff5-dev \
	liblzma-dev \
	libx11-dev \
	libxml2-dev \
	libxt-dev \
	make \
	pcre2-utils \
	perl \
	texinfo \
	texlive-extra-utils \
	texlive-fonts-recommended \
	texlive-fonts-extra \
	texlive-latex-recommended \
	unzip \
	x11proto-core-dev \
	xauth \
	xfonts-base \
	xvfb \
	zlib1g-dev

# install R
RUN cd tmp/ \
	# Download source code
	&& curl -O https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz \
	# Extract source code
	&& tar -xf R-${R_VERSION}.tar.gz \
	&& cd R-${R_VERSION} \
	# Set compiler flags
	&& R_PAPERSIZE=letter \
	R_BATCHSAVE="--no-save --no-restore" \
	R_BROWSER=xdg-open \
	PAGER=/usr/bin/pager \
	PERL=/usr/bin/perl \
	R_UNZIPCMD=/usr/bin/unzip \
	R_ZIPCMD=/usr/bin/zip \
	R_PRINTCMD=/usr/bin/lpr \
	LIBnn=lib \
	AWK=/usr/bin/awk \
	CFLAGS="-g -O2 -fstack-protector-strong -Wformat \
		-Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
	CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat \ 
		-Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
	# Configure options
	./configure --enable-R-shlib \
	       --enable-memory-profiling \
	       --with-readline \
	       --with-blas \
	       --with-tcltk \
	       --disable-nls \
	       --with-recommended-packages \
	# Build and install
	&& make \
	&& make install

