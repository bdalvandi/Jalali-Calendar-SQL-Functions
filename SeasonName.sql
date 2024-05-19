USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[SeasonName]    Script Date: 10/12/2022 10:31:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	NAME of the season in jalali date
-- =============================================
ALTER FUNCTION [jcal].[SeasonName] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	DECLARE @seasonNum int
	DECLARE @seasonName nvarchar(10)

	SET @seasonNum = (jcal.Month(jcal._Validate(@jDateStr)) - 1) / 3 + 1

	IF @seasonNum = 1
		SET @seasonName = 'بهار'
	ELSE IF @seasonNum = 2
		SET @seasonName = 'تابستان'
	ELSE IF @seasonNum = 3
		SET @seasonName = 'پاییز'
	ELSE IF @seasonNum = 4
		SET @seasonName = 'زمستان'

	RETURN @seasonName
END
