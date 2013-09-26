package StatisticsCollector::Domain::Condense::SensorSummaries;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::MeasurementResultProvided';
use aliased 'StatisticsCollector::Domain::Measurement::SensorInfo';
use aliased 'StatisticsCollector::Domain::Common::Summary';
use aliased 'StatisticsCollector::Domain::Common::MeasurementResult';
use namespace::autoclean;

extends 'DDD::Aggregate';

has info => (
    is => 'rw',
    isa => SensorInfo,
    required => 1,
);

=head2 hourly_summaries

=cut

has hourly_summaries => (
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { [] },
);

=head2 daily_summaries

=cut

has daily_summaries => (
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { [] },
);

sub append_result {
    my ($self, $result) = @_;
    
    $self->_append_to('hourly_summaries', 'hour', $result);
    $self->_append_to('daily_summaries',  'day',  $result);
}

sub _append_to {
    my ($self, $accessor, $interval, $result) = @_;
    
    my $latest_summary = $self->$accessor->[-1];
    
    if ($latest_summary && $latest_summary->matches($result)) {
        $self->$accessor->[-1] =
            $latest_summary->append_result($result);
    } else {
        push @{$self->$accessor},
            Summary->from_measurement_result($result, $interval);
    }
}

sub condense_daily {
    my $self = shift;
    
    # TODO: remove day  entries > 3 years
    # TODO: remove hour entries > 3 days
}

__PACKAGE__->meta->make_immutable;
1;
