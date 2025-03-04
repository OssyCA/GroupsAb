USE [master]
GO
/****** Object:  Database [GroupsAbDB]    Script Date: 2025-02-27 20:40:52 ******/
CREATE DATABASE [GroupsAbDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GroupsAbDB', SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GroupsAbDB_log',  SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GroupsAbDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GroupsAbDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GroupsAbDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GroupsAbDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GroupsAbDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GroupsAbDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GroupsAbDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GroupsAbDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GroupsAbDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GroupsAbDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GroupsAbDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GroupsAbDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GroupsAbDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GroupsAbDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GroupsAbDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GroupsAbDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GroupsAbDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GroupsAbDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GroupsAbDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GroupsAbDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GroupsAbDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GroupsAbDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GroupsAbDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GroupsAbDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GroupsAbDB] SET RECOVERY FULL 
GO
ALTER DATABASE [GroupsAbDB] SET  MULTI_USER 
GO
ALTER DATABASE [GroupsAbDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GroupsAbDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GroupsAbDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GroupsAbDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GroupsAbDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GroupsAbDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GroupsAbDB', N'ON'
GO
ALTER DATABASE [GroupsAbDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [GroupsAbDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GroupsAbDB]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 2025-02-27 20:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[PersonalNumber] [nvarchar](12) NULL,
	[PlayerName] [nvarchar](50) NOT NULL,
	[Age] [int] NULL,
	[FkTeamID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 2025-02-27 20:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](35) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 2025-02-27 20:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[TestId] [int] IDENTITY(1,1) NOT NULL,
	[PName] [nvarchar](20) NULL,
	[TName] [nvarchar](22) NULL,
PRIMARY KEY CLUSTERED 
(
	[TestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (1, N'198312041234', N'Maximillian Storm', 40, 1)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (2, N'199106153456', N'Selena Vortex', 33, 1)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (3, N'199802202222', N'Leonidas Frost', 26, 2)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (4, N'200108071111', N'Isolde Nightshade', 23, 2)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (5, N'199403302345', N'Xander Wolfhart', 30, 3)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (6, N'200209152012', N'Freya Moonshadow', 21, 3)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (7, N'198707090987', N'Gideon Blackthorn', 36, 4)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (8, N'199912051111', N'Seraphina Starfire', 24, 4)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (9, N'199609292333', N'Orion Ironwood', 27, 5)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (10, N'200103022444', N'Luna Everglow', 23, 5)
INSERT [dbo].[Player] ([PlayerID], [PersonalNumber], [PlayerName], [Age], [FkTeamID]) VALUES (11, N'200103022222', N'KKKK', 23, 6)
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (2, N'Azure Titans')
INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (1, N'Crimson Falcons')
INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (3, N'Emerald Vipers')
INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (5, N'Ivory Phoenix')
INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (4, N'Onyx Guardians')
INSERT [dbo].[Team] ([TeamID], [TeamName]) VALUES (6, N'TestTeam1')
SET IDENTITY_INSERT [dbo].[Team] OFF
GO
SET IDENTITY_INSERT [dbo].[TestTable] ON 

INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (1, N'PlayerTest1', N'TeamTest1')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (2, N'Ossamn', N'Frontend')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (3, N'Test', N'ffoof')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (4, N'dd', N'ss')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (5, N'Ossman', N'Frontend2')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (6, N'dddd', N'dd')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (7, N'Test6', N'dd')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (8, N'NEW TEST', N'')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (9, N'DDD', N'')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (10, N'DDDW', N'')
INSERT [dbo].[TestTable] ([TestId], [PName], [TName]) VALUES (11, N'dd', N'ddd')
SET IDENTITY_INSERT [dbo].[TestTable] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Team__4E21CAAC280D3B21]    Script Date: 2025-02-27 20:40:52 ******/
ALTER TABLE [dbo].[Team] ADD UNIQUE NONCLUSTERED 
(
	[TeamName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([FkTeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
USE [master]
GO
ALTER DATABASE [GroupsAbDB] SET  READ_WRITE 
GO
