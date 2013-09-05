use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain';

my $domain = StatisticsCollector::Domain->new;

is $domain->domain,
    $domain, 
    'domain reflects itself';

isa_ok $domain->measurement,
    'StatisticsCollector::Domain::Measurement';

done_testing;
