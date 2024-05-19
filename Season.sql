USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Season]    Script Date: 10/12/2022 10:31:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	number of the season in jalali date
-- =============================================
ALTER FUNCTION [jcal].[Season] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN (jcal.Month(jcal._Validate(@jDateStr)) - 1) / 3 +1
END
