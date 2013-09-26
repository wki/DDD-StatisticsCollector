package StatisticsCollector::Domain::Measurement::SensorInfo;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::MeasurementResult';
use aliased 'StatisticsCollector::Domain::Measurement::AlarmInfo';
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Measurement::SensorInfo - contains name, latest
measure result and an alarm info of a sensor

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

has sensor => (
    is       => 'ro',
    isa      => 'SensorName',
    coerce   => 1,
    required => 1,
);

has measurement => (
    is       => 'ro',
    isa      => 'MeasurementResult',
    coerce   => 1,
    required => 1,
);

has alarm_info => (
    is      => 'ro',
    isa     => AlarmInfo,
    default => sub { AlarmInfo->new },
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
