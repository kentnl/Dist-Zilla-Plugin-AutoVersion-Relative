package  inc::Dist::Zilla::Plugin::AutoVersion::Relative

# $Id:$
use strict;
use warnings;
use Moose;
use Cwd;
use Data::Dump qw( dump );
my $lib = "";
BEGIN {
  $lib = cwd . "/lib/";
}
use lib "$lib";
use Dist::Zilla::Plugin::AutoVersion::Relative ();

print "Bootstrapping Plugin::AutoVersion::Relative\n";
extends 'Dist::Zilla::Plugin::AutoVersion::Relative';

__PACKAGE__->meta->make_immutable;

1;

