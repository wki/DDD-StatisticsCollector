package StatisticsCollector::Domain::Alarm::Condition::Age;
use Moose;
use DateTime;
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::Condition';

=head1 NAME

StatisticsCollector::Domain::Alarm::Condition::Age - age testing condition

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 is_satisfied ( $measurement )

returns a true value if the age of a measurement is less than 
C<<< $self->value >>> minutes old.

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;
    
    my $earliest_allowed_time =
        $self->_now->subtract( minutes => $self->value );
    
    return DateTime->compare(
        $measurement->measured_on,
        $earliest_allowed_time
    ) > 0
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
