USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[DayName]    Script Date: 10/12/2022 10:30:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Return the name of the week day based on Jalali date
-- =============================================
ALTER FUNCTION [jcal].[DayName]
(
	@jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN FORMAT(jcal.ToMiladi(jcal._Validate(@jDateStr)), 'dddd', 'fa-IR')
END
