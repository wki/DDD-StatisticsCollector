use strict;
use warnings;
use Test::More;
use Test::Exception;

{
    package D;              # Mock Domain
    use Moose;
    
    extends 'DDD::Base::Domain';
}

use ok 'StatisticsCollector::Domain::Measurement::Sensors';

my $d = D->new;
my $s = StatisticsCollector::Domain::Measurement::Sensors->new(domain => $d);

dies_ok { $s->sensor_info } 'sensor_info dies';
dies_ok { $s->sensor_by_name } 'sensor_by_name dies';
dies_ok { $s->save } 'save dies';

done_testing;
