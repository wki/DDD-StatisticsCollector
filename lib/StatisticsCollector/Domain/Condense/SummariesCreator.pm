package StatisticsCollector::Domain::Condense::SummariesCreator;
use Moose;
use aliased 'StatisticsCollector::Domain::Condense::Summaries';
use namespace::autoclean;

extends 'DDD::Factory';

=head1 NAME

StatisticsCollector::Domain::Condense::SummariesCreator - a summaries factory

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 new_summaries ( $sensor_id )

create a new summaries object for a sensor

=cut

sub new_summaries {
    my ($self, $sensor_id) = @_;
    
    return Summaries->new(
        id        => $sensor_id,
        sensor_id => $sensor_id,
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
