package StatisticsCollector::Domain::Measurement::Sensor;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
use aliased 'StatisticsCollector::Domain::Common::AlarmInfo';
use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Common::SensorName';

use namespace::autoclean;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Measurement::Sensor - Aggregate root representing
a sensor

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_name

holds the sensor's name as a tree-part string delimited with slashes like
C<<< a/b/c >>>

=cut

has sensor_name => (
    is         => 'ro',
    isa        => 'SensorName', # the Moose type
    coerce     => 1,  # will allow a string here
    lazy_build => 1,
);

sub _build_sensor_name { $_[0]->id }

=head2 latest_measurement

stores the latest measurement provided by the sensor.

=cut

has latest_measurement => (
    is     => 'rw',
    isa    => 'Measurement', # the Moose type
    coerce => 1,    # will allow an int here
    writer => '_set_latest_measurement',
);

=head2 alarm_info

may hold info about an alarm raised some time ago.

=cut

has alarm_info => (
    is        => 'rw',
    isa       => 'AlarmInfo', # the Moose type
    predicate => 'has_alarm_info',
    clearer   => '_clear_alarm_info',
    writer    => '_set_alarm_info',
);

=head1 METHODS

=cut

=head2 provide_measurement_result ( $result_or_value )

save the result provided by a sensor. $result may be either an integer value
or a Measurement object.

=cut

sub provide_measurement_result {
    my ( $self, $result_or_value ) = @_;

    $self->_set_latest_measurement($result_or_value);
    $self->publish(
        MeasurementProvided->new(
            sensor_name => $self->id,
            measurement => $self->latest_measurement
        )
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
