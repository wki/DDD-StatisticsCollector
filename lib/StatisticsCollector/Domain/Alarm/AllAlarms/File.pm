package StatisticsCollector::Domain::Alarm::AllAlarms::File;
use Moose;
use aliased 'StatisticsCollector::Domain::Alarm::Alarm';
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::AllAlarms';
with 'StatisticsCollector::Domain::Role::FileStorage';

=head1 NAME

StatisticsCollector::Domain::Alarm::AllAlarm::Memory - a file based storage
of an alarm repository

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

sub _build_file_suffix { 'alarm' }

=head2 for_sensor ( $sensor_name )

load alarm for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_name) = @_;
    
    return Alarm->load($self->_file($sensor_name)->stringify);
}

=head2 save ( $alarm )

save an alarm to to a file

=cut

sub save {
    my ($self, $alarm) = @_;
    
    $alarm->store($self->_file($alarm->id)->stringify);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
