package Dist::Zilla::Plugin::AutoVersion::Relative;

# ABSTRACT: Time-Relative versioning

# $Id:$

=head1 SYNOPSIS

Like all things, time is relative.
This plugin is to allow you to auto-increment versions based on a relative time point.

It doesn't do it all for you, you can choose, its mostly like L<Dist::Zilla::Plugin::AutoVersion>
except there's a few more user-visible entities, and a few more visible options.

=head2 Serving Suggestion

  [AutoVersion::Relative]
  major = 1
  minor = 1
  year  = 2009 ;  when we did our last major rev
  month = 08   ;   "           "
  day   = 23   ;   "           "
  hour  = 05   ;   "           "
  minute = 30  ;   "           "
  second = 00  ;  If you're that picky.

  time_zone = Pacific/Auckland  ;  You really want to set this.

   ; 1.0110012
  format = {{$major}}.{{sprintf('%02d%04d%02d', $minor, days, hours }}

=cut

=head1 WARNING

If you don't specify Y/M/D, it will default to Jan 01, 2000 , because I
couldn't think of a more sane default. But you're setting that anyway, because
if you don't,you be cargo cultin' the bad way

=cut

use strict;
use warnings;
use Moose;
use MooseX::Types::Moose qw( :all );
use MooseX::Types::DateTime::ButMaintained qw( TimeZone Duration Now );
use MooseX::Has::Sugar 0.0300;

with( 'Dist::Zilla::Role::VersionProvider', 'Dist::Zilla::Role::TextTemplate' );

use DateTime ();
use namespace::autoclean;

=head1 ATTRIBUTES

=head2 major

=head2 minor

=head2 format

See L</FORMATING>

=cut

has major => ( isa => Int, ro, default => 1 );
has minor => ( isa => Int, ro, default => 1 );
has format => (
  isa => Str,
  ro, default => q[{{ sprintf('%d.%02d%04d%02d', $major, $minor, days, hours) }}]
);

=head2 DATE ATTRIBUTES

Various Tokens that specify what the relative version is relative to

=head2 year

=head2 month

=head2 day

=head2 minute

=head2 second

=head2 time_zone

You want this.

=cut

has year      => ( isa => Int,      ro, default   => 2000 );
has month     => ( isa => Int,      ro, default   => 1 );
has day       => ( isa => Int,      ro, default   => 1 );
has hour      => ( isa => Int,      ro, default   => 0 );
has minute    => ( isa => Int,      ro, default   => 0 );
has second    => ( isa => Int,      ro, default   => 0 );
has time_zone => ( isa => TimeZone, ro, predicate => 'has_time_zone' );

has '_release_time' => ( isa => 'DateTime', coerce, ro, lazy_build );
has '_current_time' => ( isa => 'DateTime', coerce, ro, lazy_build );
has 'relative'      => ( isa => Duration, coerce, ro, lazy_build );

sub _build__release_time {
  my $self = shift;
  my $o    = DateTime->new(
    year   => $self->year,
    month  => $self->month,
    day    => $self->day,
    hour   => $self->hour,
    minute => $self->minute,
    second => $self->second,
    ( ( $self->has_time_zone ) ? ( time_zone => $self->time_zone ) : () ),
  );
  return $o;
}

sub _build__current_time {
  my $self = shift;
  my $o    = DateTime->now;
  return $o;
}

sub _build_relative {
  my $self = shift;
  my $x    = $self->_current_time->subtract_datetime( $self->_release_time );
  return $x;
}

sub provide_version {
  my ($self) = @_;

  my ( $y, $m, $d, $h, $mm, $s ) = $self->relative->in_units( 'years', 'months', 'days', 'hours', 'minutes', 'seconds' );

  my $version = $self->fill_in_string(
    $self->format,
    {
      major    => \( $self->major ),
      minor    => \( $self->minor ),
      relative => \( $self->relative ),
      cldr     => sub { $self->_current_time->format_cldr( $_[0] ) },
      days     => sub { ( ( ( $y * 12 ) + $m ) * 31 ) + $d },
      hours => sub { $h },
    }
  );
}

=head1 FORMATTING

There are a handful of things we inject into the template for you

  # Just to give you an idea, you don't really want to be using this though.
  {{ $major }}.{{ $minor }}{{ days }}{{ hours }}{{ $relative->seconds }}

=head2 $major

The value set for major

=head2 $minor

The value set for minor

=head2 $relative

A L<DateTime::Duration> object

=head2 cldr($ARG)

CLDR for the current time. See L<DateTime/format_cldr>

=head2 date()

An approximation of the number of days passed since milestone.

Note that for this approximation, it is assumed all months are 31 days long, and years as such,
have 372 days.

This is purely to make sure numbers don't slip backwards, as its currently too hard to work out
the exact number of days passed. Fixes welcome if you want this to respond properly.

=head2 hours()

The remainder number of hours elapsed.

=cut

1;

