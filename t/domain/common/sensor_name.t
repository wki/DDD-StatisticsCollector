use strict;
use warnings;
use vars '$class';
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Common::SensorName' }

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
            isa    => 'SensorName',
            coerce => 1,
        );
    }
    
    my $x = X->new(n => 'a/b/xxx');
    isa_ok $x->n, $class;
    is $x->n->name, 'a/b/xxx', 'name converted via coercion';
}

note 'immutability';
{
    my $sensor_name = $class->new(name => 'a/b/c');
    
    dies_ok { $sensor_name->name('c/d/e') }
        'name attribute is immutable';
}

note 'mask matching';
{
    my $sensor_name = $class->new(name => 'a/b/c');
    
    ok !$sensor_name->matches_mask,           'empty mask does never match';
    ok  $sensor_name->matches_mask('a/b/c'),  'exact mask matches';
    ok  $sensor_name->matches_mask('*/b/c'),  'single wildcard matches';
    ok  $sensor_name->matches_mask('*/*/c'),  'double wildcard matches';
    ok  $sensor_name->matches_mask('*/*/*'),  'triple wildcard matches';
    ok !$sensor_name->matches_mask('*/*/d'),  'wrong mask fails';
}

done_testing;
