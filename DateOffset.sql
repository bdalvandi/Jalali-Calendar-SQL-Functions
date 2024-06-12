-- =============================================
-- Author:		Behdad Dalvandi
-- Creation Date: October 2022
-- Description:	This function returns a Jalali date that is a specified number of days before or after a given Jalali date.
-- =============================================
ALTER FUNCTION [jcal].[DateOffset] 
(
	@jDateStr	char(10),
	@offset		int
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN	jcal.ToJalali(jcal.ToMiladi(jcal._Validate(@jDateStr)) + @offset)
END
