use strict;
use warnings;
use DDD::EventPublisher;
use aliased 'StatisticsCollector::Domain::Measurement::SensorInfo';
use Test::More;
use Test::Exception;

{
    package D;              # Mock Domain
    use Moose;
    
    extends 'DDD::Base::Domain';
}

use ok 'StatisticsCollector::Domain::Measurement::Sensor';

my $d = D->new;
my $i = SensorInfo->new(
    name   => 'xxx/yy/z',
    result => 100
);

my $s = StatisticsCollector::Domain::Measurement::Sensor->new(
    domain          => $d,
    info            => $i,
    event_publisher => DDD::EventPublisher->new,
);

note 'provide';
{
    my $dt = DateTime->new(
        year  => 2012,   hour   => 23,
        month => 12,     minute => 13,
        day   => 10,     second => 45,
        time_zone => 'local',
    );
    no warnings 'redefine';
    local *DateTime::now = sub { $dt->clone };
    use warnings 'redefine';
    
    is $s->event_publisher->_nr_events, 0, 'no events yet';
    
    $s->provide_result(50);
    
    is $s->info->result->result, 50, 'result saved';

    is $s->event_publisher->_nr_events, 1, 'one event waiting';
}

done_testing;
