-- =============================================
-- Author:      Behdad Dalvandi
-- Create date: September 2022
-- Description: Returns the first day of the month in Jalali date format
-- =============================================
ALTER FUNCTION [jcal].[FirstOfMonth]
(
    @jDateStrchar(10)
)
RETURNS nvarchar(10) AS
BEGIN
RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 7) + '/01'
END
