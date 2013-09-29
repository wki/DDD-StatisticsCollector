use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::MeasurementProvided';

isa_ok 'StatisticsCollector::Domain::Measurement::MeasurementProvided',
    'DDD::Event';

done_testing;
