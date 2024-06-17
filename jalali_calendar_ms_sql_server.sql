-- This function reverses the order of date parts in a Jalali date string, using a loop to separate and rearrange the parts based on the date part separator. The final result is returned as a string in the format YYYY/MM/DD.
ALTER FUNCTION [jcal].[_ReversDate] (@DateStr varchar(10))
RETURNS varchar(10) AS
BEGIN
DECLARE @TempStr varchar(10)
    DECLARE @StartIndex int
DECLARE @SubStrLen int
DECLARE @i int
SET @TempStr = ''
SET @StartIndex = LEN(@DateStr) + 2
SET @i = LEN(@DateStr)
    
    WHILE @i > 0
BEGIN
IF SUBSTRING(@DateStr,@i,1) IN ('/', '-')
        BEGIN
SET @SubStrLen = @StartIndex - (@i + 2)
            SET @StartIndex = @i + 1
SET @TempStr = @TempStr + SUBSTRING(@DateStr,@StartIndex,@SubStrLen) + SUBSTRING(@DateStr,@i,1)
        END
SET @i = @i - 1
END
IF @TempStr <> ''
BEGIN
SET @SubStrLen = @StartIndex - 2
SET @TempStr = @TempStr + SUBSTRING(@DateStr,1,@SubStrLen)
    END
ELSE
BEGIN
SET @TempStr = @DateStr
END
RETURN @TempStr
END


-- This function counts the occurrences of a given substring within a main text. It uses a WHILE loop and CHARINDEX function to search for the substring in the main text and increment a counter for each occurrence found.
ALTER FUNCTION [jcal].[_SubStrCount] (@SubStr varchar(8000), @MainText Text)
RETURNS int
AS
BEGIN
DECLARE @StrCount int
DECLARE @StrPos int
SET @StrCount = 0
SET @StrPos = 0
SET @StrPos = CHARINDEX( @SubStr, @MainText, @StrPos)
 
  WHILE @StrPos > 0
BEGIN
SET @StrCount = @StrCount + 1
SET @StrPos = CHARINDEX( @SubStr, @MainText, @StrPos+1)
  END
RETURN @StrCount
END


-- This function validates a Jalali date string, checking for valid year, month, and day values and considering leap years. If the date string is invalid, it returns the message "Jalali date is invalid" as an INT value; otherwise, it returns the original date string.
ALTER FUNCTION [jcal].[_Validate]
(
  @jDateStr char(10)
)
RETURNS char(10) AS
BEGIN
DECLARE @y int
DECLARE @m int
DECLARE @d int
SET @y = CONVERT(int, SUBSTRING(@jDateStr, 1, 4))
  SET @m = CONVERT(int, SUBSTRING(@jDateStr, 6, 2))
  SET @d = CONVERT(int, SUBSTRING(@jDateStr, 9, 2))

  IF @y < 1
RETURN cast('Jalali date is invalid' AS INT)
  IF @m > 12 OR @m < 1 OR @d < 1
RETURN cast('Jalali date is invalid' AS INT)
  IF @m < 7 AND @d > 31
RETURN cast('Jalali date is invalid' AS INT)
  IF @m >= 7 AND @d > 30
RETURN cast('Jalali date is invalid' AS INT)
  IF @m = 12 AND @d > 29 AND @y NOT IN (1358, 1362, 1366, 1370, 1375, 1379, 1383, 1387, 1391, 1395, 1399, 1403, 1408, 1412, 1416, 1420, 1424, 1428, 1432, 1436, 1441, 1445, 1449, 1453, 1457, 1461, 1465, 1469, 1474, 1478, 1482, 1486, 1490, 1494)
    RETURN cast('Jalali date is invalid' AS INT)

  RETURN @jDateStr
END


-- This function applies a given offset to a Jalali date string by first validating the date string, converting it to the Miladi calendar system, applying the offset, and finally converting the result back to the Jalali calendar system.
ALTER FUNCTION [jcal].[DateOffset]
(
  @jDateStr char(10),
  @offset
int
)
RETURNS nvarchar(10) AS
BEGIN
RETURN
jcal.ToJalali(jcal.ToMiladi(jcal._Validate(@jDateStr)) + @offset)
END


