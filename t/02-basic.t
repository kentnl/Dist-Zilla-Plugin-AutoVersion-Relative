
use strict;
use warnings;

use Test::More tests => 4;                      # last test to print
use Dist::Zilla::Plugin::AutoVersion::Relative;
use Dist::Zilla;
use Dist::Zilla::Tester;

my $config = <<'EOF';
name = Test-DZPAvR
copyright_holder = Kent Fredric
main_module = t/fake/dist.pm
abstract = A Fake Dist
license = Perl_5

[GatherDir]
EOF

use Dist::Zilla::Plugin::GatherDir;

my $dz = Dist::Zilla::Tester->from_config({
  dist_root => 't/fake/' ,
},{  add_files => { 'source/dist.ini' => $config } } );

my $plug = Dist::Zilla::Plugin::AutoVersion::Relative->new(
  zilla => $dz,
  plugin_name => 'AutoVersion::Relative',
);

like $plug->provide_version, qr/^1.01\d{6}$/, "Defaults";

$plug = Dist::Zilla::Plugin::AutoVersion::Relative->new(
  zilla => $dz,
  plugin_name => 'AutoVersion::Relative',
  major => 0,
);

like $plug->provide_version, qr/^0.01\d{6}$/, "Major V";

$plug = Dist::Zilla::Plugin::AutoVersion::Relative->new(
  zilla => $dz,
  plugin_name => 'AutoVersion::Relative',
  major => 0,
  minor => 0,
);

like $plug->provide_version, qr/^0.00\d{6}$/, "Minor V";

use DateTime;

$plug = Dist::Zilla::Plugin::AutoVersion::Relative->new(
  zilla => $dz,
  plugin_name => 'AutoVersion::Relative',
  major => 0,
  minor => 0,
  year  => DateTime->now->year,
);

$plug->provide_version =~ m/^0.00(\d{4})/;
my $y  = $1;
if( $y <= 12 * 31 ){
  ok(1, "Recent ");
}
else {
  ok(0, "Recent");
  diag( 'Version: ' . $plug->provide_version );
  diag( 'Days Passed: ' . $y );
  diag( 'Expected: <= ' . ( 12 * 31 ) );
}


