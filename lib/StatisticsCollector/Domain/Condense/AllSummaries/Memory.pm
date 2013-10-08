package StatisticsCollector::Domain::Condense::AllSummaries::Memory;
use Moose;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Condense::AllSummaries';

our %summaries_for; # sensor_name => summaries aggregate

=head1 NAME

StatisticsCollector::Domain::Condense::AllSummaries::Memory - a repository base class
for retrieving and saving Summaries in memory

=head1 SYNOPSIS

see StatisticsCollector::Domain::Condense::AllSummaries

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_name )

load summaries for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_name) = @_;
    
    return $summaries_for{$sensor_name};
}

=head2 save ( $summaries )

save a summary

=cut

sub save {
    my ($self, $summaries) = @_;
    
    $summaries_for{$summaries->id} = $summaries;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
