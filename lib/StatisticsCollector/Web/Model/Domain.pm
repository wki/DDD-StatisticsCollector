package StatisticsCollector::Web::Model::Domain;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::DDD';

=head1 NAME

StatisticsCollector::Web::Model::Domain - access our domain from catalyst

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
