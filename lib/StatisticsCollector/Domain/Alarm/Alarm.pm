package StatisticsCollector::Domain::Alarm::Alarm;
use Carp;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::SensorId';
use aliased 'StatisticsCollector::Domain::Common::AlarmInfo';
use aliased 'StatisticsCollector::Domain::Alarm::AlarmRaised';
use aliased 'StatisticsCollector::Domain::Alarm::AlarmCleared';
use namespace::autoclean;

use constant NR_ALARMS_TO_KEEP => 5;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Alarm::Alarm - a potential alarm information for
a sensor

=head1 SYNOPSIS

    # raise an alarm -- will publish AlarmRaised event
    $alarm->raise('Latest Value too old');
    
    # clear the latest raised alarm
    $alarm->clear;

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_id

=cut

has sensor_id => (
    is         => 'ro',
    isa        => 'SensorId', # the Moose type
    coerce     => 1,
    lazy_build => 1,
);

sub _build_sensor_id { $_[0]->id }

=head2 alarm_info

=cut

has alarm_info => (
    is        => 'ro',
    isa       => 'AlarmInfo', # the Moose type
    coerce    => 1,
    predicate => 'has_alarm',
    writer    => '_set_alarm_info',
    clearer   => '_clear_alarm_info',
);

=head previous_alarms

=cut

has previous_alarms => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef',  # of AlarmInfo
    default => sub { [] },
    handles => {
        _keep_alarm     => 'push',
        _nr_kept_alarms => 'count',
        _remove_alarm   => 'shift',
    },
);

=head1 METHODS

=cut

=head2 raise ( $message )

raise an alarm with a message

=cut

sub raise {
    my ($self, $message) = @_;
    
    croak 'message is mandatory' if !$message;
    
    $self->_set_alarm_info($message);
    
    $self->publish(
        AlarmRaised->new(
            sensor_id => $self->id,
            alarm_info  => $self->alarm_info,
        )
    );
}

=head2 clear

clear an alarm

=cut

sub clear {
    my $self = shift;
    
    croak 'not in alarm state' if !$self->has_alarm;
    
    my $cleared_alarm_info = $self->alarm_info->clear;
    
    $self->_append_to_previous_alarms($cleared_alarm_info);
    
    $self->_clear_alarm_info;
    
    $self->publish(
        AlarmCleared->new(
            sensor_id => $self->id,
            alarm_info  => $cleared_alarm_info,
        )
    );
}

sub _append_to_previous_alarms {
    my ($self, $alarm_info) = @_;
    
    $self->_keep_alarm($alarm_info);
    while ($self->_nr_kept_alarms > NR_ALARMS_TO_KEEP) {
        $self->_remove_alarm;
    }
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
