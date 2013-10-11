use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllRules::Fixed' }

use ok $class;

my $d = MockDomain->new;
my $a = $class->new(domain => $d);

note 'basic behavior';
{
    can_ok $a, 'for_sensor';
    isa_ok $a, 'StatisticsCollector::Domain::Alarm::AllRules';
}

note 'rule storage';
{
    is $a->nr_rules, 3, 'rules read';
    
    foreach my $rule ($a->all_rules) {
        isa_ok $rule, 'StatisticsCollector::Domain::Alarm::Rule';
    }
}

note 'rule loading';
{
    my @testcases = (
        { sensor => 'x/x/wind',             rule_name => 'null rule' },
        { sensor => 'x/x/temperatur',       rule_name => 'temperature age' },
        { sensor => 'x/heizung/temperatur', rule_name => 'heating health' },
    );
    
    foreach my $testcase (@testcases) {
        isa_ok $a->for_sensor($testcase->{sensor}),
            'StatisticsCollector::Domain::Alarm::Rule';
        
        is $a->for_sensor($testcase->{sensor})->name,
            $testcase->{rule_name},
            "$testcase->{sensor} rule name";
    }
}

done_testing;
