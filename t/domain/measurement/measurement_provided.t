use strict;
use warnings;
use vars '$class';
use Test::More;

BEGIN { $class = 'StatisticsCollector::Domain::Measurement::MeasurementProvided' }

use ok $class;

isa_ok $class, 'DDD::Event';

done_testing;
