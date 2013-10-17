use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;

use ok 'StatisticsCollector::Domain::Condense::AllSummaries';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Condense::AllSummaries->new(domain => $d);

can_ok $s, qw(for_sensor save);

dies_ok { $s->for_sensor } 'for_sensor dies';
dies_ok { $s->save } 'save dies';

done_testing;
