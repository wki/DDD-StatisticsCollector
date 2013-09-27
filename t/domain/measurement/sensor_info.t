use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::SensorInfo';

note 'coercion';
{
    my $i = StatisticsCollector::Domain::Measurement::SensorInfo->new(
        sensor      => 'a/b/c',
        measurement => -100,
    );
    
    is $i->sensor->name,        'a/b/c', 'name converted';
    is $i->measurement->result, -100,    'result converted';
}

done_testing;
