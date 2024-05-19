USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[DateOffset]    Script Date: 10/12/2022 10:30:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	returns some days before or after the date in jalali date
-- =============================================
ALTER FUNCTION [jcal].[DateOffset] 
(
	@jDateStr	char(10),
	@offset		int
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN	jcal.ToJalali(jcal.ToMiladi(jcal._Validate(@jDateStr)) + @offset)
END
