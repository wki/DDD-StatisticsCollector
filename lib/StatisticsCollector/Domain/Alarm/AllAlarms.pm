package StatisticsCollector::Domain::Alarm::AllAlarms;
use Moose;
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Alarm::AllAlarms - a repository base class
for retrieving and saving Alarms

=head1 SYNOPSIS

    # assume that $all_alarms is an instance of AllAlarms
    
    # get alarm for a single sensor
    my $alarm = $all_alarms->for_sensor('x/y/z');
    
    # write back alarm
    $all_alarms->save($alarm);

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_name )

load alarm for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_name) = @_;
    
    die 'abstract class';
}

=head2 save ( $summaries )

save an alarm

=cut

sub save {
    my ($self, $alarm) = @_;
    
    die 'abstract class';
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
