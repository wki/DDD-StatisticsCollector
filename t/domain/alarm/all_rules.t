use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Alarm::AllRules';

my $d = MockDomain->new;
my $a = StatisticsCollector::Domain::Alarm::AllRules->new(domain => $d);

can_ok $a, 'for_sensor';

dies_ok { $a->for_sensor } 'for_sensor() dies';

done_testing;
