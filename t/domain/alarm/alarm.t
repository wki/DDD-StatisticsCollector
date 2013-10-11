use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;
# use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::Alarm' }

use ok $class;

my $d = MockDomain->new;

my $a = $class->new(domain => $d, id => 'a/bb/ccc');

note 'basic behavior';
{
    is $a->sensor_name->name, 'a/bb/ccc', 'sensor_name';
    
    ok !$a->has_alarm, 'no alarm';
    
    is_deeply $a->previous_alarms, [], 'no previous alarms';
    
    dies_ok { $a->clear } 'clear dies if not in alarm state';

    dies_ok { $a->raise } 'raise dies without message';
}

note 'raising an alarm';
{
    is $a->event_publisher->_nr_events, 0, 'no event waiting';
    
    ok !$a->has_alarm, 'no alarm before raise';
    $a->raise('foo occured');
    ok $a->has_alarm, 'alarm after raise';
    
    is_deeply $a->previous_alarms, [], 'still no previous alarms';

    is $a->event_publisher->_nr_events, 1, 'one event waiting';
}

note 'clearing an alarm';
{
    $a->clear;
    
    ok !$a->has_alarm, 'alarm is indicated as cleared';
    
    is scalar @{$a->previous_alarms}, 1, 'one previous alarm';
    
    is $a->event_publisher->_nr_events, 2, 'two events waiting';
}

done_testing;
