-- =============================================
-- Author:		Behdad Dalvandi
-- Creation Date: October 2022
-- Description:	This function returns the name of the weekday based on the Jalali date.
-- =============================================
ALTER FUNCTION [jcal].[DayName]
(
	@jDateStr char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN FORMAT(jcal.ToMiladi(jcal._Validate(@jDateStr)), 'dddd', 'fa-IR')
END
