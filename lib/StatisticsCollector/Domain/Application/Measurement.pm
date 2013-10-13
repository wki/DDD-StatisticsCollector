package StatisticsCollector::Domain::Application::Measurement;
use DDD::Service;

=head1 NAME

StatisticsCollector::Domain::Application::Measurement - Measurement
application service

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head1 METHODS

=cut

=head2 provide_result ( $sensor_id, $result )

=cut

sub provide_result {
    my ($self, $sensor_id, $result) = @_;
    
    my $measurement = $self->domain->measurement;
    
    my $sensor = $measurement->all_sensors->by_name($sensor_id)
        // $measurement->sensor_creator->new_sensor($sensor_id);
    
    $sensor->provide_measurement_result($result);
    
    $measurement->all_sensors->save($sensor);
}

=head2 sensor_by_name ( $name )

=cut

sub sensor_by_name {
}

=head2 sensors_filtered ( $to_be_defined )

=cut

sub sensors_filtered {
}

=head2 summaries_for_sensor ( $sensor_id )

=cut

sub summaries_for_sensor{
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
