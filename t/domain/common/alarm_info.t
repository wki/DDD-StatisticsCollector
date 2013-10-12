use strict;
use warnings;
use vars '$class';
use Test::More;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Domain::Common::AlarmInfo' }

use ok $class;


note 'instantiation';
{
    my $alarm_info1 = $class->new;
    ok !$alarm_info1->has_alarm, 'has no alarm';
    
    on '2012-12-23 23:34:45' => sub {
        $alarm_info1 = $class->new(message => 'foobar');
        ok $alarm_info1->has_alarm, 'has alarm';
        is $alarm_info1->raised_on->ymd, '2012-12-23', 'raised date';
        is $alarm_info1->raised_on->hms, '23:34:45',   'raised time';
        ok !$alarm_info1->is_cleared, 'not cleared';
    };
    
    on '2012-12-24 01:23:34' => sub {
        my $alarm_info2 = $alarm_info1->clear;
        
        isnt $alarm_info1, $alarm_info2, 'factory returned new object';
        # would compare DateTime objects -- results in a warning.
        # ok !$alarm_info1->is_equal($alarm_info2), 'different object';
        is $alarm_info1->message, $alarm_info2->message, 'message equal';
        is $alarm_info1->raised_on->ymd, $alarm_info2->raised_on->ymd, 'raised on equal';
        
        is $alarm_info2->cleared_on->ymd, '2012-12-24', 'cleared date';
        is $alarm_info2->cleared_on->hms, '01:23:34',   'cleared time';
        ok $alarm_info2->is_cleared, 'cleared';
    };
}

note 'type_constraint';
{
    {
        package X;
        use Moose;
        has a => (
            is     => 'rw',
            isa    => 'AlarmInfo',
            coerce => 1,
        );
    }
    
    my $x = X->new(a => 'foo');
    isa_ok $x->a, $class;
    is $x->a->message, 'foo', 'value converted via coercion';
}

done_testing;
