#!/usr/bin/perl

use strict;
use warnings;

my @regexps = (
  qr/linux/i, qr/debian/i, qr/ubuntu/i, qr/\bredhat\b/i, qr/\bRHEL\b/, qr/\bSUSE\b/, qr/\bCentOS\b/, qr/\bopensuse\b/i,
  qr/\bslackware\b/i, qr/\bKDE\b/, qr/\bGTK\d?\b/, qr/#GNOME\b/, qr/\bGNOME\s?\d+/, qr/\bkde plasma\b/i,
  qr/apt-get/, qr/\bflatpak\b/i, qr/\b[Xx]org\b/
);

open my $fh, '<', 'posts.txt';
my @posts = <$fh>;
close $fh;

my $loops = $ARGV[0] || die "Please provide the number of loops as argument\n";
my $matched = 0;

for (my $i = 0; $i < $loops; $i++) {
  foreach my $txt (@posts) {
    foreach my $r (@regexps) {
      if ($txt =~ $r) {
        $matched++;
      }
    }
  }
}

print $matched / $loops;