-- This function extracts and returns the day value from a Jalali date string after validating it.
ALTER FUNCTION [jcal].[Day]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 9, 2)) 
END


-- This function returns the name of the day for a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, and then formatting it in Persian language using the 'dddd' format specifier.
ALTER FUNCTION [jcal].[DayName]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
RETURN FORMAT(jcal.ToMiladi(jcal._Validate(@jDateStr)), 'dddd', 'fa-IR')
END


-- This function returns the corresponding number for the day name of a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, getting the day name in Persian language, and then mapping it to the corresponding day number (0 for Saturday, 1 for Sunday, and so on).
ALTER FUNCTION [jcal].[DayNumber]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
DECLARE @name nvarchar(10)
  DECLARE @num int
SET @name = FORMAT(jcal.ToMiladi(jcal._Validate(@jDateStr)), 'dddd', 'fa-IR')

  IF @name = 'شنبه'
SET @num = 0
ELSE IF @name = 'يكشنبه'
SET @num = 1
ELSE IF @name = 'دوشنبه'
SET @num = 2
ELSE IF @name = 'سه شنبه'
SET @num = 3
ELSE IF @name = 'چهارشنبه'
SET @num = 4
ELSE IF @name = 'پنجشنبه'
SET @num = 5
ELSE IF @name = 'جمعه'
SET @num = 6
RETURN @num
END


-- This function returns the day of the week for a given Jalali date string by first validating the date string, converting it to the Miladi calendar system, getting the day name in Persian language, mapping it to the corresponding day number (0 for Saturday, 1 for Sunday, and so on), and then returning the value incremented by 1 to align with SQL Server's day of week values (1 for Monday, 2 for Tuesday, and so on).
ALTER FUNCTION [jcal].[DayOfWeek]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
DECLARE @name nvarchar(10)
  DECLARE @num int
SET @name = FORMAT(jcal.ToMiladi(jcal._Validate(@jDateStr)), 'dddd', 'fa-IR')

  IF @name = 'شنبه'
SET @num = 0
ELSE IF @name = 'يكشنبه'
SET @num = 1
ELSE IF @name = 'دوشنبه'
SET @num = 2
ELSE IF @name = 'سه شنبه'
SET @num = 3
ELSE IF @name = 'چهارشنبه'
SET @num = 4
ELSE IF @name = 'پنجشنبه'
SET @num = 5
ELSE IF @name = 'جمعه'
SET @num = 6
RETURN @num + 1
END


-- This function returns the day of the year for a given Jalali date string by first validating the date string and then calculating the number of days between the input date and the first day of the year (in the Jalali calendar) and adding 1 to the result.
ALTER FUNCTION [jcal].[DayOfYear]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
RETURN jcal.DiffDays(jcal._Validate(@jDateStr), jcal.FirstOfYear(jcal._Validate(@jDateStr))) + 1
END


-- This function calculates the number of days between two given Jalali date strings. It first validates the input date strings, converts them to Miladi dates, and then uses the DATEDIFF function to calculate the difference in days between the two dates.
ALTER FUNCTION [jcal].[DiffDays]
(
  @jDateFrom
char(10),
  @jDateTo
char(10)
)
RETURNS int AS
BEGIN
DECLARE @gDateFrom
date
DECLARE @gDateTo
date
DECLARE @n int
SET @gDateFrom = jcal.ToMiladi(@jDateFrom)
  SET @gDateTo = jcal.ToMiladi(@jDateTo)
  SET @n = DATEDIFF(day, jcal._Validate(@gDateFrom), jcal._Validate(@gDateTo))

  RETURN @n
END


-- This function returns the first day of the month for a given Jalali date string by validating the input date string, extracting the year and month parts, and appending '/01' to represent the first day of the month.
ALTER FUNCTION [jcal].[FirstOfMonth]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 7) + '/01'
END


-- This function returns the first day of the season for a given Jalali date string by first validating the date string, determining the season number, and then setting the month value based on the season number. The function constructs and returns the first day of the corresponding season's starting month.
ALTER FUNCTION [jcal].[FirstOfSeason]
(
  @jDateStr char(10)
)
RETURNS char(10) AS
BEGIN
DECLARE @mon char(2)
  DECLARE @seasonNum int
