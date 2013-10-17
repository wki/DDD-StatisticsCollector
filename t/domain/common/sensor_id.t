use vars '$class';
use Test::Most;

BEGIN { $class = 'StatisticsCollector::Domain::Common::SensorId' }

use ok $class;

note 'failing construction';
{
    dies_ok { $class->new() }
        'name is required';
    
    dies_ok { $class->new(name => 'abc') }
        'name must have 3 parts';
    
    dies_ok { $class->new(name => 'a/b/c?') }
        'name must only have letters, digits or _';
}

note 'succeeding construction';
{
    lives_ok { $class->new(name => 'a/b/c') }
        'a/b/c lives';

    lives_ok { $class->new(name => 'tokio/outside/humi_dity2') }
        'tokio/outside/humi_dity2 lives';
}

note 'type constraint';
{
    {
        package X;
        use Moose;
        has n => (
            is     => 'rw',
            isa    => 'SensorId',
            coerce => 1,
        );
    }
    
    my $x = X->new(n => 'a/b/xxx');
    isa_ok $x->n, $class;
    is $x->n->name, 'a/b/xxx', 'name converted via coercion';
}

note 'immutability';
{
    my $sensor_id = $class->new(name => 'a/b/c');
    
    dies_ok { $sensor_id->name('c/d/e') }
        'name attribute is immutable';
}

note 'mask matching';
{
    my $sensor_id = $class->new(name => 'a/b/c');
    
    ok !$sensor_id->matches_mask,           'empty mask does never match';
    ok  $sensor_id->matches_mask('a/b/c'),  'exact mask matches';
    ok  $sensor_id->matches_mask('*/b/c'),  'single wildcard matches';
    ok  $sensor_id->matches_mask('*/*/c'),  'double wildcard matches';
    ok  $sensor_id->matches_mask('*/*/*'),  'triple wildcard matches';
    ok !$sensor_id->matches_mask('*/*/d'),  'wrong mask fails';
}

done_testing;
