USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[FullDate]    Script Date: 10/12/2022 10:30:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	RETURNS FULL DATE STRING 
-- =============================================
ALTER FUNCTION [jcal].[FullDate] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(30) AS
BEGIN
	DECLARE @y char(4) = LEFT(jcal._Validate(@jDateStr), 4)
	DECLARE @m nvarchar(10) = jcal.MonthAt(jcal.Month(@jDateStr))
	DECLARE @d char(2) = CONVERT(char, jcal.Day(@jDateStr))
	DECLARE @w nvarchar(10) = jcal.DayName(@jDateStr)
	
	RETURN @w + ' ' + @d + ' ' + @m + ' ' + @y
END
