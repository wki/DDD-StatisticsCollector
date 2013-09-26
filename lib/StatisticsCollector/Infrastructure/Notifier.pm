package StatisticsCollector::Infrastructure::Notifier;
use Moose;
use DateTime;
use namespace::autoclean;

=head1 NAME

StatisticsCollector::Infrastructure::Notifier - abstract base class

=head1 SYNOPSIS

    $notifier->notify( $subject, $message );

=head1 DESCRIPTION

send out a notification with a given subject and a message

=head1 METHODS

=cut

=head2 notify ( $subject, $message )

send out a message

=cut

sub notify {
    die 'abstract base class -- notify() undefined';
}

=head2 notified_on

gives back the current time in a useful format for notifying

=cut

sub notified_on {
    my $self = shift;
    
    DateTime
        ->now( time_zone => 'local' )
        ->strftime('%Y-%m-%d %H:%M:%S');
}


__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
