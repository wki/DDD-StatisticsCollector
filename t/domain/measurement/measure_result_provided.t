use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::MeasurementResultProvided';

isa_ok 'StatisticsCollector::Domain::Measurement::MeasurementResultProvided',
    'DDD::Event';

done_testing;
