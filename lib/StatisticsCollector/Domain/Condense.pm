package StatisticsCollector::Domain::Condense;
use DDD::Domain; # FIXME: SubDomain

repository all_summaries => (
    isa          => 'AllSummaries::File',
    dependencies => {
        dir => dep('/storage_dir'),
    },
);

factory summaries_creator => (
    isa => 'SummariesCreator',
);

service condense_measures => (
    isa          => 'CondenseMeasures',
    dependencies => {
        all_summaries     => dep('all_summaries'),
        summaries_creator => dep('summaries_creator'),
    },
);

1;
