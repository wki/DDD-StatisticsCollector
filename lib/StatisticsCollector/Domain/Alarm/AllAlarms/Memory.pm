package StatisticsCollector::Domain::Alarm::AllAlarms::Memory;
use Moose;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::AllAlarms';

our %alarm_for; # sensor_id => alarm aggregate

=head1 NAME

StatisticsCollector::Domain::Alarm::AllAlarm::Memory - in-memory
implementation of an alarm repository

=head1 SYNOPSIS

=head1 DESCRIPTION

only valid for a single process

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_id )

load alarm for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_id) = @_;
    
    return $alarm_for{$sensor_id};
}

=head2 save ( $alarm )

save an alarm to memory

=cut

sub save {
    my ($self, $alarm) = @_;
    
    $alarm_for{$alarm->id} = $alarm;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
