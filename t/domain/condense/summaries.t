use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
# use Test::Exception;
use Test::MockDateTime;
use aliased 'StatisticsCollector::Domain::Common::Measurement';

use ok 'StatisticsCollector::Domain::Condense::Summaries';

my $d = MockDomain->new;

my $s = StatisticsCollector::Domain::Condense::Summaries->new(
    domain => $d,
    id     => 'xxx/yy/z',
);

note 'initial state';
{
    is_deeply $s->hourly_summaries, [], 'no hours';
    is_deeply $s->daily_summaries,  [], 'no days';
}

my @testcases = (
    {
        ymd => '2013-03-05',      hms => '12:01:01',
        measurement_result => 30,
        nr_hours => 1,            nr_days => 1,
        h_from_hms => '12:00:00', h_to_hms => '13:00:00',
        h_min => 30, h_max => 30, h_sum => 30, h_nr => 1,
        d_min => 30, d_max => 30, d_sum => 30, d_nr => 1,
    },
    {
        ymd => '2013-03-05',      hms => '12:05:01',
        measurement_result => 40,
        nr_hours => 1,            nr_days => 1,
        h_from_hms => '12:00:00', h_to_hms => '13:00:00',
        h_min => 30, h_max => 40, h_sum => 70, h_nr => 2,
        d_min => 30, d_max => 40, d_sum => 70, d_nr => 2,
    },
    {
        ymd => '2013-03-05',      hms => '13:59:59',
        measurement_result => 20,
        nr_hours => 2,            nr_days => 1,
        h_from_hms => '13:00:00', h_to_hms => '14:00:00',
        h_min => 20, h_max => 20, h_sum => 20, h_nr => 1,
        d_min => 20, d_max => 40, d_sum => 90, d_nr => 3,
    },
    {
        ymd => '2013-03-06',      hms => '12:30:20',
        measurement_result => 10,
        nr_hours => 3,            nr_days => 2,
        h_from_hms => '12:00:00', h_to_hms => '13:00:00',
        h_min => 10, h_max => 10, h_sum => 10, h_nr => 1,
        d_min => 10, d_max => 10, d_sum => 10, d_nr => 1,
    },
);

note 'add values';
foreach my $testcase (@testcases) {
    my $date = "$testcase->{ymd} $testcase->{hms}";
    on $date  => sub {
        $s->add_measurement(
            Measurement->new(result => $testcase->{measurement_result})
        );
        
        note $date;
        
        # note explain $s->pack;
        
        my $tomorrow = DateTime->now->truncate(to => 'day')->add(days => 1)->ymd;
        
        is scalar @{$s->hourly_summaries},
            $testcase->{nr_hours},
            "$date: $testcase->{nr_hours} hour(s)";

        is scalar @{$s->daily_summaries},
            $testcase->{nr_days},
            "$date: $testcase->{nr_days} day(s)";
        
        my $last_hour = $s->hourly_summaries->[-1];
        is $last_hour->from->ymd, $testcase->{ymd},        "$date: from h ymd";
        is $last_hour->from->hms, $testcase->{h_from_hms}, "$date: from h hms";
        is $last_hour->to->ymd,   $testcase->{ymd},        "$date: to h ymd";
        is $last_hour->to->hms,   $testcase->{h_to_hms},   "$date: to h hms";
        
        is $last_hour->min,       $testcase->{h_min},      "$date: h min";
        is $last_hour->max,       $testcase->{h_max},      "$date: h max";
        is $last_hour->sum,       $testcase->{h_sum},      "$date: h sum";
        is $last_hour->nr_values, $testcase->{h_nr},       "$date: h nr";

        my $last_day = $s->daily_summaries->[-1];
        is $last_day->from->ymd, $testcase->{ymd},        "$date: from d ymd";
        is $last_day->from->hms, '00:00:00',              "$date: from d hms";
        is $last_day->to->ymd,   $tomorrow,               "$date: to d ymd";
        is $last_day->to->hms,   '00:00:00',              "$date: to d hms";
        
        is $last_day->min,       $testcase->{d_min},      "$date: d min";
        is $last_day->max,       $testcase->{d_max},      "$date: d max";
        is $last_day->sum,       $testcase->{d_sum},      "$date: d sum";
        is $last_day->nr_values, $testcase->{d_nr},       "$date: d nr";
    }
}

done_testing;
