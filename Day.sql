USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Day]    Script Date: 10/12/2022 10:30:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of the day in month based on jalali date
-- =============================================
ALTER FUNCTION [jcal].[Day] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 9, 2))	
END
