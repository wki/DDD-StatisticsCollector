use aliased 'StatisticsCollector::Domain::Common::Measurement';
use Test::Most;
use Test::MockDateTime;

use ok 'StatisticsCollector::Domain::Alarm::Condition';
use ok 'StatisticsCollector::Domain::Alarm::Condition::Min';
use ok 'StatisticsCollector::Domain::Alarm::Condition::Max';
use ok 'StatisticsCollector::Domain::Alarm::Condition::Age';

note 'basic behavior';
{
    my $condition = StatisticsCollector::Domain::Alarm::Condition->new(
        name => 'test',
        value => 0,
    );
    
    can_ok $condition, 'is_satisfied';
    
    dies_ok { $condition->is_satisfied } 'is_satisfied() dies';
}

note 'min/max conditions';
{
    my @testcases = (
        { name => 'min ok', class => 'Min', value => 10, result => 11, is_satisfied => 1 },
        { name => 'min eq', class => 'Min', value => 10, result => 10, is_satisfied => 0 },
        { name => 'min lt', class => 'Min', value => 10, result =>  5, is_satisfied => 0 },

        { name => 'max ok', class => 'Max', value => 30, result => 29, is_satisfied => 1 },
        { name => 'max eq', class => 'Max', value => 30, result => 30, is_satisfied => 0 },
        { name => 'max gt', class => 'Max', value => 30, result => 55, is_satisfied => 0 },
    );
    
    foreach my $testcase (@testcases) {
        my $class = "StatisticsCollector::Domain::Alarm::Condition::$testcase->{class}";
        my $condition = $class->new(
            name  => $testcase->{name},
            value => $testcase->{value},
        );
        
        my $measurement = Measurement->new(result => $testcase->{result});
        
        is $condition->is_satisfied($measurement) ? 1 : 0,
            $testcase->{is_satisfied},
            "$testcase->{name} is_satisfied() $testcase->{is_satisfied}";
    }
}

note 'age condition';
on '2013-10-09 19:00:00' => sub {
    my $measurement = Measurement->new(result => 42);
    
    my $condition = StatisticsCollector::Domain::Alarm::Condition::Age->new(
        name  => '10 min',
        value => 10,
    );
    
    my @testcases = (
        { on => '2013-10-09 19:00:00', is_satisfied => 1 },
        { on => '2013-10-09 19:09:00', is_satisfied => 1 },
        { on => '2013-10-09 19:10:00', is_satisfied => 0 },
        { on => '2013-10-09 20:00:00', is_satisfied => 0 },
    );
    
    foreach my $testcase (@testcases) {
        on $testcase->{on}, sub {
            is $condition->is_satisfied($measurement) ? 1 : 0,
                $testcase->{is_satisfied},
                $testcase->{on} . ($testcase->{is_satisfied} ? ' satisfied' : ' not satisfied');
        };
    }
};

done_testing;
