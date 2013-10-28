#
# index.pl
#
template {
    h2 { 'Sensors' };
    table.table {
        thead {
            trow {
                th { 'Sensor' };
                th { 'Latest measure' };
                th { 'Result' };
            };
        };
        tbody {
            foreach my $sensor (@{stash->{sensors}}) {
                trow {
                    tcol { 
                        $sensor->sensor_id->name 
                    };
                    tcol { 
                        $sensor->latest_measurement->measured_on->strftime('%d.%m.%Y %H:%M')
                    };
                    tcol { 
                        $sensor->latest_measurement->result 
                    };
                };
            }
        };
    };
};
