DDD-StatisticsCollector
=======================

A sample App based on Domain-Driven-Design principles written in Perl.


Requirements (grouped by Subdomain)
-----------------------------------

* Measurement Handling (CORE Domain):

    * A sensor device provides a measurement result as an integer value.

    * A sensor has a unique 3-part name (eg. 'tokio/bathroom/temperature'),
  every part of the name must only contain ASCII letters, '-', '\_' or digits.

    * A measurement consists of the result and the timestamp it was measured on.

    * Every sensor knows its latest measurement.


* Measurement Condensing (Supporting Subdomain):

    * Measurement results are condensed into hourly summaries.

    * A summary contains min, max, nr\_values, sum. Avg can be calculated.

    * Hourly summaries older than 3 days are further condensed to daily summaries.

    * Daily summaries older than 3 years are deleted.


* Alarm Checking (Supporting Subdomain):

    * After a measurement result was saved, an alarm-check must occur.
  
    * On a regular base, an alarm-check for maybe inactive sensors must occur.

    * Alarm rules define a sensor mask and conditions to check.

    * The sensor mask contains a slash-delimited name with wildcards
      (eg: '*/*/temperature').

    * More specific sensor masks take precedence over less specific sensor masks.
      (x/*/* is more specific than */x/* but less specific than x/y/*).

    * All conditions of a rule are checked against the latest measurement result.
  
    * A condition may either check min, max or age.

    * If a condition fails, an alarm is raised for the sensor.

    * If all conditions pass, the sensor alarm is cleared.


* Alarm Notification (Supporting Subdomain):

    * If an alarm is raised for a sensor, the administrator must be notified.

    * If an alarm is cleared for a sensor, the administrator must be notified.

    * Depending on configuration, notification may be Mail or SMS.


Subdomains
----------

* Measurement

  handles saving a provided measurement result for a sensor and allows filtered
  listing sensors.

* Condense

  condenses new measurements into hourly and daily summaries

* Alarm

  detects alarms to get raised or cleared for a sensor

* Notification

  sends out notification messages based on raised or cleared alarms


Messages passed
---------------

* Measurement::MeasurementProvided

  sent out immediate after a new measurement result has been provided.

* Alarm::AlarmRaised / Alarm::AlarmCleared

  sent out after an alarm for a sensor raised or cleared.
    
