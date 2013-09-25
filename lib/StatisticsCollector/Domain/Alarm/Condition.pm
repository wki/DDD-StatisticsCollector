package StatisticsCollector::Domain::Alarm::Condition;
use Moose;
use namespace::autoclean;

extends 'DDD::Value';

=head2 is_satisfied ( $result )

check if a given condition is satisfied for a given measurement result

=cut

sub is_satisfied {
    my ($self, $result) = @_;
    
    
    ### TODO
    return 0;
}


__PACKAGE__->meta->make_immutable;
1;
