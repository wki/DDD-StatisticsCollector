use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain::Alarm::Rule';

{
    package Bad;
    use Moose;
    extends 'StatisticsCollector::Domain::Alarm::Condition';
    
    sub is_satisfied { 0 };

    package Good;
    use Moose;
    extends 'StatisticsCollector::Domain::Alarm::Condition';
    
    sub is_satisfied { 1 };

    package Positive;
    use Moose;
    extends 'StatisticsCollector::Domain::Alarm::Condition';
    
    sub is_satisfied { $_[1] > 0 };
}

note 'basic behavior';
{
    my $rule = StatisticsCollector::Domain::Alarm::Rule->new(
        name       => 'nonsense',
        conditions => [],
    );
    
    can_ok $rule, 'is_satisfied';
}

note 'condition check';
{
    my @testcases = (
        { name => 'no conditions',      conditions => [],              measurement => 0, is_satisfied => 1, status_text => '' },
        { name => 'bad condition',      conditions => ['Bad'],         measurement => 0, is_satisfied => 0, status_text => 'Bad' },
        { name => 'good condition',     conditions => ['Good'],        measurement => 0, is_satisfied => 1, status_text => '' },
        { name => 'bad+good condition', conditions => ['Bad', 'Good'], measurement => 0, is_satisfied => 0, status_text => 'Bad' },
        { name => 'good+bad condition', conditions => ['Good', 'Bad'], measurement => 0, is_satisfied => 0, status_text => 'Bad' },
        { name => 'positive(0)',        conditions => ['Positive'],    measurement => 0, is_satisfied => 0, status_text => 'Positive' },
        { name => 'positive(1)',        conditions => ['Positive'],    measurement => 1, is_satisfied => 1, status_text => '' },
    );
    
    foreach my $testcase (@testcases) {
        my @conditions =
            map { $_->new(value => 0, name => $_) }
            @{$testcase->{conditions}};
        
        my $rule = StatisticsCollector::Domain::Alarm::Rule->new(
            name       => $testcase->{name},
            conditions => \@conditions,
        );
        
        is $rule->is_satisfied($testcase->{measurement}) ? 1 : 0,
            $testcase->{is_satisfied},
            "$testcase->{name} is_satisfied = $testcase->{is_satisfied} (scalar)";
        
        is_deeply [ $rule->is_satisfied($testcase->{measurement}) ],
            [ $testcase->{is_satisfied}, $testcase->{status_text} ],
            "$testcase->{name} is_satisfied = $testcase->{is_satisfied} (list)";
        
    }
}

done_testing;
