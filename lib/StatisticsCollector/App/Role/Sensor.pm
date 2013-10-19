package StatisticsCollector::App::Role::Sensor;
use Moose::Role;
use aliased 'StatisticsCollector::Domain::Common::SensorId';

with 'MooseX::Getopt::Strict';

=head1 NAME

StatisticsCollector::App::Role::Sensor - blabla

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_id

=cut

has sensor_id => (
    traits        => ['Getopt'],
    is            => 'ro',
    isa           => 'Str', # or Moose Type 'SensorId' ???
    required      => 1,
    cmd_flag      => 'sensor',
    cmd_aliases   => 's',
    documentation => 'name of the sensor to provide a measurement result for (mandatory)',
);

1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
