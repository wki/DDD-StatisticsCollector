DDD-StatisticsCollector
=======================

A sample App based on Domain-Driven-Design principles written in Perl.


Requirements (grouped by Subdomain)
-----------------------------------

* Measurement Handling (CORE Domain):

    * A sensor device provides a measurement result as an integer value.

    * A sensor has a unique 3-part name (eg. 'tokio/bathroom/temperature'),
  every part of the name must only contain ASCII letters, '-', '_' or digits.

    * A measurement result is saved for the sending sensor including a timestamp.

    * Every sensor knows its latest measurement result.


* Measurement Condensing (Supporting Subdomain):

    * Measurement results are condensed into hourly summaries.

    * A summary contains min, max, nr_values, sum. Avg can be calculated.

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
  
    * A condition must contain at least one of (min value, max value or age).

    * If a condition contains a min value, the latest measurement result
      must be largar than this value.

    * If a condition contains a max value, the latest measurement result
      must be less than this value.

    * If a condition contains an age value, the measurement timestamp
      must have an age less than this value.

    * If a condition fails, an alarm is raised for the sensor.

    * If all conditions pass, the sensor alarm is cleared.


* Alarm Notification (Supporting Subdomain):

    * If an alarm is raised for a sensor, the administrator must be notified.

    * If an alarm is cleared for a sensor, the administrator must be notified.

    * Depending on configuration, notification may be Mail or SMS.


Domain Objects
--------------

* COMMON things (used across multiple subdomains)

    * Value 'SensorName' / Moose Type 'SensorName'
        + name
        + matches_mask(...)

    * Value 'MeasurementResult' / Moose Type 'MeasurementResult'
        + measured_on
        + result

    * Value 'Summary' (identified value)
        + from
        + to
        + min, max, sum, nr_values
        + append_result(result) : Summary


* Subdomain 'Measurement' (Core Domain - handle measurement results)

    * Event 'MeasurementResultProvided'

    * Application-Service 'MeasureService'
        + provide_result(sensor_name, result)
        + list_filtered_sensors(filter): SensorInfo[]
        + condensed_values(sensor_name, n hours/days): Summary[]

    * Repository 'AllSensors'
        + filtered(filter): SensorInfo[]
        + by_name(sensor_name): Sensor
        + save(sensor)

    * Value 'SensorInfo'
        + name: SensorName
        + result
        + alarm_info: AlarmInfo

    * Aggregate 'Sensor'
        + info: SensorInfo
        + daily_results: Summary[]  # needed for GUI ???
        + hourly_results: Summary[] # needed for GUI ???
        + provide_result(result) --> publish 'ResultProvided'

    * Value 'AlarmInfo'
        + has_alarm: Bool
        + raised_on: DateTime
        + name: Str


* Subdomain 'Condense' (Supporting Subdomain - condense provided results into hourly and daily summaries)

    * Application-Service 'CondenseService'
        + on ResultProvided => append_result
        + condense_daily        # called by batch-script after midnight

    * Repository 'Summaries'
        + summaries_for_sensor
        + save(summaries)

    * Aggregate 'SensorSummaries'
        + info: SensorInfo // alternative: name: SensorName
        + daily_results: Summary[]
        + hourly_results: Summary[]
        + append_result(result)
        + condense_daily



* Subdomain 'Alarm' (Supporting Subdomain - check alarm conditions for sensors)

    * Event 'AlarmRaised'
    
    * Event 'AlarmCleared'

    * Application-Service 'Alarm'
        + on ResultProvided => check_alarm(sensor_name)
        + check_alarm(sensor_name)
        + check_alarms_for_silent_sensors

    * Repository 'Rules'
        + all_rules_for_sensor(s): SensorRules
        + silent_sensors: SensorRules[]

    * Aggregate 'SensorRules'
        + sensor_name
        + value
        + measured_on
        + rules
        + check_for_alarm
        - raise_alarm(...)       --> publish 'AlarmRaised'
        - clear_alarm()          --> publish 'AlarmCleared'

    * Value 'Rule'
        + conditions: Condition[]
        + is_satisfied(): Bool

    * Value 'Condition'
        + is_satisfied(): Bool


* Subdomain 'Notify' (Supporting Subdomain - send out alarm notifications)

    * has notification_port

    * Application-Service 'Notification'
        + on AlarmRaised => notify
        + on AlarmCleared => notify


* Subdomain 'EventStorage' (Supporting Subdomain - save all events in an event store)

    * has message_queue_port

    * Application-Service 'Listener'
        on '*' => publish Message to message-Queue
