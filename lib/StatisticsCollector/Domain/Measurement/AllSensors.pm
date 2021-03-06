package StatisticsCollector::Domain::Measurement::AllSensors;
use Moose;
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Measurement::AllSensors - abstract base class
representing the sensors repository

=head1 SYNOPSIS

    # assume that $all_sensors is an instance of a AllSensors class
    
    # get a filtered list of SensorInfo objects
    my @sensor_infos = $all_sensors->filtered($filter);
    
    # retrieve a single sensor aggregate
    my $sensor = $all_sensors->by_name('rio/bathroom/temperature');
    
    # save back a sensor aggregate
    $all_sensors->save($sensor);

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

=head2 filtered ( $filter )

returns a list of L<SensorInfo> objects matched by a given filter.

TODO: filter is still to be defined.

=cut

sub filtered {
    my ($self, $filter) = @_;
    
    die 'abstract class';
    
    # must return SensorInfo[]
}

=head2 by_name ( $sensor_id )

give back a senor uniquely identified by a given name. If no sensor can be
found with the requested name, C<undef> is returned

=cut

sub by_name {
    my ($self, $sensor_id) = @_;

    die 'abstract class';

    # must return Sensor aggregate
}

=head2 save ( $sensor )

writes a sensor to its storage

=cut

sub save {
    my ($self, $sensor) = @_;
    
    die 'abstract class';

    # must save sensor
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
