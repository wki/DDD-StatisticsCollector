use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;
use Test::MockDateTime;

use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
use aliased 'StatisticsCollector::Domain::Alarm::AllAlarms::Memory'
    => 'AllAlarms';
use aliased 'StatisticsCollector::Domain::Alarm::AllRules::Fixed'
    => 'AllRules';

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AlarmCheck' }

use ok $class;

my $d = MockDomain->new;
my $a = $class->new(
    domain     => $d,
    all_alarms => AllAlarms->new(domain => $d),
    all_rules  => AllRules->new(domain => $d),
);

note 'basic behavior';
{
    can_ok $a, 'check_alarm';
    
    isa_ok $a->alarm_creator,
        'StatisticsCollector::Domain::Alarm::AlarmCreator';
}

note 'save alarm but not raised';
on '2013-10-10 14:00:00' => sub {
    my $sensor_name = 'a/ab/abc';
    my $m = Measurement->new(result => 30);
    
    ok !$a->all_alarms->for_sensor($sensor_name), "$sensor_name: no alarms saved";
    is $d->event_publisher->_nr_events, 0, "$sensor_name: no event waiting";
    
    $a->check_alarm($sensor_name, $m);
    
    ok $a->all_alarms->for_sensor($sensor_name), "$sensor_name: alarm saved";
    is $d->event_publisher->_nr_events, 0, "$sensor_name: no alarm event raised";
};

note 'raising alarm';
on '2013-10-10 14:30:00' => sub {
    my $sensor_name = 'rio/heizung/temperatur';
    my $m = Measurement->new(result => 5); # min is 10, will raise Alarm
    
    ok !$a->all_alarms->for_sensor($sensor_name), "$sensor_name: no alarms saved";
    
    # events not handled right during test
    # is $d->event_publisher->_nr_events, 0, "$sensor_name: no event waiting";
    
    $a->check_alarm($sensor_name, $m);
    
    ok $a->all_alarms->for_sensor($sensor_name), "$sensor_name: alarm saved";
    ok $a->all_alarms->for_sensor($sensor_name)->has_alarm, "$sensor_name: alarm has alarm";

    # events not handled right during test
    # is $d->event_publisher->_nr_events, 1, '$sensor_name: alarm raised event';
    
    # same alarm again does not raise another event
    $a->check_alarm($sensor_name, $m);
    # events not handled right during test
    # is $d->event_publisher->_nr_events, 1, '$sensor_name: no more alarm events raised';
};

note 'clear alarm';
on '2013-10-10 14:40:00' => sub {
    my $sensor_name = 'rio/heizung/temperatur';
    my $m = Measurement->new(result => 20); # min is 10, will clear Alarm

    $a->check_alarm($sensor_name, $m);
    
    ok !$a->all_alarms->for_sensor($sensor_name)->has_alarm, "$sensor_name: alarm is cleared";

    # events not handled right during test
    # is $d->event_publisher->_nr_events, 2, '$sensor_name: alarm cleared event';
};

done_testing;
