use strict;
use warnings;
use DateTime;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Common::MeasurementResult';

our $class = 'StatisticsCollector::Domain::Common::MeasurementResult';

note 'failing construction';
{
    dies_ok { $class->new }
        'empty constructor dies';
    
    dies_ok { $class->new(result => 'abc') }
        'non-numeric result dies';
}

note 'succeeding construction';
{
    my $dt = DateTime->new(
        year  => 2012,   hour   => 23,
        month => 12,     minute => 13,
        day   => 10,     second => 45,
        time_zone => 'local',
    );
    no warnings 'redefine';
    local *DateTime::now = sub { $dt->clone };
    use warnings 'redefine';
    
    my $c = $class->new(result => 42);
    
    is +DateTime->compare($c->measured_on, $dt),
        0,
        'measure timestamp is equal';
    
    is $c->result,
        42,
        'result is 42';
}

note 'type_constraint';
{
    {
        package X;
        use Moose;
        has m => (
            is     => 'rw',
            isa    => 'T_MeasurementResult',
            coerce => 1,
        );
    }
    
    my $x = X->new(m => 42);
    isa_ok $x->m, $class;
    is $x->m->result, 42, 'value converted via coercion';
}

done_testing;
