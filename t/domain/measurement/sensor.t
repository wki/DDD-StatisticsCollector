use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Domain::Measurement::Sensor' }

use ok $class;

my $domain = MockDomain->new;

my $sensor = $class->new(
    domain             => $domain,
    id                 => 'xxx/yy/z',
    latest_measurement => 100,
);

note 'provide measurement';
on '2012-12-10 23:13:45' => sub {
    is $sensor->event_publisher->_nr_events, 0, 'no events yet';
    
    $sensor->provide_measurement_result(50);
    
    is $sensor->sensor_id->name, 'xxx/yy/z', 'sensor name saved';
    is $sensor->latest_measurement->result, 50, 'measurement result saved';

    is $sensor->event_publisher->_nr_events, 1, 'one event waiting';
};

done_testing;
