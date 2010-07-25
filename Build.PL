
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Dist::Zilla' => '0',
    'Dist::Zilla::Plugin::GatherDir' => '0',
    'Dist::Zilla::Tester' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Test::More' => '0.88'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Time-Relative versioning',
  'dist_author' => [
    'Kent Fredric <kentnl@cpan.org>'
  ],
  'dist_name' => 'Dist-Zilla-Plugin-AutoVersion-Relative',
  'dist_version' => '0.01034313',
  'license' => 'perl',
  'module_name' => 'Dist::Zilla::Plugin::AutoVersion::Relative',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'DateTime' => '0.50',
    'Dist::Zilla' => '2.10131',
    'Moose' => '0.89',
    'MooseX::StrictConstructor' => '0.08',
    'MooseX::Types::DateTime' => '0.05',
    'MooseX::Types::Moose' => '0',
    'Readonly' => '0',
    'Test::More' => '0',
    'namespace::autoclean' => '0.08'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
