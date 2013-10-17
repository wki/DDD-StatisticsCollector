use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;

use ok 'StatisticsCollector::Domain::Measurement::AllSensors';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors->new(domain => $d);

can_ok $s, qw(filtered by_name save);

dies_ok { $s->filtered } 'filtered dies';
dies_ok { $s->by_name } 'by_name dies';
dies_ok { $s->save } 'save dies';

done_testing;
