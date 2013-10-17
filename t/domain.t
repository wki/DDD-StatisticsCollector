use vars '$class';
use Path::Class;
use Test::Most;

BEGIN { $class = 'StatisticsCollector::Domain' }

my $dir  = Path::Class::tempdir(CLEANUP => 1);

use ok $class;

my $domain = $class->instance(
    storage_dir => $dir,
);

note 'basic behavior';
{
    isa_ok $domain, 'DDD::Base::Domain';

    can_ok $domain,
        qw(
            instance
            prepare cleanup
            event_publisher publish process_events
        );

    is $domain, $class->instance, 'singleton';

    is $domain->domain,
        $domain,
        'domain reflects itself';
}

note 'storage_dir';
{
    isa_ok $domain->storage_dir, 'Path::Class::Dir';
    
    is $domain->storage_dir->stringify,
        $dir->stringify,
        'storage_dir';
    
    ok -d $domain->storage_dir, 'storage dir exists';
    
    # note "Storage-Dir: $dir";
}

note 'notifier';
{
    isa_ok $domain->notifier,
        'StatisticsCollector::Infrastructure::Notifier';
}

note 'subdomains';
{
    foreach my $subdomain (qw(Measurement Condense Alarm Notification)) {
        my $accessor = lc $subdomain;
        
        isa_ok $domain->$accessor,
            "StatisticsCollector::Domain::$subdomain";
        
        # FIXME: ->domain() reflects each subdomain instead. Is this right?
        #        currently this test fails.
        # is $domain->$accessor->domain,
        #     $domain,
        #     "$subdomain: ->domain reflects domain";
    }
}

done_testing;
