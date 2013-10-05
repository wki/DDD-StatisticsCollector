use strict;
use warnings;
use Test::More;
use Test::MockDateTime;

use ok 'StatisticsCollector::Domain::Common::AlarmInfo';

my $class = 'StatisticsCollector::Domain::Common::AlarmInfo';

note 'instantiation';
{
    my $a1 = $class->new;
    ok !$a1->has_alarm, 'has no alarm';
    
    on '2012-12-23 23:34:45' => sub {
        $a1 = $class->new(name => 'foobar');
        ok $a1->has_alarm, 'has alarm';
        is $a1->raised_on->ymd, '2012-12-23', 'raised date';
        is $a1->raised_on->hms, '23:34:45',   'raised time';
        ok !$a1->is_cleared, 'not cleared';
    };
    
    on '2012-12-24 01:23:34' => sub {
        my $a2 = $a1->clear;
        
        isnt $a1, $a2, 'factory returned new object';
        # ok !$a1->is_equal($a2), 'different object';
        is $a1->name, $a2->name, 'name equal';
        is $a1->raised_on->ymd, $a2->raised_on->ymd, 'raised on equal';
        
        is $a2->cleared_on->ymd, '2012-12-24', 'cleared date';
        is $a2->cleared_on->hms, '01:23:34',   'cleared time';
        ok $a2->is_cleared, 'cleared';
    };
}

done_testing;
