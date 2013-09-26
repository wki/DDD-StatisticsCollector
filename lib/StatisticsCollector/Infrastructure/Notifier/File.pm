package StatisticsCollector::Infrastructure::Notifier::File;
use Moose;
use MooseX::Types::Path::Class 'File';
use Path::Class;
use namespace::autoclean;

extends 'StatisticsCollector::Infrastructure::Notifier';

=head1 NAME

StatisticsCollector::Infrastructure::Notifier::File - file appending notifier

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

has file => (
    is       => 'ro',
    isa      => File,
    coerce   => 1,
    required => 1,
);

=head1 METHODS

=cut

=head2 notify ( $subject, $message )

append the given message to the file specified above

=cut

sub notify {
    my ($self, $subject, $message) = @_;
    
    my $fh = $self->file->opena
        or die "cannot open '${\$self->file}' for appending: $!";
    
    printf $fh "[%s] %s: %s\n",
        $self->notified_on,
        $subject,
        $message;
    
    $fh->close;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
