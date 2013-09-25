package StatisticsCollector::Domain::Measurement::MeasureResultProvided;
use Moose;
use aliased 'StatisticsCollector::Domain::Common::MeasurementResult';
use namespace::autoclean;

extends 'DDD::Event';

=head1 NAME

StatisticsCollector::Domain::Measurement::MeasureResultProvided - is published
when a MeasureResult has been provided

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 measurement

=cut

has measurement => (
    is       => 'ro',
    isa      => 'T_MeasurementResult',
    coerce   => 1,
    required => 1,
);

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
