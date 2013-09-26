package StatisticsCollector::Infrastructure::Notifier::Memory;
use Moose;
use MooseX::Types::Path::Class 'File';
use Path::Class;
use namespace::autoclean;

extends 'StatisticsCollector::Infrastructure::Notifier';

=head1 NAME

StatisticsCollector::Infrastructure::Notifier::File - memory notifier

=head1 SYNOPSIS

=head1 DESCRIPTION

mainly for testing, does not report anything to the world outside

=head1 ATTRIBUTES

=cut

has messages => (
    traits  => ['Array'],
    is      => 'ro',
    isa     => 'ArrayRef',
    default => sub { [] },
    handles => {
        add_message => 'push',
    },
);

=head1 METHODS

=cut

=head2 notify ( $subject, $message )

append the given message to the file specified above

=cut

sub notify {
    my ($self, $subject, $message) = @_;
    
    $self->add_message(
        sprintf '[%s] %s: %s',
            $self->notified_on,
            $subject,
            $message
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
