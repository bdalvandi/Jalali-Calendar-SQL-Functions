USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[FirstOfSeason]    Script Date: 10/12/2022 10:30:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	first of the season in jalali date
-- =============================================
ALTER FUNCTION [jcal].[FirstOfSeason] 
(
	@jDateStr	char(10)
)
RETURNS char(10) AS
BEGIN
	DECLARE @mon char(2)
	DECLARE @seasonNum int

	SET @seasonNum = jcal.Season(jcal._Validate(@jDateStr))

	IF @seasonNum = 1
		SET @mon = '01'
	ELSE IF @seasonNum = 2
		SET @mon = '04'
	ELSE IF @seasonNum = 3
		SET @mon = '07'
	ELSE IF @seasonNum = 4
		SET @mon = '10'

	RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 5) + @mon + '/01'
END
