use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Condense::SummariesCreator';

my $domain = MockDomain->new;
my $summaries_creator = StatisticsCollector::Domain::Condense::SummariesCreator->new(
    domain => $domain,
);

note 'failing creation';
{
    dies_ok { $summaries_creator->new_summaries }
        'creating an unnamed summaries dies';
    
    dies_ok { $summaries_creator->new_ssummaries('') }
        'creating a summaries with empty name dies';

    dies_ok { $summaries_creator->new_summaries('abc') }
        'creating a illegal-named summaries dies';
}

note 'succeeding creation';
{
    my $summaries = $summaries_creator->new_summaries('a/bb/ccc');
    
    isa_ok $summaries, 'StatisticsCollector::Domain::Condense::Summaries';
}

done_testing;
