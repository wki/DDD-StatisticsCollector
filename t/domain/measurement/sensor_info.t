use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::SensorInfo';

note 'basic usage';
{
    my $i = StatisticsCollector::Domain::Measurement::SensorInfo->new(
        sensor             => 'a/b/c',
        measurement_result => -100,
    );
    
    is $i->sensor->name,        'a/b/c', 'name converted';
    is $i->measurement_result->result, -100,    'result converted';
    ok !$i->has_alarm_info,              'no alarm';
}

note 'factory method';
{
    my $i1 = StatisticsCollector::Domain::Measurement::SensorInfo->new(
        sensor             => 'a/b/c',
        measurement_result => -100,
    );
    
    my $i2 = $i1->new_measurement_result(42);
    
    # or should we use Scalar::Util::refaddr() ?
    isnt "$i1", "$i2", 'new object created';
    
    is $i2->measurement_result->result, 42, 'new result saved';
}

done_testing;
