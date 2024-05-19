USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[FirstOfWeek]    Script Date: 10/12/2022 10:30:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	first day of the week in jalali date
-- =============================================
ALTER FUNCTION [jcal].[FirstOfWeek] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	DECLARE @dayNum int
	SET @dayNum = jcal.DayNumber(jcal._Validate(@jDateStr))
	RETURN jcal.ToJalali(jcal.ToMiladi(jcal._Validate(@jDateStr)) - @dayNum)
END
