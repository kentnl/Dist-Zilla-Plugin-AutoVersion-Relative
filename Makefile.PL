
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-AutoVersion-Relative',
  NAME      => 'Dist::Zilla::Plugin::AutoVersion::Relative',
  AUTHOR    => 'Kent\ Fredric\ \<kentnl\@cpan\.org\>',
  ABSTRACT  => 'Time\-Relative\ versioning',
  VERSION   => '0.01000119',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "DateTime" => '0.50',
    "MooseX::Types::Moose" => '0',
    "MooseX::Has::Sugar" => '0.0404',
    "namespace::autoclean" => '0.08',
    "MooseX::Types::DateTime::ButMaintained" => '0.08',
    "Test::More" => '0',
    "Dist::Zilla" => '1.092310',
    "Moose" => '0.89',
  },
);
