USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[DayOfYear]    Script Date: 10/12/2022 10:30:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of the day in the year base on jalali date
-- =============================================
ALTER FUNCTION [jcal].[DayOfYear] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN jcal.DiffDays(jcal._Validate(@jDateStr), jcal.FirstOfYear(jcal._Validate(@jDateStr))) + 1
END
