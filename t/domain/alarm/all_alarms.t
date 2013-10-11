use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllAlarms' }

use ok $class;

my $d = MockDomain->new;
my $s = $class->new(domain => $d);

can_ok $s, qw(for_sensor save);

dies_ok { $s->for_sensor } 'for_sensor dies';
dies_ok { $s->save } 'save dies';

done_testing;
