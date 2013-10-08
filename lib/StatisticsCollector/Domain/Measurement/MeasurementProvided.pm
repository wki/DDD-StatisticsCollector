package StatisticsCollector::Domain::Measurement::MeasurementProvided;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use namespace::autoclean;

extends 'DDD::Event';

=head1 NAME

StatisticsCollector::Domain::Measurement::MeasurementProvided - is published
when a MeasureResult has been provided

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_name

holds the sensor's name as a tree-part string delimited with slashes like
C<<< a/b/c >>>

=cut

has sensor_name => (
    is       => 'ro',
    isa      => 'SensorName', # the Moose type
    coerce   => 1,  # will allow a string here
    required => 1,
);

=head2 measurement

=cut

has measurement => (
    is       => 'ro',
    isa      => 'Measurement',
    coerce   => 1,
    required => 1,
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
