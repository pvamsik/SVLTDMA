USE [DMA]
GO

/****** Object:  Table [dbo].[printerSettings]    Script Date: 10/31/2016 4:34:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[printerSettings](
	[name] [nvarchar](100) NOT NULL,
	[port] [nvarchar](100) NOT NULL,
	[settings] [nvarchar](100) NULL,
	[mode] [nvarchar](50) NULL,
 CONSTRAINT [PK_printerSettings] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE PROCEDURE [dbo].[printerSettings_SelectAll]
AS
BEGIN
	SELECT ps.name, ps.port, ps.settings, ps.mode FROM printerSettings as ps
END
GO

CREATE PROCEDURE [dbo].[printerSettings_DeleteByName]
	@name as nvarchar(100)
AS
BEGIN
	DELETE FROM printerSettings WHERE (name = @name)
END
GO

CREATE PROCEDURE [dbo].[printerSettings_Insert]
	@name as nvarchar(100),
	@port as nvarchar(100),
	@settings as nvarchar(100),
	@mode as nvarchar(50)
AS
BEGIN
	INSERT INTO printerSettings(name, port, settings, mode) VALUES (@name, @port, @settings, @mode)
END
GO

CREATE PROCEDURE [dbo].[printerSettings_UpdateByName]
	@name as nvarchar(100),
	@port as nvarchar(100),
	@settings as nvarchar(100),
	@mode as nvarchar(50)
AS
BEGIN
	UPDATE printerSettings SET port = @port, settings = @settings, mode = @mode WHERE name = @name
END
GO