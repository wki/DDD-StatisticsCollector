package StatisticsCollector::Domain::Condense::Summaries;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementProvided';
# use aliased 'StatisticsCollector::Domain::Common::Measurement';
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::Summary';
use namespace::autoclean;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Condense::Summaries - blabla

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 sensor_name

=cut

has sensor_name => (
    is => 'rw',
    isa => 'SensorName', # the Moose class
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

=cut

sub add_measurement {
    my ($self, $measurement) = @_;
    
    $self->_append_to('hourly_summaries', 'hour', $measurement);
    $self->_append_to('daily_summaries',  'day',  $measurement);
}

sub _append_to {
    my ($self, $accessor, $interval, $measurement) = @_;
    
    # if ($self->_can_append_to_latest_measure($accessor, $measurement)) {
    #   
    # } else {
    #   
    # }
    
    
    my $summaries = $self->$accessor;
    
    my $latest_summary = scalar @$summaries
        ? $summaries->[-1]
        : undef;
    
    if ($latest_summary &&
        $latest_summary->range_matches($measurement->measured_on))
    {
        $summaries->[-1] =
            $latest_summary->append_result($measurement);
    } else {
        push @$summaries,
            Summary->from_measurement($measurement, $interval);
    }
}

__PACKAGE__->meta->make_immutable;
1;
