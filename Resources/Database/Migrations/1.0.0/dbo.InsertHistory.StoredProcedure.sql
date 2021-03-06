USE [{DATABASE_NAME}]
GO
/****** Object:  StoredProcedure [dbo].[InsertHistory]    Script Date: 12/10/2012 22:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertHistory]
	(
	@FavoriteId int,
    @Date datetime,
    @UserSid nvarchar(255)
	)
AS

  declare @hasHistory int
  
  select @hasHistory = count(FavoriteId) from History
  where FavoriteId = @FavoriteId and UserSid = @UserSid and
        DATEADD(ms, -DATEPART(ms, Date), Date) = DATEADD(ms, -DATEPART(ms, @Date), @Date)
	
  if @hasHistory = 0
  begin
	insert into History 
	  (FavoriteId, Date, UserSid)
	values  
	  (@FavoriteId, @Date, @UserSid)
  end
GO
