-- =============================================
-- Author:		Behdad Dalvandi
-- Creation Date: October 2022
-- Description:	This function returns the number of the day in the year based on the Jalali date.
-- =============================================
ALTER FUNCTION [jcal].[DayOfYear] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN jcal.DiffDays(jcal._Validate(@jDateStr), jcal.FirstOfYear(jcal._Validate(@jDateStr))) + 1
END
