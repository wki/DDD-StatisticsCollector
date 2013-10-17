use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Watcher;
use Test::Most;
use Test::MockDateTime;

use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
use aliased 'StatisticsCollector::Domain::Alarm::AllAlarms::Memory'
    => 'AllAlarms';
use aliased 'StatisticsCollector::Domain::Alarm::AllRules::Fixed'
    => 'AllRules';

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AlarmCheck' }

use ok $class;

my $domain        = MockDomain->new;
my $alarm_check   = $class->new(
    domain     => $domain,
    all_alarms => AllAlarms->new(domain => $domain),
    all_rules  => AllRules->new(domain => $domain),
);

# hook a watcher to event processing listening for every event.
my $watcher = Watcher->new;
$alarm_check->event_publisher->add_listener(undef, $watcher, 'catch_event');

note 'basic behavior';
{
    can_ok $alarm_check, 'check_alarm';
    
    isa_ok $alarm_check->alarm_creator,
        'StatisticsCollector::Domain::Alarm::AlarmCreator';
}

note 'save alarm but not raised';
on '2013-10-10 14:00:00' => sub {
    $watcher->clear;
    my $sensor_id = 'a/ab/abc';
    my $measurement = Measurement->new(result => 30);
    
    ok !$alarm_check->all_alarms->for_sensor($sensor_id), "$sensor_id: no alarms saved";
    is $domain->event_publisher->_nr_events, 0, "$sensor_id: no event waiting";
    
    $alarm_check->check_alarm($sensor_id, $measurement);
    
    ok $alarm_check->all_alarms->for_sensor($sensor_id), "$sensor_id: alarm saved";
    is_deeply $watcher->all_caught_event_classes,
        [],
        'no events caught';
};

note 'raising alarm';
on '2013-10-10 14:30:00' => sub {
    $watcher->clear;
    my $sensor_id = 'rio/heizung/temperatur';
    my $measurement = Measurement->new(result => 5); # min is 10, will raise Alarm
    
    ok !$alarm_check->all_alarms->for_sensor($sensor_id), "$sensor_id: no alarms saved";
    
    is_deeply $watcher->all_caught_event_classes,
        [],
        'no events caught';
    
    $alarm_check->check_alarm($sensor_id, $measurement);
    
    ok $alarm_check->all_alarms->for_sensor($sensor_id), "$sensor_id: alarm saved";
    ok $alarm_check->all_alarms->for_sensor($sensor_id)->has_alarm, "$sensor_id: alarm has alarm";

    is_deeply $watcher->all_caught_event_classes,
        ['AlarmRaised'],
        'AlarmRaised event caught';
    
    # same alarm again does not raise another event
    $alarm_check->check_alarm($sensor_id, $measurement);
    is_deeply $watcher->all_caught_event_classes,
        ['AlarmRaised'],
        'AlarmRaised event not caught again';
};

note 'clear alarm';
on '2013-10-10 14:40:00' => sub {
    $watcher->clear;
    my $sensor_id = 'rio/heizung/temperatur';
    my $measurement = Measurement->new(result => 20); # min is 10, will clear Alarm

    $alarm_check->check_alarm($sensor_id, $measurement);
    
    ok !$alarm_check->all_alarms->for_sensor($sensor_id)->has_alarm, "$sensor_id: alarm is cleared";

    is_deeply $watcher->all_caught_event_classes,
        ['AlarmCleared'],
        'AlarmCleared event caught';
};

done_testing;
