package StatisticsCollector::Domain::Alarm::Alarm;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::AlarmInfo';
use namespace::autoclean;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Alarm::Alarm - a potential alarm information for
a sensor

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_name

=cut

has sensor_name => (
    is         => 'ro',
    isa        => 'SensorName', # the Moose class
    coerce     => 1,
    lazy_build => 1,
);

sub _build_sensor_name { $_[0]->id }

=head2 alarm_info

=cut

has alarm_info => (
    is => 'ro',
    isa => AlarmInfo, # the class
    predicate => 'has_alarm_info',
    # clearer => 'clear_alarm_info',
);

=head1 METHODS

=cut

=head2 raise ( $message )

raise an alarm with a message

=cut

sub raise {
    my ($self, $message) = @_;
    
    # ...
}

=head2 clear

clear an alarm

=cut

sub clear {
    my $self = shift;
    
    # ...
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
