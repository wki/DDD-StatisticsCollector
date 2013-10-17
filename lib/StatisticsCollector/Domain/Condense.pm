package StatisticsCollector::Domain::Condense;
use DDD::SubDomain;

aggregate 'summaries';

repository all_summaries => (
    isa          => 'AllSummaries::File',
    dependencies => {
        dir => dep('/storage_dir'),
    },
);

factory 'summaries_creator';

service condense_measures => (
    dependencies => {
        all_summaries     => dep('all_summaries'),
        summaries_creator => dep('summaries_creator'),
    },
);

1;
