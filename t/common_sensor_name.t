use strict;
use warnings;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Common::SensorName';

our $class = 'StatisticsCollector::Domain::Common::SensorName';

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
            isa    => 'T_SensorName',
            coerce => 1,
        );
    }
    
    my $x = X->new(n => 'a/b/xxx');
    isa_ok $x->n, $class;
    is $x->n->name, 'a/b/xxx', 'name converted via coercion';
}

note 'immutability';
{
    my $c = $class->new(name => 'a/b/c');
    
    dies_ok { $c->name('c/d/e') }
        'name attribute is immutable';
}

note 'mask matching';
{
    my $c = $class->new(name => 'a/b/c');
    
    ok !$c->matches_mask, 'empty mask does never match';
    
    ok $c->matches_mask('a/b/c'), 'exact mask matches';

    ok $c->matches_mask('*/b/c'), 'single wildcard matches';

    ok $c->matches_mask('*/*/c'), 'double wildcard matches';

    ok $c->matches_mask('*/*/*'), 'triple wildcard matches';

    ok !$c->matches_mask('*/*/d'), 'wrong mask fails';
}

done_testing;
