USE [SCCIS]
GO
/****** Object:  UserDefinedFunction [jcal].[ToJalali]    Script Date: 10/12/2022 10:31:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [jcal].[ToJalali] (@date DATETIME)
	RETURNS CHAR(10)
BEGIN
	DECLARE 
		@shYear AS INT,
		@shMonth AS INT,
		@shDay AS INT,
		@intYY AS INT,
		@intMM AS INT,
		@intDD AS INT,
		@Kabiseh1 AS INT,
		@Kabiseh2 AS INT,
		@d1 AS INT,
		@m1 AS INT, 
		@shMaah AS NVARCHAR(max),
		@shRooz AS NVARCHAR(max),
		@DayCnt AS INT,
		@DayDate AS NVARCHAR(max)
		
	SET @intYY = DATEPART(yyyy, @date)
	IF @intYY < 1000 
	SET @intYY = @intYY + 2000
	SET @intMM = MONTH(@date)
	SET @intDD = DAY(@date)
	SET @shYear = @intYY - 622
	SET @DayCnt = DATEPART(dw, '01/02/' + CONVERT(CHAR(4), @intYY))
	SET @m1 = 1
	SET @d1 = 1
	SET @shMonth = 10
	SET @shDay = 11
	
	IF (@intYY - 1993) % 4 = 0
		SET @shDay = 12
		
	WHILE ( @m1 != @intMM ) OR ( @d1 != @intDD )
	BEGIN
		SET @d1 = @d1 + 1
		SET @DayCnt = @DayCnt + 1
		IF ( ( @intYY - 1992 ) % 4 = 0) 
			SET @Kabiseh1 = 1 
		ELSE 
			SET @Kabiseh1 = 0
			
		IF ( ( @shYear - 1371 ) % 4 = 0) 
			SET @Kabiseh2 = 1 
		ELSE 
			SET @Kabiseh2 = 0
			
		IF (@d1 = 32 AND (@m1 = 1 OR @m1 = 3 OR @m1 = 5 OR @m1 = 7 OR @m1 = 8 OR @m1 = 10 OR @m1 = 12))
			OR (@d1 = 31 AND (@m1 = 4 OR @m1 = 6 OR @m1 = 9 OR @m1 = 11))
			OR (@d1 = 30 AND @m1 = 2 AND @Kabiseh1 = 1)
			OR (@d1 = 29 AND @m1 = 2 AND @Kabiseh1 = 0)
		BEGIN
			SET @m1 = @m1 + 1
			SET @d1 = 1
		END
		
		IF @m1 > 12
		BEGIN
			SET @intYY = @intYY + 1
			SET @m1 = 1
		END
		
		IF @DayCnt > 7 SET @DayCnt = 1
			SET @shDay = @shDay + 1 
			
		IF (@shDay = 32 AND @shMonth < 7)
			OR (@shDay = 31 AND @shMonth > 6 AND @shMonth < 12)
			OR (@shDay = 31 AND @shMonth = 12 AND @Kabiseh2 = 1)
			OR (@shDay = 30 AND @shMonth = 12 AND @Kabiseh2 = 0)
		BEGIN
			SET @shMonth = @shMonth + 1
			SET @shDay = 1
		END
		
		IF @shMonth > 12
		BEGIN
			SET @shYear = @shYear + 1
			SET @shMonth = 1
		END
	END
	
	SET @DayDate = CONVERT(NVARCHAR(50),@shYear)+'/'+RIGHT('0' + CAST(@shMonth AS VARCHAR), 2)+'/'+RIGHT('0' + CAST(@shDay AS VARCHAR), 2)+  ' ' + LEFT(CONVERT(TIME,@date),5)
	RETURN LEFT(@DayDate, 10)
END