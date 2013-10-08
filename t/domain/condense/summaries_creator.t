use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Condense::SummariesCreator';

my $d = MockDomain->new;
my $c = StatisticsCollector::Domain::Condense::SummariesCreator->new(
    domain => $d,
);

note 'failing creation';
{
    dies_ok { $c->new_summaries }
        'creating an unnamed summaries dies';
    
    dies_ok { $c->new_ssummaries('') }
        'creating a summaries with empty name dies';

    dies_ok { $c->new_summaries('abc') }
        'creating a illegal-named summaries dies';
}

note 'succeeding creation';
{
    my $s = $c->new_summaries('a/bb/ccc');
    
    isa_ok $s, 'StatisticsCollector::Domain::Condense::Summaries';
}

done_testing;