SET @seasonNum = jcal.Season(jcal._Validate(@jDateStr))

  IF @seasonNum = 1
SET @mon = '01'
ELSE IF @seasonNum = 2
SET @mon = '04'
ELSE IF @seasonNum = 3
SET @mon = '07'
ELSE IF @seasonNum = 4
SET @mon = '10'
RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 5) + @mon + '/01'
END


-- This function returns the first day of the week for a given Jalali date string by first validating the date string, calculating the corresponding day number within the week, and then subtracting this number from the Jalali date to find the first day of the week.
ALTER FUNCTION [jcal].[FirstOfWeek]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
DECLARE @dayNum int
SET @dayNum = jcal.DayNumber(jcal._Validate(@jDateStr))
  RETURN jcal.ToJalali(jcal.ToMiladi(jcal._Validate(@jDateStr)) - @dayNum)
END


-- This function returns the first day of the year for a given Jalali date string by validating the input date string, extracting the year part, and appending '/01/01' to represent the first day of the year.
ALTER FUNCTION [jcal].[FirstOfYear]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 4) + '/01/01'
END


-- This function constructs and returns a full Jalali date string for a given Jalali date by validating the input date string, extracting the year, month, and day parts, getting the month name and day name, and then combining these components into the desired format.
ALTER FUNCTION [jcal].[FullDate]
(
  @jDateStr char(10)
)
RETURNS nvarchar(30) AS
BEGIN
DECLARE @y char(4) = LEFT(jcal._Validate(@jDateStr), 4)
  DECLARE @m nvarchar(10) = jcal.MonthAt(jcal.Month(@jDateStr))
  DECLARE @d char(2) = CONVERT(char, jcal.Day(@jDateStr))
  DECLARE @w nvarchar(10) = jcal.DayName(@jDateStr)
  
  RETURN @w + ' ' + @d + ' ' + @m + ' ' + @y
END


-- This function constructs and validates a Jalali date string from given year, month, and day integer values. It formats each component to ensure leading zeroes and correct length, combines them into a Jalali date string, and then validates the constructed string.
ALTER FUNCTION [jcal].[JalaliDate]
(
  @year int,
  @month int,
  @day int
)
RETURNS char(10) AS
BEGIN
DECLARE @y char(4) = CONVERT(char, @year)
  DECLARE @m varchar(2) = RIGHT('0' + CONVERT(varchar, @month), 2)
  DECLARE @d varchar(2) = RIGHT('0' + CONVERT(varchar, @day), 2)
  RETURN jcal._Validate(CONVERT(char(10), @y + '/' + @m + '/' + @d))
END


-- This function returns the Jalali date string for the last day of the previous year given a Jalali date string. It first validates the input date string, extracts the year component and decreases it by one, and then reconstructs the Jalali date string using this new year value, considering the edge case where the input date is the last day of the year.
ALTER FUNCTION [jcal].[LastYear]
(
  @jDateStr char(10)
)
RETURNS char(10) AS
BEGIN
DECLARE @year char(4)
  DECLARE @dateStr char(10)

  SET @year = CONVERT(CHAR(4), jcal.Year(jcal._Validate(@jDateStr)) - 1)
  
  IF SUBSTRING(@jDateStr, 6, 5) = '12/30'
SET @dateStr = @year + '/12/29'
ELSE
SET @dateStr = @year + SUBSTRING(@jDateStr, 5, 6)

  RETURN @dateStr
END


-- This function returns the Jalali date string for the same day and month in the previous year given a Jalali date string. It first validates the input date string and then subtracts 364 days from the validated date to find the desired date in the previous year.
ALTER FUNCTION [jcal].[LastYearEq]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
RETURN
jcal.DateOffset(jcal._Validate(@jDateStr), -364)
END


-- This function returns the month value (as an integer) for a given Jalali date string by first validating the input date string and then extracting the month part using the SUBSTRING function and converting it to an integer.
ALTER FUNCTION [jcal].[Month]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 6, 2)) 
END


