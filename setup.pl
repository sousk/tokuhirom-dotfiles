#!/usr/bin/perl
use strict;
use warnings;

my @files = qw(
    .zshrc
    .emacs
    .emacs.d
    .gitconfig
    .gitignore
    .inputrc
    .pmsetuprc
    .navi2ch
    .irssi
    .skk-jisyo
    .vimrc
    .screenrc
    .vimperatorrc
    .howm-menu
    .skkinput
    .stumpwmrc
    .xinitrc
    .Xdefaults
    .gtkrc-2.0
    .w3m
    .gdbinit
);

(my $pwd = `pwd`) =~ s/\n//;
for my $foo (@files) {
    my $src = "$pwd/$foo";
    my $dst = "$ENV{HOME}/$foo";
    linkit($src => $dst);
}

linkit("$pwd" => "$ENV{HOME}/share/dotfiles");

sub linkit {
    my ($src, $dst) = @_;

    if (-e $dst) {
        print "# $dst is exists\n";
    } else {
        print "ln -s $src $dst\n";
    }
}

