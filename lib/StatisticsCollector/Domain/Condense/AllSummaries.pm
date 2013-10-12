package StatisticsCollector::Domain::Condense::AllSummaries;
use Moose;
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Condense::AllSummaries - a repository base class
for retrieving and saving Summaries

=head1 SYNOPSIS

    # assume that $all_summaries is an instance of AllSummaries
    
    # get summaries for a single sensor
    my $summaries = $all_summaries->for_sensor('x/y/z');
    
    # write back summaries
    $all_summaries->save($summaries);

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_id )

load summaries for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_id) = @_;
    
    die 'abstract class';
}

=head2 save ( $summaries )

save a summary

=cut

sub save {
    my ($self, $summaries) = @_;
    
    die 'abstract class';
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
