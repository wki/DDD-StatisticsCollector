package StatisticsCollector::App::Role::Domain;
use Moose::Role;
use StatisticsCollector::Domain;


=head1 NAME

StatisticsCollector::App::Role::Domain - blabla

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 domain

=cut

has domain => (
    is         => 'ro',
    isa        => 'StatisticsCollector::Domain',
    lazy_build => 1,
    handles    => [
        'app',
    ]
);

sub _build_domain {
    my $self = shift;

    StatisticsCollector::Domain->instance(
      # _debug      => 'build', # build subscribe process
        storage_dir => $self->storage_dir,
    );
}

1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
