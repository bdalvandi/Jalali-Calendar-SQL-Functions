USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[_Validate]    Script Date: 10/12/2022 10:30:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	First day of year in jalali date
-- =============================================
ALTER FUNCTION [jcal].[_Validate] 
(
	@jDateStr char(10)
)
RETURNS char(10) AS
BEGIN
	DECLARE @y int
	DECLARE @m int
	DECLARE @d int
	SET @y = CONVERT(int, SUBSTRING(@jDateStr, 1, 4))
	SET @m = CONVERT(int, SUBSTRING(@jDateStr, 6, 2))
	SET @d = CONVERT(int, SUBSTRING(@jDateStr, 9, 2))

	IF @y < 1
		RETURN cast('Jalali date is invalid' AS INT)
	IF @m > 12 OR @m < 1 OR @d < 1
		RETURN cast('Jalali date is invalid' AS INT)
	IF @m < 7 AND @d > 31
		RETURN cast('Jalali date is invalid' AS INT)
	IF @m >= 7 AND @d > 30
		RETURN cast('Jalali date is invalid' AS INT)
	IF @m = 12 AND @d > 29 AND @y NOT IN (1358, 1362, 1366, 1370, 1375, 1379, 1383, 1387, 1391, 1395, 1399, 1403, 1408, 1412, 1416, 1420, 1424, 1428, 1432, 1436, 1441, 1445, 1449, 1453, 1457, 1461, 1465, 1469, 1474, 1478, 1482, 1486, 1490, 1494)
		RETURN cast('Jalali date is invalid' AS INT)

	RETURN @jDateStr		
END
