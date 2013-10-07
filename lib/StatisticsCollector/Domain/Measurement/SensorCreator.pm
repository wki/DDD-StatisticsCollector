package StatisticsCollector::Domain::Measurement::SensorCreator;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::Sensor';
use namespace::autoclean;

extends 'DDD::Factory';

=head1 NAME

StatisticsCollector::Domain::Measurement::SensorCreator - a sensor factory

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 new_sensor ( $sensor_name )

create a new sensor with a name

=cut

sub new_sensor {
    my ($self, $sensor_name) = @_;
    
    return Sensor->new(
        sensor_name => $sensor_name
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
