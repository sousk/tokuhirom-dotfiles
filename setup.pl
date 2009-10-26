#!/usr/bin/perl
use strict;
use warnings;

my @files = qw(
    .Xdefaults
    .emacs
    .emacs.d
    .gdbinit
    .gitconfig
    .gitignore
    .gtkrc-2.0
    .inputrc
    .perltidyrc
    .screenrc
    .skkinput
    .stumpwmrc
    .vim
    .vimperatorrc
    .vimrc
    .Xmodmap
    .xsession
    .xinitrc
    .zshrc
);

&main;exit;

sub main {
    (my $pwd = `pwd`) =~ s/\n//;
    for my $foo (@files) {
        my $src = "$pwd/$foo";
        my $dst = "$ENV{HOME}/$foo";
        linkit($src => $dst);
    }
}

sub linkit {
    my ($src, $dst) = @_;

    if (-e $dst) {
        print "# $dst is exists\n";
    } else {
        print "ln -s $src $dst\n";
    }
}

