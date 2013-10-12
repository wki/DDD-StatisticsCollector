package StatisticsCollector::Domain::Notification::MessageComposer;
use DDD::Service;

=head1 NAME

StatisticsCollector::Domain::Notification::MessageComposer - blabla

=head1 SYNOPSIS

    # TODO: add example

=head1 DESCRIPTION

TODO: write something

=head1 ATTRIBUTES

=cut

has notifier => (
    is       => 'ro',
    isa      => 'Object',
    required => 1,
    handles  => {
        _notify => 'notify',
    },
);

=head1 EVENTS

=cut

=head2 AlarmRaised

=cut

on AlarmRaised => sub {
    my ($self, $event) = @_;

    $self->notify_alarm_raised_message(
        $event->sensor_id,
        $event->alarm_info,
    );
};

=head2 AlarmCleared

=cut

on AlarmCleared => sub {
    my ($self, $event) = @_;

    $self->notify_alarm_cleared_message(
        $event->sensor_id,
        $event->alarm_info,
    );
};

=head1 METHODS

=cut

=head2 notify_alarm_raised_message ( $sensor_id, $alarm_info )

=cut

sub notify_alarm_raised_message {
    my ($self, $sensor_id, $alarm_info) = @_;
    
    $self->_notify(
        "Sensor '${\$sensor_id->name}' " .
        "raised alarm '${\$alarm_info->message}'"
    );
}

=head2 notify_alarm_cleared_message ( $sensor_id, $alarm_info )

=cut

sub notify_alarm_cleared_message {
    my ($self, $sensor_id, $alarm_info) = @_;
    
    $self->_notify(
        "Sensor '${\$sensor_id->name}' " .
        "cleared alarm '${\$alarm_info->message}' " .
        "raised on ${\$alarm_info->ymd} ${\$alarm_info->hms}"
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
