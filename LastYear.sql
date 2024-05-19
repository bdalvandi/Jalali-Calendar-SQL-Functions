USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[LastYear]    Script Date: 10/12/2022 10:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	the same date in the last year in jalali date
-- =============================================
ALTER FUNCTION [jcal].[LastYear] 
(
	@jDateStr	char(10)
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
