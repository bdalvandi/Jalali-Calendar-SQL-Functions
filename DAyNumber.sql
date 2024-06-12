-- =============================================
-- Author:		Behdad Dalvandi
-- Creation Date: October 2022
-- Description:	This function returns the number of the weekday based on the Jalali date.
-- =============================================
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
	ELSE IF @name = 'سه شنبه'
		SET @num = 3
	ELSE IF @name = 'چهارشنبه'
		SET @num = 4
	ELSE IF @name = 'پنجشنبه'
		SET @num = 5
	ELSE IF @name = 'جمعه'
		SET @num = 6
	RETURN @num
END
