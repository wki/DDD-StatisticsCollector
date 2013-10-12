package StatisticsCollector::Domain::Alarm::AllRules;
use Moose;
use aliased 'StatisticsCollector::Domain::Alarm::Rule';
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Alarm::AllRules - abstract base class for rule
repository

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_id )

load the best rule matching a sensor mask

=cut

sub for_sensor {
    my ($self, $sensor_id) = @_;
    
    die 'abstract class'
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
