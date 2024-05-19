USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[_SubStrCount]    Script Date: 10/12/2022 10:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [jcal].[_SubStrCount](@SubStr varchar(8000), @MainText Text)  
RETURNS int 
AS  
BEGIN 
  DECLARE @StrCount int
  DECLARE @StrPos int
 
  SET @StrCount = 0
  SET @StrPos = 0
  SET @StrPos = CHARINDEX( @SubStr, @MainText, @StrPos)
 
  WHILE @StrPos > 0
  BEGIN
    SET @StrCount = @StrCount + 1
    SET @StrPos = CHARINDEX( @SubStr, @MainText, @StrPos+1)
  END
 
  RETURN @StrCount  
END
