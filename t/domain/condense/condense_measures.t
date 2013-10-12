use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;
use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
use aliased 'StatisticsCollector::Domain::Condense::AllSummaries::Memory'
    => 'AllSummaries';

BEGIN { $class = 'StatisticsCollector::Domain::Condense::CondenseMeasures' }

use ok $class;

my $domain = MockDomain->new;
my $condense_measures = $class->new(
    domain => $domain,
    all_summaries => AllSummaries->new(domain => $domain),
);

note 'basic behavior';
{
    can_ok $condense_measures, 'add_measurement';
    
    isa_ok $condense_measures->summaries_creator,
        'StatisticsCollector::Domain::Condense::SummariesCreator';
}

note 'methods';
{
    my $measurement = Measurement->new(result => 42);

    ok !$condense_measures->all_summaries->for_sensor('x/y/z'),
        'sensor x/y/z not in storage';
    
    $condense_measures->add_measurement('x/y/z' => $measurement);
    
    ok $condense_measures->all_summaries->for_sensor('x/y/z'),
        'sensor x/y/z in storage after add measurement';
    
    # note explain $condense_measures->all_summaries->for_sensor('x/y/z')->pack;
}

note 'event handling';
{
    $domain->publish(
        MeasurementProvided->new(
            sensor_name => 'a/b/c',
            measurement => 32,
        ),
    );
    
    ok !$condense_measures->all_summaries->for_sensor('a/b/c'),
        'sensor a/b/c not in storage';

    $domain->process_events;
    
    ok $condense_measures->all_summaries->for_sensor('a/b/c'),
        'sensor a/b/c in storage';
    
    # note explain $domain->event_publisher->_listeners;
    
    ok !$domain->event_publisher->_nr_events, 'no more events to process';
}

done_testing;
