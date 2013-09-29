package StatisticsCollector::Domain::Measurement::SensorInfo;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::Measurement';
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
    isa      => 'Measurement',
    coerce   => 1,
    required => 1,
);

has alarm_info => (
    is        => 'ro',
    isa       => AlarmInfo,
    predicate => 'has_alarm_info',
);

=head1 METHODS

=cut

=head2 new_measurement ( $result_or_value )

factory method returning a new SensorInfo object with a new measurement result

=cut

sub new_measurement {
    my ($self, $result_or_value) = @_;
    
    my $measurement = Measurement->new(result => $result_or_value);
    
    return __PACKAGE__->new(
        sensor             => $self->sensor,
        measurement => $measurement,
        ($self->has_alarm_info
            ? (alarm_info  =>  $self->alarm_info)
            : ()),
    );
}

### can we have "with_alarm($message)" / without_alarm() factory methods here?

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
