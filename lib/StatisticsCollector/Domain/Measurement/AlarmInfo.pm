package StatisticsCollector::Domain::Measurement::AlarmInfo;
use Moose;
use DateTime;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Measurement::AlarmInfo - contains information
about a possible alarm

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 raised_on

=cut

has raised_on => (
    is      => 'ro',
    isa     => 'DateTime',
    default => sub { DateTime->now( time_zone => 'local' ) },
);

=head2 name

=cut

has name => (
    is        => 'ro',
    isa       => 'Str',
    predicate => 'has_alarm',
);

=head1 METHODS

=cut

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
