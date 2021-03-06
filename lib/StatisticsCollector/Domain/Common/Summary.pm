package StatisticsCollector::Domain::Common::Summary;
use DateTime;
use List::Util qw(min max);
use Moose;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Common::Summary - condensed values

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

has [qw(from to)] => (
    is       => 'ro',
    isa      => 'DateTime',
    required => 1,
);

has [qw(min max sum nr_values)] => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

=head1 METHODS

=cut

sub avg {
    my $self = shift;
    
    return sprintf('%d', $self->sum / $self->nr_values);
}

=head2 range_matches ( $timestamp )

returns true if a timestamp is in the same range as the summary

=cut

sub range_matches {
    my ($self, $timestamp) = @_;
    
    return DateTime->compare($self->from, $timestamp) <= 0
        && DateTime->compare($self->to,   $timestamp) > 0;
}


=head2 from_measurement

Factory method: constructs a new summary value from a measurement result

=cut

sub from_measurement {
    my ($class, $result, $truncate) = @_;
    
    $truncate //= 'hour';
    
    my $from  = $result->measured_on->clone->truncate( to => $truncate );
    my $to    = $from->clone->add("${truncate}s" => 1);
    my $value = $result->result;
    
    return $class->new(
        from      => $from,
        to        => $to,
        min       => $value,
        max       => $value,
        sum       => $value,
        nr_values => 1,
    );
}

=head2 append_measurement

Factory method: constructs a new summary by appending a measurement result

=cut

sub append_measurement {
    my ($self, $measurement) = @_;
    
    die "Result (${\$measurement->measured_on->dmy} ${\$measurement->measured_on->hms}) "
        . "is out of range (${\$self->from->dmy} ${\$self->from->hms} - ${\$self->to->hms})"
        if !$self->range_matches($measurement->measured_on);
    
    return __PACKAGE__->new(
        from      => $self->from,
        to        => $self->to,
        min       => min($self->min, $measurement->result),
        max       => max($self->max, $measurement->result),
        sum       => $self->sum + $measurement->result,
        nr_values => $self->nr_values + 1,
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
