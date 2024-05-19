USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Year]    Script Date: 10/12/2022 10:31:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	Number of the year based on jalali date
-- =============================================
ALTER FUNCTION [jcal].[Year] 
(
	@jDateStr	char(10)
)
RETURNS int AS
BEGIN
	RETURN CONVERT(int, SUBSTRING(jcal._Validate(@jDateStr), 1, 4))	
END
