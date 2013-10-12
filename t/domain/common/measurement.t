use strict;
use warnings;
use vars '$class';
use DateTime;
use Test::More;
use Test::Exception;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Domain::Common::Measurement' }

use ok $class;

note 'failing construction';
{
    dies_ok { $class->new }
        'empty constructor dies';
    
    dies_ok { $class->new(result => 'abc') }
        'non-numeric result dies';
}

note 'succeessful construction';
on '2012-12-10 23:13:45' => sub {
    my $measurement = $class->new(result => 42);
    
    is $measurement->measured_on->ymd,
        '2012-12-10',
        'measure date';

    is $measurement->measured_on->hms,
        '23:13:45',
        'measure time';
    
    is $measurement->result,
        42,
        'result is 42';
};

note 'type_constraint';
{
    {
        package X;
        use Moose;
        has m => (
            is     => 'rw',
            isa    => 'Measurement',
            coerce => 1,
        );
    }
    
    my $x = X->new(m => 42);
    isa_ok $x->m, $class;
    is $x->m->result, 42, 'value converted via coercion';
}

done_testing;
