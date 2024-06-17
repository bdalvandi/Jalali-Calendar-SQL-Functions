## Overview

The provided SQL file includes a collection of functions designed to manipulate and validate Jalali date strings. Functions such as `_ReversDate` and `_Validate` ensure the correct format and validity of the dates, while `DateOffset` adjusts dates based on specific offsets. Functions like `Day`, `Month`, and `Year` extract respective components from the Jalali date strings. Additionally, the `DayName` and `MonthName` functions return the names of the day and month in Persian, enhancing the readability of the dates. Conversion functions `ToJalali` and `ToMiladi` facilitate the transformation between Jalali and Gregorian dates. Utility functions such as `Today` and `Yesterday` provide current and previous day's dates, making the file a comprehensive toolkit for handling Jalali calendar operations in SQL Server.

# Jalali Calendar SQL Functions

This repository contains a collection of SQL functions designed to manipulate and validate Jalali date strings. These functions are implemented for use in SQL Server and provide a comprehensive toolkit for handling various operations related to the Jalali calendar system.

## Some Functions

### _ReversDate
Reverses the order of date parts in a Jalali date string using a loop to separate and rearrange the parts based on the date part separator. The final result is returned as a string in the format YYYY/MM/DD.

### _SubStrCount
Counts the occurrences of a given substring within a main text. It uses a WHILE loop and CHARINDEX function to search for the substring in the main text and increment a counter for each occurrence found.

### _Validate
Validates a Jalali date string, checking for valid year, month, and day values and considering leap years. If the date string is invalid, it returns the message "Jalali date is invalid" as an INT value; otherwise, it returns the original date string.

### DateOffset
Applies a given offset to a Jalali date string by first validating the date string, converting it to the Miladi calendar system, applying the offset, and finally converting the result back to the Jalali calendar system.

### Day
Extracts and returns the day value from a Jalali date string after validating it.

### DayName
Returns the name of the day for a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, and then formatting it in Persian language using the 'dddd' format specifier.

### DayNumber
Returns the corresponding number for the day name of a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, getting the day name in Persian language, and then mapping it to the corresponding day number (0 for Saturday, 1 for Sunday, and so on).

### DayOfYear
Calculates the day of the year for a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, and then calculating the day number within the year.

### Month
Extracts and returns the month value from a Jalali date string after validating it.

### MonthAt
Returns the month name (in Persian) for a given month number. It checks the provided month number against a series of conditions and returns the corresponding month name. If the provided month number is invalid, it returns a message indicating the invalid input.

### MonthName
Returns the month name (in Persian) for a given Jalali date string. It first validates the input date string, extracts the month part, and checks the extracted month against a series of conditions to return the corresponding month name.

### Season
Returns the season value (as an integer) for a given Jalali date string by validating the input date string, extracting the month part, subtracting 1, dividing the result by 3, and adding 1.

### SeasonName
Returns the season name (in Persian) for a given Jalali date string. It calculates the season number, checks it against a series of conditions to return the corresponding season name.

### Today
Returns the current date as a Jalali date string by converting the current date and time using the `ToJalali` function.

### ToJalali
Converts a given date to a Jalali date string by manipulating the date components using various calculations and checks.

### ToMiladi
Converts a given Jalali date string to a Gregorian date by manipulating the date components using various calculations and checks.

### WeekNumber
Calculates and returns the week number for a given Jalali date string.

### Year
Extracts the year from a given Jalali date string and returns it as an integer.

### Yesterday
Returns the Jalali date string representing yesterday's date.


# Jalali (Persian) Calendar Support for MS SQL Server

This repository provides functions to add Jalali (Persian) calendar support to MS SQL Server. The provided SQL script includes functions to convert dates between Gregorian and Jalali calendars and other utilities.

## Setup Instructions

Follow these steps to set up the Jalali calendar functions on your MS SQL Server:

1. **Download the SQL Script**
   Download the `jalali_calendar_ms_sql_server.sql` file from this repository.

2. **Open SQL Server Management Studio (SSMS)**
   Launch SSMS and connect to your SQL Server instance.

3. **Create a Schema for the Functions (Optional)**
   It is recommended to create a separate schema for better organization.
   ```sql
   CREATE SCHEMA jcal;
   GO
