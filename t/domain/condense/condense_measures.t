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
use aliased 'StatisticsCollector::Domain::Condense::AllSummaries::Memory';

BEGIN { $class = 'StatisticsCollector::Domain::Condense::CondenseMeasures' }

use ok $class;

my $d = MockDomain->new;
my $c = $class->new(
    domain => $d,
    all_summaries => Memory->new(domain => $d),
);

note 'basic behavior';
{
    can_ok $c, 'add_measurement';
    
    isa_ok $c->summaries_creator,
        'StatisticsCollector::Domain::Condense::SummariesCreator';
}

note 'methods';
{
    my $m = Measurement->new(result => 42);

    ok !$c->all_summaries->for_sensor('x/y/z'),
        'sensor x/y/z not in storage';
    
    $c->add_measurement('x/y/z' => $m);
    
    ok $c->all_summaries->for_sensor('x/y/z'),
        'sensor x/y/z in storage after add measurement';
    
    # note explain $c->all_summaries->for_sensor('x/y/z')->pack;
}

note 'event handling';
{
    $d->publish(
        MeasurementProvided->new(
            sensor_name => 'a/b/c',
            measurement => 32,
        ),
    );
    
    ok !$c->all_summaries->for_sensor('a/b/c'),
        'sensor a/b/c not in storage';

    $d->process_events;
    
    ok $c->all_summaries->for_sensor('a/b/c'),
        'sensor a/b/c in storage';
    
    # note explain $d->event_publisher->_listeners;
    
    ok !$d->event_publisher->_nr_events, 'no more events to process';
}

done_testing;
