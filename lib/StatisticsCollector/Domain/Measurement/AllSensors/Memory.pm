package StatisticsCollector::Domain::Measurement::AllSensors::Memory;
use Moose;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Measurement::AllSensors';

our %sensor_for; # sensor_name => sensor aggregate

=head1 NAME

StatisticsCollector::Domain::Measurement::AllSensors::Memory - in-memory
implementation of a sensors repository

=head1 SYNOPSIS

=head1 DESCRIPTION

only valid for a single process

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

=head2 filtered ( $filter )

retrieves a list or hashref containing (TODO: specify filter)

=cut

sub filtered {
    my ($self, $filter) = @_;
    
    my @filtered =
        map { $_->info }
        # grep { ... } # TODO: define filter
        values %sensor_for;
    
    return wantarray ? @filtered : \@filtered;
}

=head2 by_name ( $sensor_name )

retrieves a sensor aggregate by its name

=cut

sub by_name {
    my ($self, $sensor_name) = @_;

    return $sensor_for{$sensor_name};
}

=head2 save ( $sensor )

saves the sensor aggregate back

=cut

sub save {
    my ($self, $sensor) = @_;
    
    my $name = $sensor->info->name;
    $sensor_for{$name} = $sensor;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
