use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllRules' }

use ok $class;

my $domain = MockDomain->new;
my $all_rules = $class->new(domain => $domain);

can_ok $all_rules, 'for_sensor';

dies_ok { $all_rules->for_sensor } 'for_sensor() dies';

done_testing;
