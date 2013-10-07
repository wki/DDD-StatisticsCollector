package StatisticsCollector::Domain::Condense::Summaries;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::Summary';
use namespace::autoclean;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Condense::Summaries - manage hourly and daily
summaries for a sensor

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_name

=cut

has sensor_name => (
    is       => 'ro',
    isa      => 'SensorName', # the Moose class
    coerce   => 1,
    required => 1,
);

=head2 hourly_summaries

=cut

has hourly_summaries => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef', # of Summary
    default => sub { [] },
);

=head2 daily_summaries

=cut

has daily_summaries => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef', # of Summary
    default => sub { [] },
);

=head1 METHODS

=cut

=head2 add_measurement ( $measurement )

adds a measurement to hourly and daily summary arrays.

=cut

sub add_measurement {
    my ($self, $measurement) = @_;
    
    $self->_append_to($self->hourly_summaries, 'hour', $measurement);
    $self->_append_to($self->daily_summaries,  'day',  $measurement);
    
    # TODO: clean up too old hourly summaries.
    # Idea: truncate _now to current day, subtract 3 days
    #       then delete all hourly summaries older than that day.
}

sub _append_to {
    my ($self, $summaries, $interval, $measurement) = @_;

    if ($self->_can_append_to_latest_summary($summaries, $measurement)) {
        $self->_append_to_latest_summary($summaries, $measurement);
    } else {
        $self->_append_new_summary($summaries, $interval, $measurement);
    }
}

sub _can_append_to_latest_summary {
    my ($self, $summaries, $measurement) = @_;
    
    return if !scalar @$summaries;
    
    my $latest_summary = $summaries->[-1];
    return $latest_summary->range_matches($measurement->measured_on);
}

sub _append_to_latest_summary {
    my ($self, $summaries, $measurement) = @_;
    
    my $latest_summary = $summaries->[-1];
    
    $summaries->[-1] =
        $latest_summary->append_measurement($measurement);
}

sub _append_new_summary {
    my ($self, $summaries, $interval, $measurement) = @_;
    
    push @$summaries,
        Summary->from_measurement($measurement, $interval);
}

__PACKAGE__->meta->make_immutable;
1;
