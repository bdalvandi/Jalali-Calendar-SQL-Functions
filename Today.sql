USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[Today]    Script Date: 10/12/2022 10:31:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Behdad Dalvandi
-- Create date: 1401/07/18
-- Description:	returns today in jalali date
-- =============================================
ALTER FUNCTION [jcal].[Today] 
(
)
RETURNS nvarchar(10) AS
BEGIN
	RETURN jcal.ToJalali(getdate())
END
