USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Month]    Script Date: 10/12/2022 10:31:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of the month based on jalali date
-- =============================================
ALTER FUNCTION [jcal].[Month] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 6, 2))	
END
