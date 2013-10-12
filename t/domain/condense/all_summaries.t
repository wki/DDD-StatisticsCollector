use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Condense::AllSummaries' }

use ok $class;

my $domain = MockDomain->new;
my $all_summaries = $class->new(domain => $domain);

can_ok $all_summaries, qw(for_sensor save);

dies_ok { $all_summaries->for_sensor } 'for_sensor dies';
dies_ok { $all_summaries->save } 'save dies';

done_testing;
