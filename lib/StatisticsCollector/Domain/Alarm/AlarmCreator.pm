package StatisticsCollector::Domain::Alarm::AlarmCreator;
use Moose;
use aliased 'StatisticsCollector::Domain::Alarm::Alarm';
use namespace::autoclean;

extends 'DDD::Factory';

=head1 NAME

StatisticsCollector::Domain::Alarm::AlarmCreator - an alarm factory

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 new_alarm ( $sensor_name )

create a new alarm for a sensor

=cut

sub new_alarm {
    my ($self, $sensor_name) = @_;
    
    return Alarm->new(
        id          => $sensor_name,
        sensor_name => $sensor_name,
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
