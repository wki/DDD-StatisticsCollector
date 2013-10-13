package StatisticsCollector::App::ProvideMeasurement;
use Moose;
use namespace::autoclean;

extends 'parent';
with 'role';

=head1 NAME

StatisticsCollector::App::ProvideMeasurement - a commandline interface for
providing a measurement

=head1 SYNOPSIS

    provide_measurement.pl [options] rio/aussen/temperatur 42

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut



=head1 METHODS

=cut

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
