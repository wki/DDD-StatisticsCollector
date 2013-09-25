package StatisticsCollector::Domain::Alarm::AlarmRaised;
use Moose;
use DateTime;
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use namespace::autoclean;

extends 'DDD::Event';

has raised_on => (
    is      => 'ro',
    isa     => 'DateTime',
    default => sub { DateTime->now( time_zone => 'local' ) },
);

has sensor => (
    is       => 'ro',
    isa      => 'T_SensorName',
    coerce   => 1,
    required => 1,
);

has message => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable;
1;
