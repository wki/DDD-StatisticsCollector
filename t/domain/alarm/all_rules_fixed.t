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

my $domain = MockDomain->new;
my $all_rules = $class->new(domain => $domain);

note 'basic behavior';
{
    can_ok $all_rules, 'for_sensor';
    isa_ok $all_rules, 'StatisticsCollector::Domain::Alarm::AllRules';
}

note 'rule storage';
{
    is $all_rules->nr_rules, 3, 'rules read';
    
    foreach my $rule ($all_rules->all_rules) {
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
        isa_ok $all_rules->for_sensor($testcase->{sensor}),
            'StatisticsCollector::Domain::Alarm::Rule';
        
        is $all_rules->for_sensor($testcase->{sensor})->name,
            $testcase->{rule_name},
            "$testcase->{sensor} rule name";
    }
}

done_testing;
