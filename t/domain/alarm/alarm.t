use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::Alarm' }

use ok $class;

my $domain = MockDomain->new;

my $alarm = $class->new(domain => $domain, id => 'a/bb/ccc');

note 'basic behavior';
{
    is $alarm->sensor_id->name, 'a/bb/ccc', 'sensor_id';
    
    ok !$alarm->has_alarm, 'no alarm';
    
    is_deeply $alarm->previous_alarms, [], 'no previous alarms';
    
    dies_ok { $alarm->clear } 'clear dies if not in alarm state';

    dies_ok { $alarm->raise } 'raise dies without message';
}

note 'raising an alarm';
{
    is $alarm->event_publisher->_nr_events, 0, 'no event waiting';
    
    ok !$alarm->has_alarm, 'no alarm before raise';
    $alarm->raise('foo occured');
    ok $alarm->has_alarm, 'alarm after raise';
    
    is_deeply $alarm->previous_alarms, [], 'still no previous alarms';

    is $alarm->event_publisher->_nr_events, 1, 'one event waiting';
}

note 'clearing an alarm';
{
    $alarm->clear;
    
    ok !$alarm->has_alarm, 'alarm is indicated as cleared';
    
    is scalar @{$alarm->previous_alarms}, 1, 'one previous alarm';
    
    is $alarm->event_publisher->_nr_events, 2, 'two events waiting';
}

done_testing;
