package StatisticsCollector::Domain::Alarm::AlarmCheck;
use DDD::Service;
use aliased 'StatisticsCollector::Domain::Alarm::AllRules';
use aliased 'StatisticsCollector::Domain::Alarm::AllAlarms';
use aliased 'StatisticsCollector::Domain::Alarm::AlarmCreator';

=head1 NAME

StatisticsCollector::Domain::Alarm::AlarmCheck - check alarm service

=head1 SYNOPSIS

=head1 DESCRIPTION

TODO: write something

=head1 ATTRIBUTES

=cut

=head2 all_alarms

the alarm repository

=cut

has all_alarms => (
    is       => 'ro',
    isa      => AllAlarms,
    required => 1,
);

=head2 all_rules

the rule repository

=cut

has all_rules => (
    is       => 'ro',
    isa      => AllRules,
    required => 1,
);

=head2 alarm_creator

the alarm factory

=cut

has alarm_creator => (
    is         => 'ro',
    isa        => AlarmCreator,
    lazy_build => 1,
);

sub _build_alarm_creator {
    my $self = shift;
    
    AlarmCreator->new(
        domain => $self->domain,
    );
}

=head1 EVENTS

=cut

=head2 MeasurementProvided

the alarmcheck service listens to MeasurementProvided and checks the latest
measurement reported by this event for validity against all known rules
matching to the sensor.

=cut

on MeasurementProvided => sub {
    my ($self, $event) = @_;

    $self->check_alarm(
        $event->sensor_name->name,
        $event->measurement
    );
};

=head1 METHODS

=cut

=head2 check_alarm ( $sensor_name, $measurement )

check the measurement reported by a given sensor against all matching rules.
Raise an alarm if the measurement is not satisfied by the rule found or clear
a previously raised alarm if the rule is satisfied again.

=cut

sub check_alarm {
    my ($self, $sensor_name, $measurement) = @_;
    
    my $alarm = $self->all_alarms->for_sensor($sensor_name)
        // $self->alarm_creator->new_alarm($sensor_name);
    
    my $rule = $self->all_rules->for_sensor($sensor_name);
    
    if (!$rule) {
        warn "no rule found for sensor '$sensor_name', omitting is_satisfied test";
        return;
    }
    
    my ($is_satisfied, $condition_name) = $rule->is_satisfied($measurement);
    
    if ($alarm->has_alarm) {
        $alarm->clear if $is_satisfied;
    } else {
        $alarm->raise($condition_name) if !$is_satisfied;
    }
    
    $self->all_alarms->save($alarm);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
