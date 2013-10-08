package StatisticsCollector::Domain::Alarm::Condition::Min;
use Moose;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::Condition';

=head1 NAME

StatisticsCollector::Domain::Alarm::Condition::Min - test for values to be
higher than a minimum value

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 is_satisfied ( $measurement )

returns a true value a measurement result is higher than a given minimum value.

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;
    
    return $measurement->result > $self->value
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
