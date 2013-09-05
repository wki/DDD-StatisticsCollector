use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::SensorInfo';

note 'coercion';
{
    my $i = StatisticsCollector::Domain::Measurement::SensorInfo->new(
        name   => 'a/b/c',
        result => -100,
    );
    
    is $i->name->name, 'a/b/c', 'name converted';
    is $i->result->result, -100, 'result converted';
}

done_testing;
