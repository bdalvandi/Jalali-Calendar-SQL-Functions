USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[LastYearEq]    Script Date: 10/12/2022 10:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	returns the last year equivalent date in jalali date
-- =============================================
ALTER FUNCTION [jcal].[LastYearEq] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN	jcal.DateOffset(jcal._Validate(@jDateStr), -364)
END
