USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[MonthAt]    Script Date: 10/12/2022 10:31:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	NAME of the season in jalali date
-- =============================================
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
