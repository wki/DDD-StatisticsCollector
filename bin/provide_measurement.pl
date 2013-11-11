#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";

use StatisticsCollector::App::ProvideMeasurement;

StatisticsCollector::App::ProvideMeasurement->new_with_options->run;
