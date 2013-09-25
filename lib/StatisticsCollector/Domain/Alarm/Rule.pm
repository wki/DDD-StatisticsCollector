package StatisticsCollector::Domain::Alarm::Rule;
use Moose;
use aliased 'StatisticsCollector::Domain::Alarm::Condition';
use namespace::autoclean;

extends 'DDD::Value';

has conditions => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

=head2 is_satisfied ( $result )

returns true if the condition is satisfied for a measurement result

=cut

sub is_satisfied {
    my ($self, $result) = @_;
    
    foreach my $condition (@{$self->conditions}) {
        return if !$condition->is_satisfied($result);
    }
    
    return 1;
}

__PACKAGE__->meta->make_immutable;
1;
