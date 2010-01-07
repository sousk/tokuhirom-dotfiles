#!/bin/bash
# based on jjore's works
#   http://use.perl.org/~jjore/journal/40057

set -x
set -e

export LC_ALL=C
SRCDIR=$HOME/src/perl/
PREFIX=/usr/local/multiperl/

if [ ! -d $SRCDIR ]; then
    echo "please checkout perl code first"
    echo "  git clone git://perl5.git.perl.org/perl.git $SRCDIR"
    exit 1
fi

function build-it () {
  bversion=$1
  shift 1
  
  dir=$PREFIX/$bversion
  
  if [[ ! -d $dir ]]; then
    echo "Clobbering $dir"
  
    rm -rf $dir
    mkdir $dir
  
    cd $SRCDIR
    echo "Configure "$(date) > $dir/stamp.log
    ./Configure -des -Dcc='ccache gcc' -Dprefix=$dir $* 2>&1 | tee $dir/config.log
    echo "make "$(date) >> $dir/stamp.log
    make 2>&1 | tee $dir/make.log
    # echo "make test "$(date) >> $dir/stamp.log
    # make test 2>&1 | tee $dir/test.log
    echo "make install "$(date) >> $dir/stamp.log
    make install 2>&1 | tee $dir/install.log
    echo "End "$(date) >> $dir/stamp.log
  
    cd $SRCDIR
    git clean -xdf
    git reset --hard
  fi
}

function build-version () {
  tag=$1
  shift 1

  cd $SRCDIR
  git clean -xdf
  git reset --hard
  git checkout $tag
  build-it $tag-64-dbg      -DDEBUGGING -Duse64bitint
  build-it $tag-thr-dbg     -DDEBUGGING -Dusethreads
  build-it $tag-64-thr-dbg  -DDEBUGGING -Duse64bitint -Dusethreads
  build-it $tag-dbg         -DDEBUGGING
  build-it $tag             -DDEBUGGING=-g
}

echo "BUILDING $1"
build-version $1

