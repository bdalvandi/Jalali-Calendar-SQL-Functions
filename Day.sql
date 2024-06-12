-- =============================================
-- Author:		Behdad Dalvandi
-- Creation Date: October 2022
-- Description:	This function returns the number of the day in the month based on the Jalali date.
-- =============================================
ALTER FUNCTION [jcal].[Day] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 9, 2))	
END
