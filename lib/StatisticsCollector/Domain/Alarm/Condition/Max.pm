package StatisticsCollector::Domain::Alarm::Condition::Max;
use Moose;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::Condition';

=head1 NAME

StatisticsCollector::Domain::Alarm::Condition::Max - test for values to be
less than a maximum value

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 is_satisfied ( $measurement )

returns a true value a measurement result is lower than a given maximum value.

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;

    return $measurement->result < $self->value
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
