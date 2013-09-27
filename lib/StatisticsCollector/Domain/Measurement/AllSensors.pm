package StatisticsCollector::Domain::Measurement::AllSensors;
use Moose;
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Measurement::AllSensors - abstract base class
representing the sensors repository

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

=head2 sensor_info ( $filter )

=cut

sub sensor_info {
    my ($self, $filter) = @_;
    
    die 'abstract class';
    
    # must return SensorInfo[]
}

=head2 sensor_by_name ( $sensor_name )

=cut

sub sensor_by_name {
    my ($self, $sensor_name) = @_;

    die 'abstract class';

    # must return Sensor aggregate
}

=head2 save ( $sensor )

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
