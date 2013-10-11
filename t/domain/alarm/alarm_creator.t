use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { ok "abc"; $class = 'StatisticsCollector::Domain::Alarm::AlarmCreator' }
use ok $class;

my $d = MockDomain->new;
my $c = $class->new(
    domain => $d,
);

note 'failing creation';
{
    dies_ok { $c->new_alarm }
        'creating an unnamed alarm dies';
    
    dies_ok { $c->new_alarm('') }
        'creating an alarm with empty name dies';

    dies_ok { $c->new_alarm('abc') }
        'creating a illegal-named alarm dies';
}

note 'succeeding creation';
{
    my $a = $c->new_alarm('a/bb/ccc');
    
    isa_ok $a, 'StatisticsCollector::Domain::Alarm::Alarm';
}

done_testing;
