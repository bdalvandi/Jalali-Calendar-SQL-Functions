USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Day]    Script Date: 10/12/2022 10:55:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of week of the date in jalali date
-- =============================================
ALTER FUNCTION [jcal].[WeekNumber] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN jcal.DiffDays(jcal.FirstOfWeek(jcal.FirstOfYear(@jDateStr)), jcal.FirstOfWeek(@jDateStr)) / 7
END
