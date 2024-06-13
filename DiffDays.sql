-- =============================================
-- Author:      Behdad Dalvandi
-- Create date: September 2022
-- Description:Calculates the number of days between 2 dates
-- =============================================
ALTER FUNCTION [jcal].[DiffDays]
(
    @jDateFrom
char(10),
    @jDateTo
char(10)
)
RETURNS int AS
BEGIN
DECLARE @gDateFrom
date
DECLARE @gDateTo
date
DECLARE @n int
SET @gDateFrom = jcal.ToMiladi(@jDateFrom)
    SET @gDateTo = jcal.ToMiladi(@jDateTo)
    SET @n = DATEDIFF(day, jcal._Validate(@gDateFrom), jcal._Validate(@gDateTo))

    RETURN @n
END
