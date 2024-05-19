USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[JalaliDate]    Script Date: 10/12/2022 10:31:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	First day of year in jalali date
-- =============================================
ALTER FUNCTION [jcal].[JalaliDate] 
(
	@year int,
	@month int,
	@day int
)
RETURNS char(10) AS
BEGIN
	DECLARE @y char(4) = CONVERT(char, @year)
	DECLARE @m varchar(2) = RIGHT('0' + CONVERT(varchar, @month), 2)
	DECLARE @d varchar(2) = RIGHT('0' + CONVERT(varchar, @day), 2)
	RETURN jcal._Validate(CONVERT(char(10), @y + '/' + @m + '/' + @d))
END
