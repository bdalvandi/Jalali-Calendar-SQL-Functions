-- =============================================
-- Author:      Behdad Dalvandi
-- Create date: September 2022
-- Description:Returns the first day of the season in Jalali date format
-- =============================================
ALTER FUNCTION [jcal].[FirstOfSeason]
(
	@jDateStr char(10)
)
RETURNS char(10) AS
BEGIN
DECLARE @mon
char(2)
    DECLARE @seasonNumint
SET @seasonNum = jcal.Season(jcal._Validate(@jDateStr))

    IF @seasonNum = 1
SET @mon = '01'ELSE IF @seasonNum = 2
SET @mon = '04'ELSE IF @seasonNum = 3
SET @mon = '07'ELSE IF @seasonNum = 4
SET @mon = '10'RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 5) + @mon + '/01'
END
