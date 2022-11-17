-- Keep a log of any SQL queries you execute as you solve the mystery.

SELECT id,street,description FROM crime_scene_reports WHERE day = "28" AND month = "7" AND street = "Humphrey Street";

--| Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |

SELECT name,day,month,year,transcript FROM interviews WHERE transcript LIKE '%bakery%' AND year = "2021" AND day = "28" AND month = "7";

/* Ruth    | 28  | 7     | 2021 | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
/* | Eugene  | 28  | 7     | 2021 | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| Raymond | 28  | 7     | 2021 | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| Emma    | 28  | 7     | 2021 | I'm the bakery owner, and someone came in, suspiciously whispering into a phone for about half an hour. They never bought anything. */

SELECT people.name, airports.city, people.phone_number FROM people
INNER JOIN bank_accounts
ON people.id = bank_accounts.person_id
INNER JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
INNER JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
INNER JOIN phone_calls ON phone_calls.caller = people.phone_number
INNER JOIN passengers ON passengers.passport_number = people.passport_number
INNER JOIN airports ON airports.id = flights.destination_airport_id
INNER JOIN flights ON flights.destination_airport_id = (SELECT destination_airport_id FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") AND year = "2021" AND month = "7" AND day = "29" ORDER BY hour, minute) WHERE flights.year = "2021" AND flights.month = "7" AND flights.day = "29" AND phone_calls.duration < '60' AND phone_calls.year = "2021" AND phone_calls.month = "7" AND phone_calls.day = "28" AND atm_location = "Leggett Street"  AND bakery_security_logs.year = "2021" AND bakery_security_logs.day = "28" AND bakery_security_logs.month = "7" AND bakery_security_logs.hour = "10" AND bakery_security_logs.minute  < "20" AND bakery_security_logs.activity = "exit" AND transaction_type = "withdraw";

-- BRUCE haha :)

SELECT name, phone_number from people WHERE phone_number = (SELECT receiver FROM phone_calls WHERE caller = (SELECT phone_number FROM people WHERE name = "Bruce") AND year = "2021" AND day = "28" AND month = "7" AND duration < "55");
/*
+-------+----------------+
| name  |  phone_number  |
+-------+----------------+
| Robin | (375) 555-8161 |
+-------+----------------+ */