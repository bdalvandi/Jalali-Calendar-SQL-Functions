USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[FirstOfYear]    Script Date: 10/12/2022 10:30:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	First day of year in jalali date
-- =============================================
ALTER FUNCTION [jcal].[FirstOfYear] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 4) + '/01/01'
END
