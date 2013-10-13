package StatisticsCollector::Domain::Condense::AllSummaries::File;
use Moose;
use aliased 'StatisticsCollector::Domain::Condense::Summaries';
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Condense::AllSummaries';
with 'StatisticsCollector::Domain::Role::FileStorage';

=head1 NAME

StatisticsCollector::Domain::Condense::AllSummaries::File - a file based
storage for retrieving and saving Summaries as files

=head1 SYNOPSIS

see StatisticsCollector::Domain::Condense::AllSummaries

=head1 DESCRIPTION

=cut

=head1 METHODS

=cut

sub _build_file_suffix { 'summaries' }

=head2 for_sensor ( $sensor_id )

load summaries for a sensor identified by its name

=cut

sub for_sensor {
    my ($self, $sensor_id) = @_;

    my $file = $self->_file($sensor_id)->stringify;
    return if !-f $file;

    return Summaries->load($file);
}

=head2 save ( $summaries )

save a summary

=cut

sub save {
    my ($self, $summaries) = @_;

    $summaries->store($self->_file($summaries->id)->stringify);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
