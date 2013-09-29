use strict;
use warnings;
use Test::More;
use Test::Exception;

{
    package D;              # Mock Domain
    use Moose;
    
    extends 'DDD::Base::Domain';
}

use ok 'StatisticsCollector::Domain::Measurement::AllSensors';

my $d = D->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors->new(domain => $d);

dies_ok { $s->filtered } 'filtered dies';
dies_ok { $s->by_name } 'by_name dies';
dies_ok { $s->save } 'save dies';

done_testing;
