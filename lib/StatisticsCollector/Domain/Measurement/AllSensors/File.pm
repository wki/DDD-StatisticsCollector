package StatisticsCollector::Domain::Measurement::AllSensors::File;
use Moose;
use MooseX::Types::Path::Class 'Dir';
use aliased 'StatisticsCollector::Domain::Measurement::Sensor';
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Measurement::AllSensors';
with 'StatisticsCollector::Domain::Role::FileStorage';

=head1 NAME

StatisticsCollector::Domain::Measurement::AllSensors::File - file
implementation of a sensors repository

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head1 METHODS

=cut

sub _build_file_suffix { '' }

=head2 filtered ( $filter )

returns a list of L<SensorInfo> objects matched by a given filter.

=cut

sub filtered {
    my ($self, $filter) = @_;
    
    # TODO
    my @filtered;
    
    return wantarray ? @filtered : \@filtered;
}

=head2 by_name ( $sensor_id )

give back a senor uniquely identified by a given name. If no sensor can be
found with the requested name, C<undef> is returned

=cut

sub by_name {
    my ($self, $sensor_id) = @_;

    return Sensor->load($self->_file($sensor_id)->stringify);
}

=head2 save ( $sensor )

writes a sensor to its storage

=cut

sub save {
    my ($self, $sensor) = @_;
    
    $sensor->store($self->_file($sensor->id)->stringify);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
