#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";

use StatisticsCollector::App::ShowMeasurement;

StatisticsCollector::App::ShowMeasurement->new_with_options->run;
