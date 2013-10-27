use strict;
use warnings;

use StatisticsCollector::Web;

my $app = StatisticsCollector::Web->apply_default_middlewares(StatisticsCollector::Web->psgi_app);
$app;

