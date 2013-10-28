#
# wrapper.pl
#
template {
    doctype;
    
    html {
        head {
            title { 'StatisticsCollector' };
            meta_tag(name => 'viewport', content => 'width=device-width, initial-scale=1.0');
            load css => '/static/css/bootstrap.min.css';
            load css => '/static/css/site.css';
        };
        body {
            div.navbar.navbar-inverse.navbar-fixed-top {
                div.container {
                    div.navbar-header {
                        button.navbar-toggle(type => 'button', data_toggle => 'collapse', data_target => '.navbar-collapse') {
                            span.icon-bar;
                            span.icon-bar;
                            span.icon-bar;
                        };
                        a.navbar-brand (href => '#') { 'StatisticsCollector' };
                    };
                    div.collapse.navbar-collapse {
                        ul.nav.navbar-nav {
                            li.active { a(href => '#')        { 'Home'    } };
                            li        { a(href => '#about')   { 'About'   } };
                            li        { a(href => '#contact') { 'Contact' } };
                        };
                    };
                };
            };
            
            div.container {
                yield;
            };
            
            load js => '/static/js/jquery-2.0.3.min.js';
            load js => '/static/js/bootstrap.min.js';
        };
    };
};