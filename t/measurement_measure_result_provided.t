use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Measurement::MeasureResultProvided';

isa_ok 'StatisticsCollector::Domain::Measurement::MeasureResultProvided',
    'DDD::Event';

done_testing;
