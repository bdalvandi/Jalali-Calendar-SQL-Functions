USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[FirstOfMonth]    Script Date: 10/12/2022 10:30:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	returns first of month in jalali date
-- =============================================
ALTER FUNCTION [jcal].[FirstOfMonth] 
(
	@jDateStr	char(10)
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN SUBSTRING(jcal._Validate(@jDateStr), 1, 7) + '/01'
END
