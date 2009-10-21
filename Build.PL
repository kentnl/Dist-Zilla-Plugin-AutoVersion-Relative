
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name   => 'Dist::Zilla::Plugin::AutoVersion::Relative',
  license       => 'perl',
  dist_abstract => "Time\-Relative\ versioning",
  dist_name     => "Dist\-Zilla\-Plugin\-AutoVersion\-Relative",
  dist_author   => [
"Kent\ Fredric\ \<kentnl\@cpan\.org\>",
  ],
  requires      => {
    "MooseX::Has::Sugar" => '0.0404',
    "MooseX::Types::Moose" => '0',
    "DateTime" => '0.50',
    "namespace::autoclean" => '0.08',
    "MooseX::Types::DateTime::ButMaintained" => '0.08',
    "Test::More" => '0',
    "MooseX::StrictConstructor" => '0.08',
    "Dist::Zilla" => '1.092310',
    "Moose" => '0.89',
  },
  script_files => [ qw() ],
);

$build->create_build_script;
