use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllRules' }

use ok $class;

my $d = MockDomain->new;
my $a = $class->new(domain => $d);

can_ok $a, 'for_sensor';

dies_ok { $a->for_sensor } 'for_sensor() dies';

done_testing;
