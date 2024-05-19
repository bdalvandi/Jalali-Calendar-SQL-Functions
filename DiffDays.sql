USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[DiffDays]    Script Date: 10/12/2022 10:30:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of days between 2 dates
-- =============================================
ALTER FUNCTION [jcal].[DiffDays] 
(
	@jDateFrom	char(10),
	@jDateTo	char(10)
)
RETURNS int AS
BEGIN
	DECLARE @gDateFrom	date
	DECLARE @gDateTo	date
	DECLARE @n int

	SET @gDateFrom = jcal.ToMiladi(@jDateFrom)
	SET @gDateTo = jcal.ToMiladi(@jDateTo)
	SET @n = DATEDIFF(day, jcal._Validate(@gDateFrom), jcal._Validate(@gDateTo))

	RETURN @n
END
