use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;

BEGIN { ok "abc"; $class = 'StatisticsCollector::Domain::Alarm::AlarmCreator' }
use ok $class;

my $domain = MockDomain->new;
my $alarm_creator = $class->new(
    domain => $domain,
);

note 'failing creation';
{
    dies_ok { $alarm_creator->new_alarm }
        'creating an unnamed alarm dies';
    
    dies_ok { $alarm_creator->new_alarm('') }
        'creating an alarm with empty name dies';

    dies_ok { $alarm_creator->new_alarm('abc') }
        'creating a illegal-named alarm dies';
}

note 'succeeding creation';
{
    my $alarm = $alarm_creator->new_alarm('a/bb/ccc');
    
    isa_ok $alarm, 'StatisticsCollector::Domain::Alarm::Alarm';
}

done_testing;
