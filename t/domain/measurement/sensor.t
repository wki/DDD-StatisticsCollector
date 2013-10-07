use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::MockDateTime;

{
    package D;              # Mock Domain
    use Moose;
    
    extends 'DDD::Base::Domain';
}

use ok 'StatisticsCollector::Domain::Measurement::Sensor';

my $d = D->new;

my $s = StatisticsCollector::Domain::Measurement::Sensor->new(
    sensor_name        => 'xxx/yy/z',
    latest_measurement => 100,
);

note 'provide';
on '2012-12-10 23:13:45' => sub {
    is $s->event_publisher->_nr_events, 0, 'no events yet';
    
    $s->provide_measurement_result(50);
    
    is $s->sensor_name->name, 'xxx/yy/z', 'sensor name saved';
    is $s->latest_measurement->result, 50, 'measurement result saved';

    is $s->event_publisher->_nr_events, 1, 'one event waiting';
};

done_testing;
