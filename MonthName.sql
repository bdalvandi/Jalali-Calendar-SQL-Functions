USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[MonthName]    Script Date: 10/12/2022 10:31:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Name of the month based on jalali date
-- =============================================
ALTER FUNCTION [jcal].[MonthName] 
(
	@jDateStr	char(10)
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