-- This function returns the month name (in Persian) for a given month number. It checks the provided month number against a series of conditions and returns the corresponding month name. If the provided month number is invalid, it returns a message indicating the invalid input.
ALTER FUNCTION [jcal].[MonthAt]
(
  @monthId int
)
RETURNS nvarchar(10) AS
BEGIN
DECLARE @monthName nvarchar(10)

  IF @monthId = 1 SET @monthName = 'فروردین'
ELSE IF @monthId = 2 SET @monthName = 'اردیبهشت'
ELSE IF @monthId = 3 SET @monthName = 'خرداد'
ELSE IF @monthId = 4 SET @monthName = 'تیر'
ELSE IF @monthId = 5 SET @monthName = 'مرداد'
ELSE IF @monthId = 6 SET @monthName = 'شهریور'
ELSE IF @monthId = 7 SET @monthName = 'مهر'
ELSE IF @monthId = 8 SET @monthName = 'آبان'
ELSE IF @monthId = 9 SET @monthName = 'آذر'
ELSE IF @monthId = 10 SET @monthName = 'دی '
ELSE IF @monthId = 11 SET @monthName = 'بهمن'
ELSE IF @monthId = 12 SET @monthName = 'اسفند'
ELSE RETURN CAST('Month number is invalid.' as int)

  RETURN @monthName
END


-- This function returns the month name (in Persian) for a given Jalali date string. It first validates the input date string, extracts the month part, and checks the extracted month against a series of conditions to return the corresponding month name.
ALTER FUNCTION [jcal].[MonthName]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
DECLARE @monthNum char(2)
  DECLARE @monthName nvarchar(10)

  SET @monthNum = SUBSTRING(jcal._Validate(@jDateStr), 6, 2)
  IF @monthNum = '01'
SET @monthName = 'فروردین'
ELSE IF @monthNum = '02'
SET @monthName = 'اردیبهشت'
ELSE IF @monthNum = '03'
SET @monthName = 'خرداد'
ELSE IF @monthNum = '04'
SET @monthName = 'تیر'
ELSE IF @monthNum = '05'
SET @monthName = 'مرداد'
ELSE IF @monthNum = '06'
SET @monthName = 'شهریور'
ELSE IF @monthNum = '07'
SET @monthName = 'مهر'
ELSE IF @monthNum = '08'
SET @monthName = 'آبان'
ELSE IF @monthNum = '09'
SET @monthName = 'آذر'
ELSE IF @monthNum = '10'
SET @monthName = 'دی'
ELSE IF @monthNum = '11'
SET @monthName = 'بهمن'
ELSE IF @monthNum = '12'
SET @monthName = 'اسفند'
RETURN @monthName
END


-- This function returns the season value (as an integer) for a given Jalali date string by validating the input date string, extracting the month part, subtracting 1, dividing the result by 3, and adding 1.
ALTER FUNCTION [jcal].[Season]
(
  @jDateStr char(10)
)
RETURNS int AS
BEGIN
RETURN (jcal.Month(jcal._Validate(@jDateStr)) - 1) / 3 + 1
END


-- This function returns the season name (in Persian) for a given Jalali date string. It calculates the season number, checks it against a series of conditions to return the corresponding season name.
ALTER FUNCTION [jcal].[SeasonName]
(
  @jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
DECLARE @seasonNum int
DECLARE @seasonName nvarchar(10)

  SET @seasonNum = (jcal.Month(jcal._Validate(@jDateStr)) - 1) / 3 + 1
IF @seasonNum = 1
SET @seasonName = 'بهار'
ELSE IF @seasonNum = 2
SET @seasonName = 'تابستان'
ELSE IF @seasonNum = 3
SET @seasonName = 'پاییز'
ELSE IF @seasonNum = 4
SET @seasonName = 'زمستان'
RETURN @seasonName
END


-- This function returns the current date as a Jalali date string by converting the current date and time using the `ToJalali` function.
ALTER FUNCTION [jcal].[Today]
()
RETURNS nvarchar(10) AS
BEGIN
RETURN jcal.ToJalali(getdate())
END


-- This function converts a given date to a Jalali date string by manipulating the date components using various calculations and checks.
ALTER FUNCTION [jcal].[ToJalali] (@date DATETIME)
  RETURNS CHAR(10)
BEGIN
  DECLARE 
    @shYear AS INT,
    @shMonth AS INT,
    @shDay AS INT,
    @intYY AS INT,
    @intMM AS INT,
    @intDD AS INT,
    @Kabiseh1 AS INT,
    @Kabiseh2 AS INT,
    @d1 AS INT,
    @m1 AS INT, 
    @shMaah AS NVARCHAR(max),
    @shRooz AS NVARCHAR(max),
    @DayCnt AS INT,
    @DayDate AS NVARCHAR(max)
    
  SET @intYY = DATEPART(yyyy, @date)
  IF @intYY < 1000 
  SET @intYY = @intYY + 2000
  SET @intMM = MONTH(@date)
  SET @intDD = DAY(@date)
  SET @shYear = @intYY - 622
  SET @DayCnt = DATEPART(dw, '01/02/' + CONVERT(CHAR(4), @intYY))
  SET @m1 = 1
  SET @d1 = 1
  SET @shMonth = 10
  SET @shDay = 11
  
  IF (@intYY - 1993) % 4 = 0
    SET @shDay = 12
    
  WHILE ( @m1 != @intMM ) OR ( @d1 != @intDD )
  BEGIN
    SET @d1 = @d1 + 1
    SET @DayCnt = @DayCnt + 1
    IF ( ( @intYY - 1992 ) % 4 = 0) 
      SET @Kabiseh1 = 1 
    ELSE 
      SET @Kabiseh1 = 0
      
    IF ( ( @shYear - 1371 ) % 4 = 0) 
      SET @Kabiseh2 = 1 
    ELSE 
      SET @Kabiseh2 = 0
      
    IF (@d1 = 32 AND (@m1 = 1 OR @m1 = 3 OR @m1 = 5 OR @m1 = 7 OR @m1 = 8 OR @m1 = 10 OR @m1 = 12))
      OR (@d1 = 31 AND (@m1 = 4 OR @m1 = 6 OR @m1 = 9 OR @m1 = 11))
      OR (@d1 = 30 AND @m1 = 2 AND @Kabiseh1 = 1)
      OR (@d1 = 29 AND @m1 = 2 AND @Kabiseh1 = 0)
    BEGIN
      SET @m1 = @m1 + 1
      SET @d1 = 1
    END
    
    IF @m1 > 12
    BEGIN
      SET @intYY = @intYY + 1
      SET @m1 = 1
    END
    
    IF @DayCnt > 7 SET @DayCnt = 1
      SET @shDay = @shDay + 1 
      
    IF (@shDay = 32 AND @shMonth < 7)
      OR (@shDay = 31 AND @shMonth > 6 AND @shMonth < 12)
      OR (@shDay = 31 AND @shMonth = 12 AND @Kabiseh2 = 1)
      OR (@shDay = 30 AND @shMonth = 12 AND @Kabiseh2 = 0)
    BEGIN
      SET @shMonth = @shMonth + 1
      SET @shDay = 1
    END
    
    IF @shMonth > 12
    BEGIN
      SET @shYear = @shYear + 1
      SET @shMonth = 1
    END
  END
  
  SET @DayDate = CONVERT(NVARCHAR(50),@shYear)+'/'+RIGHT('0' + CAST(@shMonth AS VARCHAR), 2)+'/'+RIGHT('0' + CAST(@shDay AS VARCHAR), 2)+  ' ' + LEFT(CONVERT(TIME,@date),5)
  RETURN LEFT(@DayDate, 10)
END


-- This function converts a given Jalali date string to a Gregorian date by manipulating the date components using various calculations and checks.
ALTER FUNCTION [jcal].[ToMiladi](@DateStr varchar(10)) 
RETURNS DATETIME AS  
BEGIN 
   declare @YYear int
   declare @MMonth int
   declare @DDay int
   declare @epbase int
   declare @epyear int
   declare @mdays int
   declare @persian_jdn int
   declare @i int
   declare @j int
   declare @l int
   declare @n int
   declare @TMPRESULT varchar(10)
   declare @IsValideDate int
   declare @TempStr varchar(20)
   DECLARE @TmpDateStr varchar(10)
   
   SET @i=charindex('/',jcal._Validate(@DateStr))
   
   IF LEN(@DateStr) - CHARINDEX('/', @DateStr,CHARINDEX('/', @DateStr,1)+1) = 4
   BEGIN
     SET @TmpDateStr = jcal._ReversDate(@DateStr)
     IF ( ISDATE(@TmpDateStr) =1 )  
       RETURN @TmpDateStr
     ELSE
        RETURN NULL
   END
   ELSE
     SET @TmpDateStr = @DateStr
  
   IF ((@i<>0) and
       (jcal._SubStrCount('/', @TmpDateStr)=2) and
        (ISNUMERIC(REPLACE(@TmpDateStr,'/',''))=1) and 
        (charindex('.',@TmpDateStr)=0)
       )
   BEGIN
       SET @YYear=CAST(SUBSTRING(@TmpDateStr,1,@i-1) AS INT)
                IF ( @YYear< 1300 )
                      SET @YYear =@YYear + 1300
                IF @YYear > 9999
                  RETURN NULL
  
       SET @TempStr= SUBSTRING(@TmpDateStr,@i+1,Len(@TmpDateStr))
  
       SET @i=charindex('/',@TempStr)
       SET @MMonth=CAST(SUBSTRING(@TempStr,1,@i-1) AS INT)
       SET @MMonth=@MMonth-- -1
  
       SET @TempStr= SUBSTRING(@TempStr,@i+1,Len(@TempStr))   
  
       SET @DDay=CAST(@TempStr AS INT)
       SET @DDay=@DDay-- - 1
  
                 IF ( @YYear >= 0 )
                     SET @epbase = @YYear - 474
                 Else
                     SET @epbase = @YYear - 473
                 SET @epyear = 474 + (@epbase % 2820)
  
        IF (@MMonth <= 7 )
                       SET @mdays = ((@MMonth) - 1) * 31
        Else
            SET @mdays = ((@MMonth) - 1) * 30 + 6
  
        SET @persian_jdn =(@DDay) + @mdays + CAST((((@epyear * 682) - 110) / 2816) as int) + (@epyear - 1) * 365 + CAST((@epbase / 2820) as int ) * 1029983 + (1948321 - 1)  
        IF (@persian_jdn > 2299160) 
        BEGIN
            SET @l = @persian_jdn + 68569
            SET @n = CAST(((4 * @l) / 146097) as int)
            SET @l = @l - CAST(((146097 * @n + 3) / 4) as int)
            SET @i = CAST(((4000 * (@l + 1)) / 1461001) as int)
            SET @l = @l - CAST( ((1461 * @i) / 4) as int) + 31
            SET @j = CAST(((80 * @l) / 2447) as int)
            SET @DDay = @l - CAST( ((2447 * @j) / 80) as int)
            SET @l = CAST((@j / 11) as int)
            SET @MMonth = @j + 2 - 12 * @l
            SET @YYear = 100 * (@n - 49) + @i + @l
        END  
        SET @TMPRESULT=Cast(@MMonth as varchar(2))+'/'+CAST(@DDay as Varchar(2))+'/'+CAST(@YYear as varchar(4))  
        RETURN Cast(@TMPRESULT as Datetime)  
    END
    RETURN NULL  
END


-- This function calculates and returns the week number for a given Jalali date string
ALTER FUNCTION [jcal].[WeekNumber]
(
    @jDateStr CHAR(10)
)
RETURNS INT
AS
BEGIN
RETURN jcal.DiffDays(jcal.FirstOfWeek(jcal.FirstOfYear(@jDateStr)), jcal.FirstOfWeek(@jDateStr)) / 7
END


-- This function extracts the year from a given Jalali date string and returns it as an integer
ALTER FUNCTION [jcal].[Year]
(
    @jDateStr CHAR(10)
)
RETURNS INT
AS
BEGIN
    ETURN CONVERT(INT, SUBSTRING(jcal._Validate(@jDateStr), 1, 4))
END


-- This function returns the Jalali date string representing yesterday's date
ALTER FUNCTION [jcal].[Yesterday]
()
RETURNS NVARCHAR(10)
AS
BEGIN
    RETURN jcal.ToJalali(GETDATE() - 1)
END
