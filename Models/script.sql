IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Treatment_Patient]') AND parent_object_id = OBJECT_ID(N'[dbo].[Treatment]'))
ALTER TABLE [dbo].[Treatment] DROP CONSTRAINT [FK_Treatment_Patient]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Treatment_Doctor]') AND parent_object_id = OBJECT_ID(N'[dbo].[Treatment]'))
ALTER TABLE [dbo].[Treatment] DROP CONSTRAINT [FK_Treatment_Doctor]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Prescription_Treatment]') AND parent_object_id = OBJECT_ID(N'[dbo].[Prescription]'))
ALTER TABLE [dbo].[Prescription] DROP CONSTRAINT [FK_Prescription_Treatment]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Patient_StateMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[Patient]'))
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [FK_Patient_StateMaster]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Patient_CityMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[Patient]'))
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [FK_Patient_CityMaster]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Doctor_StateMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[Doctor]'))
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [FK_Doctor_StateMaster]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Doctor_CityMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[Doctor]'))
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [FK_Doctor_CityMaster]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CityMaster_StateMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[CityMaster]'))
ALTER TABLE [dbo].[CityMaster] DROP CONSTRAINT [FK_CityMaster_StateMaster]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Prescription_Evening]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Prescription] DROP CONSTRAINT [DF_Prescription_Evening]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Prescription_Noon]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Prescription] DROP CONSTRAINT [DF_Prescription_Noon]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Prescription_Morning]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Prescription] DROP CONSTRAINT [DF_Prescription_Morning]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Prescription_Quntity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Prescription] DROP CONSTRAINT [DF_Prescription_Quntity]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Patient_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Patient] DROP CONSTRAINT [DF_Patient_IsActive]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Doctor_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Doctor] DROP CONSTRAINT [DF_Doctor_IsActive]
END
GO
/****** Object:  Table [dbo].[Treatment]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Treatment]') AND type in (N'U'))
DROP TABLE [dbo].[Treatment]
GO
/****** Object:  Table [dbo].[StateMaster]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StateMaster]') AND type in (N'U'))
DROP TABLE [dbo].[StateMaster]
GO
/****** Object:  Table [dbo].[Prescription]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Prescription]') AND type in (N'U'))
DROP TABLE [dbo].[Prescription]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Patient]') AND type in (N'U'))
DROP TABLE [dbo].[Patient]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Doctor]') AND type in (N'U'))
DROP TABLE [dbo].[Doctor]
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 15-03-2020 10:49:51 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CityMaster]') AND type in (N'U'))
DROP TABLE [dbo].[CityMaster]
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMaster](
	[CityMasterId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateMasterId] [bigint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CityMaster] PRIMARY KEY CLUSTERED 
(
	[CityMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateMasterId] [bigint] NOT NULL,
	[CityMasterId] [bigint] NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[Aadhaar] [nvarchar](12) NOT NULL,
	[Mobile] [nvarchar](10) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[Degree] [nvarchar](100) NOT NULL,
	[Designation] [nvarchar](100) NOT NULL,
	[HospitalName] [nvarchar](100) NOT NULL,
	[HospitalAddress] [nvarchar](500) NOT NULL,
	[HospitalPincode] [nvarchar](6) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Profile] [nvarchar](128) NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateMasterId] [bigint] NOT NULL,
	[CityMasterId] [bigint] NOT NULL,
	[Aadhaar] [nvarchar](12) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[BloodGroup] [nvarchar](10) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[Pincode] [nvarchar](6) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Profile] [nvarchar](128) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescription]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescription](
	[PrescriptionId] [bigint] IDENTITY(1,1) NOT NULL,
	[TreatmentId] [bigint] NOT NULL,
	[Medicine] [nvarchar](100) NOT NULL,
	[Quntity] [int] NOT NULL,
	[Morning] [int] NOT NULL,
	[Noon] [int] NOT NULL,
	[Evening] [int] NOT NULL,
 CONSTRAINT [PK_Prescription] PRIMARY KEY CLUSTERED 
(
	[PrescriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StateMaster]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateMaster](
	[StateMasterId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_StateMaster] PRIMARY KEY CLUSTERED 
(
	[StateMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatment]    Script Date: 15-03-2020 10:49:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatment](
	[TreatmentId] [bigint] IDENTITY(1,1) NOT NULL,
	[DoctorId] [bigint] NOT NULL,
	[PatientId] [bigint] NOT NULL,
	[DiseaseName] [nvarchar](150) NOT NULL,
	[DiseaseReview] [nvarchar](500) NOT NULL,
	[DiseaseRating] [decimal](18, 2) NOT NULL,
	[Advice] [nvarchar](500) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[AttachedFile] [nvarchar](128) NULL,
 CONSTRAINT [PK_Treatment] PRIMARY KEY CLUSTERED 
(
	[TreatmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CityMaster] ON 
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1504, 2, N'Mumbai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1505, 4, N'Bengaluru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1506, 1, N'Ahmedabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1507, 5, N'Hyderabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1508, 6, N'Chennai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1509, 7, N'Kolkata')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1510, 2, N'Pune')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1511, 8, N'Jaipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1512, 1, N'Surat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1513, 9, N'Lucknow')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1514, 9, N'Kanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1515, 2, N'Nagpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1516, 10, N'Patna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1517, 11, N'Indore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1518, 2, N'Thane')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1519, 11, N'Bhopal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1520, 12, N'Visakhapatnam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1521, 1, N'Vadodara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1522, 9, N'Firozabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1523, 13, N'Ludhiana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1524, 1, N'Rajkot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1525, 9, N'Agra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1526, 7, N'Siliguri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1527, 2, N'Nashik')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1528, 14, N'Faridabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1529, 13, N'Patiala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1530, 9, N'Meerut')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1531, 2, N'Kalyan-Dombivali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1532, 2, N'Vasai-Virar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1533, 9, N'Varanasi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1534, 15, N'Srinagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1535, 16, N'Dhanbad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1536, 8, N'Jodhpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1537, 13, N'Amritsar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1538, 17, N'Raipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1539, 9, N'Allahabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1540, 6, N'Coimbatore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1541, 11, N'Jabalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1542, 11, N'Gwalior')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1543, 12, N'Vijayawada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1544, 6, N'Madurai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1545, 18, N'Guwahati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1546, 4, N'Hubli-Dharwad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1547, 9, N'Amroha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1548, 9, N'Moradabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1549, 14, N'Gurgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1550, 9, N'Aligarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1551, 2, N'Solapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1552, 16, N'Ranchi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1553, 13, N'Jalandhar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1554, 6, N'Tiruchirappalli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1555, 20, N'Bhubaneswar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1556, 6, N'Salem')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1557, 5, N'Warangal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1558, 2, N'Mira-Bhayandar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1559, 21, N'Thiruvananthapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1560, 2, N'Bhiwandi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1561, 9, N'Saharanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1562, 12, N'Guntur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1563, 2, N'Amravati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1564, 8, N'Bikaner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1565, 9, N'Noida')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1566, 16, N'Jamshedpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1567, 17, N'Bhilai Nagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1568, 20, N'Cuttack')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1569, 21, N'Kochi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1570, 8, N'Udaipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1571, 1, N'Bhavnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1572, 22, N'Dehradun')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1573, 7, N'Asansol')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1574, 2, N'Nanded-Waghala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1575, 8, N'Ajmer')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1576, 1, N'Jamnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1577, 11, N'Ujjain')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1578, 2, N'Sangli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1579, 9, N'Loni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1580, 9, N'Jhansi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1581, 23, N'Pondicherry')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1582, 12, N'Nellore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1583, 15, N'Jammu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1584, 4, N'Belagavi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1585, 20, N'Raurkela')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1586, 4, N'Mangaluru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1587, 6, N'Tirunelveli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1588, 2, N'Malegaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1589, 10, N'Gaya')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1590, 6, N'Tiruppur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1591, 4, N'Davanagere')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1592, 21, N'Kozhikode')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1593, 2, N'Akola')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1594, 12, N'Kurnool')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1595, 16, N'Bokaro Steel City')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1596, 12, N'Rajahmundry')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1597, 4, N'Ballari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1598, 24, N'Agartala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1599, 10, N'Bhagalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1600, 2, N'Latur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1601, 2, N'Dhule')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1602, 17, N'Korba')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1603, 8, N'Bhilwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1604, 20, N'Brahmapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1605, 25, N'Mysore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1606, 10, N'Muzaffarpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1607, 2, N'Ahmednagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1608, 21, N'Kollam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1609, 7, N'Raghunathganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1610, 17, N'Bilaspur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1611, 9, N'Shahjahanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1612, 21, N'Thrissur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1613, 8, N'Alwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1614, 12, N'Kakinada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1615, 5, N'Nizamabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1616, 11, N'Sagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1617, 4, N'Tumkur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1618, 14, N'Hisar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1619, 14, N'Rohtak')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1620, 14, N'Panipat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1621, 10, N'Darbhanga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1622, 7, N'Kharagpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1623, 26, N'Aizawl')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1624, 2, N'Ichalkaranji')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1625, 12, N'Tirupati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1626, 14, N'Karnal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1627, 13, N'Bathinda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1628, 9, N'Rampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1629, 4, N'Shivamogga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1630, 11, N'Ratlam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1631, 9, N'Modinagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1632, 17, N'Durg')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1633, 27, N'Shillong')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1634, 28, N'Imphal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1635, 9, N'Hapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1636, 6, N'Ranipet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1637, 12, N'Anantapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1638, 10, N'Arrah')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1639, 5, N'Karimnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1640, 2, N'Parbhani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1641, 9, N'Etawah')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1642, 8, N'Bharatpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1643, 10, N'Begusarai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1644, 3, N'New 3')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1645, 10, N'Chhapra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1646, 12, N'Kadapa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1647, 5, N'Ramagundam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1648, 8, N'Pali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1649, 11, N'Satna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1650, 12, N'Vizianagaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1651, 10, N'Katihar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1652, 22, N'Hardwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1653, 14, N'Sonipat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1654, 6, N'Nagercoil')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1655, 6, N'Thanjavur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1656, 11, N'Murwara (Katni)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1657, 7, N'Naihati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1658, 9, N'Sambhal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1659, 1, N'Nadiad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1660, 14, N'Yamunanagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1661, 7, N'English Bazar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1662, 12, N'Eluru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1663, 10, N'Munger')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1664, 14, N'Panchkula')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1665, 4, N'Raayachuru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1666, 2, N'Panvel')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1667, 16, N'Deoghar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1668, 12, N'Ongole')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1669, 12, N'Nandyal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1670, 11, N'Morena')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1671, 14, N'Bhiwani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1672, 1, N'Porbandar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1673, 21, N'Palakkad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1674, 1, N'Anand')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1675, 10, N'Purnia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1676, 7, N'Baharampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1677, 8, N'Barmer')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1678, 1, N'Morvi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1679, 9, N'Orai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1680, 9, N'Bahraich')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1681, 8, N'Sikar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1682, 6, N'Vellore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1683, 11, N'Singrauli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1684, 5, N'Khammam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1685, 1, N'Mahesana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1686, 18, N'Silchar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1687, 20, N'Sambalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1688, 11, N'Rewa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1689, 9, N'Unnao')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1690, 7, N'Hugli-Chinsurah')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1691, 7, N'Raiganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1692, 16, N'Phusro')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1693, 16, N'Adityapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1694, 21, N'Alappuzha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1695, 14, N'Bahadurgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1696, 12, N'Machilipatnam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1697, 9, N'Rae Bareli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1698, 7, N'Jalpaiguri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1699, 1, N'Bharuch')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1700, 13, N'Pathankot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1701, 13, N'Hoshiarpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1702, 15, N'Baramula')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1703, 12, N'Adoni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1704, 14, N'Jind')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1705, 8, N'Tonk')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1706, 12, N'Tenali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1707, 6, N'Kancheepuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1708, 1, N'Vapi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1709, 14, N'Sirsa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1710, 1, N'Navsari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1711, 5, N'Mahbubnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1712, 20, N'Puri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1713, 4, N'Robertson Pet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1714, 6, N'Erode')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1715, 13, N'Batala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1716, 22, N'Haldwani-cum-Kathgodam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1717, 11, N'Vidisha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1718, 10, N'Saharsa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1719, 14, N'Thanesar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1720, 12, N'Chittoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1721, 1, N'Veraval')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1722, 9, N'Lakhimpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1723, 9, N'Sitapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1724, 12, N'Hindupur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1725, 7, N'Santipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1726, 7, N'Balurghat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1727, 11, N'Ganjbasoda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1728, 13, N'Moga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1729, 12, N'Proddatur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1730, 22, N'Srinagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1731, 7, N'Medinipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1732, 7, N'Habra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1733, 10, N'Sasaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1734, 10, N'Hajipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1735, 1, N'Bhuj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1736, 11, N'Shivpuri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1737, 7, N'Ranaghat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1738, 29, N'Shimla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1739, 6, N'Tiruvannamalai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1740, 14, N'Kaithal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1741, 17, N'Rajnandgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1742, 1, N'Godhra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1743, 16, N'Hazaribag')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1744, 12, N'Bhimavaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1745, 11, N'Mandsaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1746, 18, N'Dibrugarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1747, 4, N'Kolar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1748, 7, N'Bankura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1749, 4, N'Mandya')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1750, 10, N'Dehri-on-Sone')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1751, 12, N'Madanapalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1752, 13, N'Malerkotla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1753, 9, N'Lalitpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1754, 10, N'Bettiah')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1755, 6, N'Pollachi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1756, 13, N'Khanna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1757, 11, N'Neemuch')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1758, 14, N'Palwal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1759, 1, N'Palanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1760, 12, N'Guntakal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1761, 7, N'Nabadwip')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1762, 4, N'Udupi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1763, 17, N'Jagdalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1764, 10, N'Motihari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1765, 9, N'Pilibhit')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1766, 30, N'Dimapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1767, 13, N'Mohali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1768, 8, N'Sadulpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1769, 6, N'Rajapalayam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1770, 12, N'Dharmavaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1771, 22, N'Kashipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1772, 6, N'Sivakasi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1773, 7, N'Darjiling')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1774, 4, N'Chikkamagaluru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1775, 12, N'Gudivada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1776, 20, N'Baleshwar Town')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1777, 5, N'Mancherial')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1778, 12, N'Srikakulam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1779, 5, N'Adilabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1780, 2, N'Yavatmal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1781, 13, N'Barnala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1782, 18, N'Nagaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1783, 12, N'Narasaraopet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1784, 17, N'Raigarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1785, 22, N'Roorkee')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1786, 1, N'Valsad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1787, 17, N'Ambikapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1788, 16, N'Giridih')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1789, 9, N'Chandausi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1790, 7, N'Purulia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1791, 1, N'Patan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1792, 10, N'Bagaha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1793, 9, N'Hardoi ')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1794, 2, N'Achalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1795, 2, N'Osmanabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1796, 1, N'Deesa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1797, 2, N'Nandurbar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1798, 9, N'Azamgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1799, 16, N'Ramgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1800, 13, N'Firozpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1801, 20, N'Baripada Town')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1802, 4, N'Karwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1803, 10, N'Siwan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1804, 12, N'Rajampet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1805, 6, N'Pudukkottai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1806, 15, N'Anantnag')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1807, 12, N'Tadpatri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1808, 2, N'Satara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1809, 20, N'Bhadrak')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1810, 10, N'Kishanganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1811, 5, N'Suryapet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1812, 2, N'Wardha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1813, 4, N'Ranebennuru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1814, 1, N'Amreli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1815, 6, N'Neyveli (TS)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1816, 10, N'Jamalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1817, 31, N'Marmagao')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1818, 2, N'Udgir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1819, 12, N'Tadepalligudem')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1820, 6, N'Nagapattinam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1821, 10, N'Buxar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1822, 2, N'Aurangabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1823, 10, N'Jehanabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1824, 13, N'Phagwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1825, 9, N'Khair')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1826, 8, N'Sawai Madhopur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1827, 13, N'Kapurthala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1828, 12, N'Chilakaluripet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1829, 10, N'Aurangabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1830, 21, N'Malappuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1831, 14, N'Rewari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1832, 8, N'Nagaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1833, 9, N'Sultanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1834, 11, N'Nagda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1835, 32, N'Port Blair')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1836, 10, N'Lakhisarai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1837, 31, N'Panaji')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1838, 18, N'Tinsukia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1839, 11, N'Itarsi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1840, 30, N'Kohima')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1841, 20, N'Balangir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1842, 10, N'Nawada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1843, 20, N'Jharsuguda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1844, 5, N'Jagtial')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1845, 6, N'Viluppuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1846, 2, N'Amalner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1847, 13, N'Zirakpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1848, 9, N'Tanda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1849, 6, N'Tiruchengode')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1850, 9, N'Nagina')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1851, 12, N'Yemmiganur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1852, 6, N'Vaniyambadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1853, 11, N'Sarni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1854, 6, N'Theni Allinagaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1855, 31, N'Margao')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1856, 2, N'Akot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1857, 11, N'Sehore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1858, 11, N'Mhow Cantonment')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1859, 13, N'Kot Kapura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1860, 8, N'Makrana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1861, 2, N'Pandharpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1862, 5, N'Miryalaguda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1863, 9, N'Shamli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1864, 11, N'Seoni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1865, 4, N'Ranibennur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1866, 12, N'Kadiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1867, 2, N'Shrirampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1868, 22, N'Rudrapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1869, 2, N'Parli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1870, 9, N'Najibabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1871, 5, N'Nirmal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1872, 6, N'Udhagamandalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1873, 9, N'Shikohabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1874, 16, N'Jhumri Tilaiya')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1875, 6, N'Aruppukkottai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1876, 21, N'Ponnani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1877, 10, N'Jamui')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1878, 10, N'Sitamarhi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1879, 12, N'Chirala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1880, 1, N'Anjar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1881, 23, N'Karaikal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1882, 14, N'Hansi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1883, 12, N'Anakapalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1884, 17, N'Mahasamund')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1885, 13, N'Faridkot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1886, 16, N'Saunda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1887, 1, N'Dhoraji')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1888, 6, N'Paramakudi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1889, 11, N'Balaghat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1890, 8, N'Sujangarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1891, 1, N'Khambhat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1892, 13, N'Muktsar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1893, 13, N'Rajpura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1894, 12, N'Kavali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1895, 17, N'Dhamtari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1896, 11, N'Ashok Nagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1897, 8, N'Sardarshahar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1898, 1, N'Mahuva')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1899, 20, N'Bargarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1900, 5, N'Kamareddy')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1901, 16, N'Sahibganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1902, 5, N'Kothagudem')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1903, 4, N'Ramanagaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1904, 4, N'Gokak')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1905, 11, N'Tikamgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1906, 10, N'Araria')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1907, 22, N'Rishikesh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1908, 11, N'Shahdol')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1909, 16, N'Medininagar (Daltonganj)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1910, 6, N'Arakkonam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1911, 2, N'Washim')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1912, 13, N'Sangrur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1913, 5, N'Bodhan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1914, 13, N'Fazilka')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1915, 12, N'Palacole')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1916, 1, N'Keshod')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1917, 12, N'Sullurpeta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1918, 1, N'Wadhwan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1919, 13, N'Gurdaspur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1920, 21, N'Vatakara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1921, 27, N'Tura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1922, 14, N'Narnaul')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1923, 13, N'Kharar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1924, 4, N'Yadgir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1925, 2, N'Ambejogai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1926, 1, N'Ankleshwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1927, 1, N'Savarkundla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1928, 20, N'Paradip')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1929, 6, N'Virudhachalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1930, 21, N'Kanhangad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1931, 1, N'Kadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1932, 6, N'Srivilliputhur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1933, 13, N'Gobindgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1934, 6, N'Tindivanam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1935, 13, N'Mansa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1936, 21, N'Taliparamba')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1937, 2, N'Manmad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1938, 12, N'Tanuku')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1939, 12, N'Rayachoti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1940, 6, N'Virudhunagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1941, 21, N'Koyilandy')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1942, 18, N'Jorhat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1943, 6, N'Karur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1944, 6, N'Valparai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1945, 12, N'Srikalahasti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1946, 21, N'Neyyattinkara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1947, 12, N'Bapatla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1948, 14, N'Fatehabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1949, 13, N'Malout')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1950, 6, N'Sankarankovil')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1951, 6, N'Tenkasi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1952, 2, N'Ratnagiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1953, 4, N'Rabkavi Banhatti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1954, 9, N'Sikandrabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1955, 16, N'Chaibasa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1956, 17, N'Chirmiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1957, 5, N'Palwancha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1958, 20, N'Bhawanipatna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1959, 21, N'Kayamkulam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1960, 11, N'Pithampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1961, 13, N'Nabha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1962, 9, N'Shahabad, Hardoi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1963, 20, N'Dhenkanal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1964, 2, N'Uran Islampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1965, 10, N'Gopalganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1966, 18, N'Bongaigaon City')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1967, 6, N'Palani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1968, 2, N'Pusad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1969, 15, N'Sopore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1970, 9, N'Pilkhuwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1971, 13, N'Tarn Taran')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1972, 9, N'Renukoot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1973, 5, N'Mandamarri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1974, 4, N'Shahabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1975, 20, N'Barbil')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1976, 5, N'Koratla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1977, 10, N'Madhubani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1978, 7, N'Arambagh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1979, 14, N'Gohana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1980, 8, N'Ladnu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1981, 6, N'Pattukkottai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1982, 4, N'Sirsi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1983, 5, N'Sircilla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1984, 7, N'Tamluk')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1985, 13, N'Jagraon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1986, 7, N'AlipurdUrban Agglomerationr')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1987, 11, N'Alirajpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1988, 5, N'Tandur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1989, 12, N'Naidupet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1990, 6, N'Tirupathur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1991, 14, N'Tohana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1992, 8, N'Ratangarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1993, 18, N'Dhubri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1994, 10, N'Masaurhi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1995, 1, N'Visnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1996, 9, N'Vrindavan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1997, 8, N'Nokha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1998, 12, N'Nagari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (1999, 14, N'Narwana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2000, 6, N'Ramanathapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2001, 9, N'Ujhani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2002, 10, N'Samastipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2003, 9, N'Laharpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2004, 2, N'Sangamner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2005, 8, N'Nimbahera')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2006, 5, N'Siddipet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2007, 7, N'Suri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2008, 18, N'Diphu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2009, 7, N'Jhargram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2010, 2, N'Shirpur-Warwade')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2011, 9, N'Tilhar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2012, 4, N'Sindhnur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2013, 6, N'Udumalaipettai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2014, 2, N'Malkapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2015, 5, N'Wanaparthy')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2016, 12, N'Gudur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2017, 20, N'Kendujhar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2018, 11, N'Mandla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2019, 29, N'Mandi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2020, 21, N'Nedumangad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2021, 18, N'North Lakhimpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2022, 12, N'Vinukonda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2023, 4, N'Tiptur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2024, 6, N'Gobichettipalayam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2025, 20, N'Sunabeda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2026, 2, N'Wani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2027, 1, N'Upleta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2028, 12, N'Narasapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2029, 12, N'Nuzvid')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2030, 18, N'Tezpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2031, 1, N'Una')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2032, 12, N'Markapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2033, 11, N'Sheopur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2034, 6, N'Thiruvarur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2035, 1, N'Sidhpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2036, 9, N'Sahaswan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2037, 8, N'Suratgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2038, 11, N'Shajapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2039, 20, N'Rayagada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2040, 2, N'Lonavla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2041, 12, N'Ponnur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2042, 5, N'Kagaznagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2043, 5, N'Gadwal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2044, 17, N'Bhatapara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2045, 12, N'Kandukur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2046, 5, N'Sangareddy')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2047, 1, N'Unjha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2048, 26, N'Lunglei')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2049, 18, N'Karimganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2050, 21, N'Kannur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2051, 12, N'Bobbili')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2052, 10, N'Mokameh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2053, 2, N'Talegaon Dabhade')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2054, 2, N'Anjangaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2055, 1, N'Mangrol')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2056, 13, N'Sunam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2057, 7, N'Gangarampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2058, 6, N'Thiruvallur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2059, 21, N'Tirur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2060, 9, N'Rath')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2061, 20, N'Jatani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2062, 1, N'Viramgam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2063, 8, N'Rajsamand')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2064, 23, N'Yanam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2065, 21, N'Kottayam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2066, 6, N'Panruti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2067, 13, N'Dhuri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2068, 6, N'Namakkal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2069, 21, N'Kasaragod')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2070, 1, N'Modasa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2071, 12, N'Rayadurg')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2072, 10, N'Supaul')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2073, 21, N'Kunnamkulam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2074, 2, N'Umred')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2075, 5, N'Bellampalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2076, 18, N'Sibsagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2077, 14, N'Mandi Dabwali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2078, 21, N'Ottappalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2079, 10, N'Dumraon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2080, 12, N'Samalkot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2081, 12, N'Jaggaiahpet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2082, 18, N'31lpara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2083, 12, N'Tuni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2084, 8, N'Lachhmangarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2085, 5, N'Bhongir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2086, 12, N'Amalapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2087, 13, N'Firozpur Cantt.')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2088, 5, N'Vikarabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2089, 21, N'Thiruvalla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2090, 9, N'Sherkot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2091, 2, N'Palghar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2092, 2, N'Shegaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2093, 5, N'Jangaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2094, 12, N'Bheemunipatnam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2095, 11, N'Panna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2096, 21, N'Thodupuzha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2097, 15, N'KathUrban Agglomeration')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2098, 1, N'Palitana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2099, 10, N'Arwal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2100, 12, N'Venkatagiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2101, 9, N'Kalpi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2102, 8, N'Rajgarh (Churu)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2103, 12, N'Sattenapalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2104, 4, N'Arsikere')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2105, 2, N'Ozar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2106, 6, N'Thirumangalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2107, 1, N'Petlad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2108, 8, N'Nasirabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2109, 2, N'Phaltan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2110, 7, N'Rampurhat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2111, 4, N'Nanjangud')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2112, 10, N'Forbesganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2113, 9, N'Tundla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2114, 10, N'BhabUrban Agglomeration')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2115, 4, N'Sagara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2116, 12, N'Pithapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2117, 4, N'Sira')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2118, 5, N'Bhadrachalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2119, 14, N'Charkhi Dadri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2120, 16, N'Chatra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2121, 12, N'Palasa Kasibugga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2122, 8, N'Nohar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2123, 2, N'Yevla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2124, 13, N'Sirhind Fatehgarh Sahib')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2125, 5, N'Bhainsa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2126, 12, N'Parvathipuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2127, 2, N'Shahade')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2128, 21, N'Chalakudy')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2129, 10, N'Narkatiaganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2130, 1, N'Kapadvanj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2131, 12, N'Macherla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2132, 11, N'Raghogarh-Vijaypur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2133, 13, N'Rupnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2134, 10, N'Naugachhia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2135, 11, N'Sendhwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2136, 20, N'Byasanagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2137, 9, N'Sandila')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2138, 12, N'Gooty')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2139, 12, N'Salur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2140, 9, N'Nanpara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2141, 9, N'Sardhana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2142, 2, N'Vita')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2143, 16, N'Gumia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2144, 4, N'Puttur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2145, 13, N'Jalandhar Cantt.')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2146, 9, N'Nehtaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2147, 21, N'Changanassery')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2148, 12, N'Mandapeta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2149, 16, N'Dumka')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2150, 9, N'Seohara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2151, 2, N'Umarkhed')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2152, 16, N'Madhupur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2153, 6, N'Vikramasingapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2154, 21, N'Punalur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2155, 20, N'Kendrapara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2156, 1, N'Sihor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2157, 6, N'Nellikuppam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2158, 13, N'Samana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2159, 2, N'Warora')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2160, 21, N'Nilambur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2161, 6, N'Rasipuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2162, 22, N'Ramnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2163, 12, N'Jammalamadugu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2164, 13, N'Nawanshahr')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2165, 28, N'Thoubal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2166, 4, N'Athni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2167, 21, N'Cherthala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2168, 11, N'Sidhi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2169, 5, N'Farooqnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2170, 12, N'Peddapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2171, 16, N'Chirkunda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2172, 2, N'Pachora')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2173, 10, N'Madhepura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2174, 22, N'Pithoragarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2175, 2, N'Tumsar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2176, 8, N'Phalodi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2177, 6, N'Tiruttani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2178, 13, N'Rampura Phul')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2179, 21, N'Perinthalmanna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2180, 9, N'Padrauna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2181, 11, N'Pipariya')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2182, 17, N'Dalli-Rajhara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2183, 12, N'Punganur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2184, 21, N'Mattannur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2185, 9, N'Mathura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2186, 9, N'Thakurdwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2187, 6, N'Nandivaram-Guduvancheri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2188, 4, N'Mulbagal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2189, 2, N'Manjlegaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2190, 1, N'Wankaner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2191, 2, N'Sillod')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2192, 12, N'Nidadavole')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2193, 4, N'Surapura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2194, 20, N'Rajagangapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2195, 10, N'Sheikhpura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2196, 20, N'Parlakhemundi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2197, 7, N'Kalimpong')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2198, 4, N'Siruguppa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2199, 2, N'Arvi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2200, 1, N'Limbdi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2201, 18, N'Barpeta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2202, 22, N'Manglaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2203, 12, N'Repalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2204, 4, N'Mudhol')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2205, 11, N'Shujalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2206, 1, N'Mandvi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2207, 1, N'Thangadh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2208, 11, N'Sironj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2209, 2, N'Nandura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2210, 21, N'Shoranur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2211, 8, N'Nathdwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2212, 6, N'Periyakulam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2213, 10, N'Sultanganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2214, 5, N'Medak')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2215, 5, N'Narayanpet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2216, 10, N'Raxaul Bazar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2217, 15, N'Rajauri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2218, 6, N'Pernampattu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2219, 22, N'Nainital')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2220, 12, N'Ramachandrapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2221, 2, N'Vaijapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2222, 13, N'Nangal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2223, 4, N'Sidlaghatta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2224, 15, N'Punch')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2225, 11, N'Pandhurna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2226, 2, N'Wadgaon Road')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2227, 20, N'Talcher')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2228, 21, N'Varkala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2229, 8, N'Pilani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2230, 11, N'Nowgong')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2231, 17, N'Naila Janjgir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2232, 31, N'Mapusa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2233, 6, N'Vellakoil')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2234, 8, N'Merta City')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2235, 6, N'Sivaganga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2236, 11, N'Mandideep')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2237, 2, N'Sailu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2238, 1, N'Vyara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2239, 12, N'Kovvur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2240, 6, N'Vadalur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2241, 9, N'Nawabganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2242, 1, N'Padra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2243, 7, N'Sainthia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2244, 9, N'Siana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2245, 4, N'Shahpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2246, 8, N'Sojat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2247, 9, N'Noorpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2248, 21, N'Paravoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2249, 2, N'Murtijapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2250, 10, N'Ramnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2251, 20, N'Sundargarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2252, 7, N'Taki')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2253, 4, N'Saundatti-Yellamma')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2254, 21, N'Pathanamthitta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2255, 4, N'Wadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2256, 6, N'Rameshwaram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2257, 2, N'Tasgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2258, 9, N'Sikandra Rao')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2259, 11, N'Sihora')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2260, 6, N'Tiruvethipuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2261, 12, N'Tiruvuru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2262, 2, N'Mehkar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2263, 21, N'Peringathur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2264, 6, N'Perambalur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2265, 4, N'Manvi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2266, 30, N'Zunheboto')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2267, 10, N'Mahnar Bazar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2268, 21, N'Attingal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2269, 14, N'Shahbad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2270, 9, N'Puranpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2271, 4, N'Nelamangala')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2272, 13, N'Nakodar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2273, 1, N'Lunawada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2274, 7, N'Murshidabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2275, 23, N'Mahe')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2276, 18, N'Lanka')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2277, 9, N'Rudauli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2278, 30, N'Tuensang')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2279, 4, N'Lakshmeshwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2280, 13, N'Zira')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2281, 2, N'Yawal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2282, 9, N'Thana Bhawan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2283, 4, N'Ramdurg')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2284, 2, N'Pulgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2285, 5, N'Sadasivpet')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2286, 4, N'Nargund')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2287, 8, N'Neem-Ka-Thana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2288, 7, N'Memari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2289, 2, N'Nilanga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2290, 33, N'Naharlagun')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2291, 16, N'Pakaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2292, 2, N'Wai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2293, 4, N'Tarikere')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2294, 4, N'Malavalli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2295, 11, N'Raisen')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2296, 11, N'Lahar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2297, 12, N'Uravakonda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2298, 4, N'Savanur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2299, 8, N'Sirohi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2300, 15, N'Udhampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2301, 2, N'Umarga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2302, 8, N'Pratapgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2303, 4, N'Lingsugur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2304, 6, N'Usilampatti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2305, 9, N'Palia Kalan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2306, 30, N'Wokha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2307, 1, N'Rajpipla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2308, 4, N'Vijayapura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2309, 8, N'Rawatbhata')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2310, 8, N'Sangaria')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2311, 2, N'Paithan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2312, 2, N'Rahuri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2313, 13, N'Patti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2314, 9, N'Zaidpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2315, 8, N'Lalsot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2316, 11, N'Maihar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2317, 6, N'Vedaranyam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2318, 2, N'Nawapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2319, 29, N'Solan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2320, 1, N'Vapi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2321, 11, N'Sanawad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2322, 10, N'Warisaliganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2323, 10, N'Revelganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2324, 11, N'Sabalgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2325, 2, N'Tuljapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2326, 16, N'Simdega')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2327, 16, N'Musabani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2328, 21, N'Kodungallur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2329, 20, N'Phulabani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2330, 1, N'Umreth')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2331, 12, N'Narsipatnam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2332, 9, N'Nautanwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2333, 10, N'Rajgir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2334, 5, N'Yellandu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2335, 6, N'Sathyamangalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2336, 8, N'Pilibanga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2337, 2, N'Morshi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2338, 14, N'Pehowa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2339, 10, N'Sonepur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2340, 21, N'Pappinisseri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2341, 9, N'Zamania')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2342, 16, N'Mihijam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2343, 2, N'Purna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2344, 6, N'Puliyankudi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2345, 9, N'Shikarpur, Bulandshahr')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2346, 11, N'Umaria')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2347, 11, N'Porsa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2348, 9, N'Naugawan Sadat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2349, 9, N'Fatehpur Sikri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2350, 5, N'Manuguru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2351, 24, N'Udaipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2352, 8, N'Pipar City')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2353, 20, N'Pattamundai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2354, 6, N'Nanjikottai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2355, 8, N'Taranagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2356, 12, N'Yerraguntla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2357, 2, N'Satana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2358, 10, N'Sherghati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2359, 4, N'Sankeshwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2360, 4, N'Madikeri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2361, 6, N'Thuraiyur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2362, 1, N'Sanand')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2363, 1, N'Rajula')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2364, 5, N'Kyathampalle')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2365, 9, N'Shahabad, Rampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2366, 17, N'Tilda Newra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2367, 11, N'Narsinghgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2368, 21, N'Chittur-Thathamangalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2369, 11, N'Malaj Khand')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2370, 11, N'Sarangpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2371, 9, N'Robertsganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2372, 6, N'Sirkali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2373, 1, N'Radhanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2374, 6, N'Tiruchendur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2375, 9, N'Utraula')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2376, 16, N'Patratu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2377, 8, N'Vijainagar, Ajmer')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2378, 6, N'Periyasemur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2379, 2, N'Pathri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2380, 9, N'Sadabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2381, 4, N'Talikota')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2382, 2, N'Sinnar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2383, 17, N'Mungeli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2384, 4, N'Sedam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2385, 4, N'Shikaripur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2386, 8, N'Sumerpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2387, 6, N'Sattur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2388, 10, N'Sugauli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2389, 18, N'Lumding')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2390, 6, N'Vandavasi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2391, 20, N'Titlagarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2392, 2, N'Uchgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2393, 30, N'Mokokchung')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2394, 7, N'Paschim Punropara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2395, 8, N'Sagwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2396, 8, N'Ramganj Mandi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2397, 7, N'Tarakeswar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2398, 4, N'Mahalingapura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2399, 24, N'Dharmanagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2400, 1, N'Mahemdabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2401, 17, N'Manendragarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2402, 2, N'Uran')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2403, 6, N'Tharamangalam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2404, 6, N'Tirukkoyilur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2405, 2, N'Pen')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2406, 10, N'Makhdumpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2407, 10, N'Maner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2408, 6, N'Oddanchatram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2409, 6, N'Palladam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2410, 11, N'Mundi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2411, 20, N'Nabarangapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2412, 4, N'Mudalagi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2413, 14, N'Samalkha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2414, 11, N'Nepanagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2415, 2, N'Karjat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2416, 1, N'Ranavav')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2417, 12, N'Pedana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2418, 14, N'Pinjore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2419, 8, N'Lakheri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2420, 11, N'Pasan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2421, 12, N'Puttur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2422, 6, N'Vadakkuvalliyur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2423, 6, N'Tirukalukundram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2424, 11, N'Mahidpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2425, 22, N'Mussoorie')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2426, 21, N'Muvattupuzha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2427, 9, N'Rasra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2428, 8, N'Udaipurwati')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2429, 2, N'Manwath')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2430, 21, N'Adoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2431, 6, N'Uthamapalayam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2432, 2, N'Partur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2433, 29, N'Nahan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2434, 14, N'Ladwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2435, 18, N'Mankachar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2436, 27, N'Nongstoin')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2437, 8, N'Losal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2438, 8, N'Sri Madhopur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2439, 8, N'Ramngarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2440, 21, N'Mavelikkara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2441, 8, N'Rawatsar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2442, 8, N'Rajakhera')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2443, 9, N'Lar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2444, 9, N'Lal Gopalganj Nindaura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2445, 4, N'Muddebihal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2446, 9, N'Sirsaganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2447, 8, N'Shahpura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2448, 6, N'Surandai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2449, 2, N'Sangole')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2450, 4, N'Pavagada')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2451, 1, N'Tharad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2452, 1, N'Mansa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2453, 1, N'Umbergaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2454, 21, N'Mavoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2455, 18, N'Nalbari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2456, 1, N'Talaja')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2457, 4, N'Malur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2458, 2, N'Mangrulpir')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2459, 20, N'Soro')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2460, 8, N'Shahpura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2461, 1, N'Vadnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2462, 8, N'Raisinghnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2463, 4, N'Sindhagi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2464, 4, N'Sanduru')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2465, 14, N'Sohna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2466, 1, N'Manavadar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2467, 9, N'Pihani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2468, 14, N'Safidon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2469, 2, N'Risod')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2470, 10, N'Rosera')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2471, 6, N'Sankari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2472, 8, N'Malpura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2473, 7, N'Sonamukhi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2474, 9, N'Shamsabad, Agra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2475, 10, N'Nokha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2476, 7, N'PandUrban Agglomeration')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2477, 7, N'Mainaguri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2478, 4, N'Afzalpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2479, 2, N'Shirur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2480, 1, N'Salaya')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2481, 6, N'Shenkottai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2482, 24, N'Pratapgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2483, 6, N'Vadipatti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2484, 5, N'Nagarkurnool')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2485, 2, N'Savner')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2486, 2, N'Sasvad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2487, 9, N'Rudrapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2488, 9, N'Soron')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2489, 6, N'Sholingur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2490, 2, N'Pandharkaoda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2491, 21, N'Perumbavoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2492, 4, N'Maddur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2493, 8, N'Nadbai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2494, 2, N'Talode')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2495, 2, N'Shrigonda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2496, 4, N'Madhugiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2497, 4, N'Tekkalakote')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2498, 11, N'Seoni-Malwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2499, 2, N'Shirdi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2500, 9, N'SUrban Agglomerationr')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2501, 4, N'Terdal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2502, 2, N'Raver')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2503, 6, N'Tirupathur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2504, 14, N'Taraori')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2505, 2, N'Mukhed')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2506, 6, N'Manachanallur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2507, 11, N'Rehli')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2508, 8, N'Sanchore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2509, 2, N'Rajura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2510, 10, N'Piro')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2511, 4, N'Mudabidri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2512, 2, N'Vadgaon Kasba')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2513, 8, N'Nagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2514, 1, N'Vijapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2515, 6, N'Viswanatham')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2516, 6, N'Polur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2517, 6, N'Panagudi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2518, 11, N'Manawar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2519, 22, N'Tehri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2520, 9, N'Samdhan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2521, 1, N'Pardi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2522, 11, N'Rahatgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2523, 11, N'Panagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2524, 6, N'Uthiramerur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2525, 2, N'Tirora')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2526, 18, N'Rangia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2527, 9, N'Sahjanwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2528, 11, N'Wara Seoni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2529, 4, N'Magadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2530, 8, N'Rajgarh (Alwar)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2531, 10, N'Rafiganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2532, 11, N'Tarana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2533, 9, N'Rampur Maniharan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2534, 8, N'Sheoganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2535, 13, N'Raikot')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2536, 22, N'Pauri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2537, 9, N'Sumerpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2538, 4, N'Navalgund')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2539, 9, N'Shahganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2540, 10, N'Marhaura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2541, 9, N'Tulsipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2542, 8, N'Sadri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2543, 6, N'Thiruthuraipoondi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2544, 4, N'Shiggaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2545, 6, N'Pallapatti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2546, 14, N'Mahendragarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2547, 11, N'Sausar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2548, 6, N'Ponneri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2549, 2, N'Mahad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2550, 16, N'Lohardaga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2551, 9, N'Tirwaganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2552, 18, N'Margherita')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2553, 29, N'Sundarnagar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2554, 11, N'Rajgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2555, 18, N'Mangaldoi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2556, 12, N'Renigunta')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2557, 13, N'Longowal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2558, 14, N'Ratia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2559, 6, N'Lalgudi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2560, 4, N'Shrirangapattana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2561, 11, N'Niwari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2562, 6, N'Natham')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2563, 6, N'Unnamalaikadai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2564, 9, N'PurqUrban Agglomerationzi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2565, 9, N'Shamsabad, Farrukhabad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2566, 10, N'Mirganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2567, 8, N'Todaraisingh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2568, 9, N'Warhapur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2569, 12, N'Rajam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2570, 13, N'Urmar Tanda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2571, 2, N'Lonar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2572, 9, N'Powayan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2573, 6, N'P.N.Patti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2574, 29, N'Palampur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2575, 12, N'Srisailam Project (Right Flank Colony) Township')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2576, 4, N'Sindagi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2577, 9, N'Sandi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2578, 21, N'Vaikom')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2579, 7, N'Malda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2580, 6, N'Tharangambadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2581, 4, N'Sakaleshapura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2582, 10, N'Lalganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2583, 20, N'Malkangiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2584, 1, N'Rapar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2585, 11, N'Mauganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2586, 8, N'Todabhim')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2587, 4, N'Srinivaspur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2588, 10, N'Murliganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2589, 8, N'Reengus')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2590, 2, N'Sawantwadi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2591, 6, N'Tittakudi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2592, 28, N'Lilong')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2593, 8, N'Rajaldesar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2594, 2, N'Pathardi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2595, 9, N'Achhnera')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2596, 6, N'Pacode')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2597, 9, N'Naraura')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2598, 9, N'Nakur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2599, 21, N'Palai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2600, 13, N'Morinda, India')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2601, 11, N'Manasa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2602, 11, N'Nainpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2603, 9, N'Sahaspur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2604, 2, N'Pauni')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2605, 11, N'Prithvipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2606, 2, N'Ramtek')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2607, 18, N'Silapathar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2608, 1, N'Songadh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2609, 9, N'Safipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2610, 11, N'Sohagpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2611, 2, N'Mul')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2612, 8, N'Sadulshahar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2613, 13, N'Phillaur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2614, 8, N'Sambhar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2615, 8, N'Prantij')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2616, 22, N'Nagla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2617, 13, N'Pattran')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2618, 8, N'Mount Abu')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2619, 9, N'Reoti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2620, 16, N'Tenu dam-cum-Kathhara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2621, 7, N'Panchla')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2622, 22, N'Sitarganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2623, 33, N'Pasighat')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2624, 10, N'Motipur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2625, 6, N'O'' Valley')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2626, 7, N'Raghunathpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2627, 6, N'Suriyampalayam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2628, 13, N'Qadian')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2629, 20, N'Rairangpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2630, 34, N'Silvassa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2631, 11, N'Nowrozabad (Khodargama)')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2632, 8, N'Mangrol')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2633, 2, N'Soyagaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2634, 13, N'Sujanpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2635, 10, N'Manihari')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2636, 9, N'Sikanderpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2637, 2, N'Mangalvedhe')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2638, 8, N'Phulera')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2639, 4, N'Ron')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2640, 6, N'Sholavandan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2641, 9, N'Saidpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2642, 11, N'Shamgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2643, 6, N'Thammampatti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2644, 11, N'Maharajpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2645, 11, N'Multai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2646, 13, N'Mukerian')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2647, 9, N'Sirsi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2648, 9, N'Purwa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2649, 10, N'Sheohar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2650, 6, N'Namagiripettai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2651, 9, N'Parasi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2652, 1, N'Lathi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2653, 9, N'Lalganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2654, 2, N'Narkhed')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2655, 7, N'Mathabhanga')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2656, 2, N'Shendurjana')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2657, 6, N'Peravurani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2658, 18, N'Mariani')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2659, 9, N'Phulpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2660, 14, N'Rania')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2661, 11, N'Pali')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2662, 11, N'Pachore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2663, 6, N'Parangipettai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2664, 6, N'Pudupattinam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2665, 21, N'Panniyannur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2666, 10, N'Maharajganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2667, 11, N'Rau')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2668, 7, N'Monoharpur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2669, 8, N'Mandawa')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2670, 18, N'Marigaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2671, 6, N'Pallikonda')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2672, 8, N'Pindwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2673, 9, N'Shishgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2674, 2, N'Patur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2675, 28, N'Mayang Imphal')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2676, 11, N'Mhowgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2677, 21, N'Guruvayoor')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2678, 2, N'Mhaswad')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2679, 9, N'Sahawar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2680, 6, N'Sivagiri')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2681, 4, N'Mundargi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2682, 6, N'Punjaipugalur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2683, 24, N'Kailasahar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2684, 9, N'Samthar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2685, 17, N'Sakti')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2686, 4, N'Sadalagi')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2687, 10, N'Silao')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2688, 8, N'Mandalgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2689, 2, N'Loha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2690, 9, N'Pukhrayan')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2691, 6, N'Padmanabhapuram')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2692, 24, N'Belonia')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2693, 26, N'Saiha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2694, 7, N'Srirampore')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2695, 13, N'Talwara')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2696, 21, N'Puthuppally')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2697, 24, N'Khowai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2698, 11, N'Vijaypur')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2699, 8, N'Takhatgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2700, 6, N'Thirupuvanam')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2701, 7, N'Adra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2702, 4, N'Piriyapatna')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2703, 9, N'Obra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2704, 1, N'Adalaj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2705, 2, N'Nandgaon')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2706, 10, N'Barh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2707, 1, N'Chhapra')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2708, 21, N'Panamattom')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2709, 9, N'Niwai')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2710, 22, N'Bageshwar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2711, 20, N'Tarbha')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2712, 4, N'Adyar')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2713, 11, N'Narsinghgarh')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2714, 2, N'Warud')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2715, 10, N'Asarganj')
GO
INSERT [dbo].[CityMaster] ([CityMasterId], [StateMasterId], [Name]) VALUES (2716, 14, N'Sarsod')
GO
SET IDENTITY_INSERT [dbo].[CityMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 
GO
INSERT [dbo].[Doctor] ([DoctorId], [StateMasterId], [CityMasterId], [Email], [Password], [Name], [BirthDate], [Aadhaar], [Mobile], [Gender], [Degree], [Designation], [HospitalName], [HospitalAddress], [HospitalPincode], [CreatedDate], [IsActive], [Profile]) VALUES (2, 1, 1521, N'suchit.devdigital@gmail.com', N'12345', N'Joe Smith', CAST(N'2020-03-13T00:00:00.000' AS DateTime), N'111111111111', N'9900099000', N'Male', N'M.B.B.S', N'Orthopedic', N'Walkheart', N'Waghodiya Road', N'390023', CAST(N'2020-03-13T14:45:30.373' AS DateTime), 1, NULL)
GO
INSERT [dbo].[Doctor] ([DoctorId], [StateMasterId], [CityMasterId], [Email], [Password], [Name], [BirthDate], [Aadhaar], [Mobile], [Gender], [Degree], [Designation], [HospitalName], [HospitalAddress], [HospitalPincode], [CreatedDate], [IsActive], [Profile]) VALUES (3, 1, 2320, N'micheal@gmail.com', N'12345', N'Micheal Hunt', CAST(N'1993-03-18T00:00:00.000' AS DateTime), N'333333333333', N'8800088000', N'Male', N'MS', N'General', N'Tri Color Multispecialist', N'Near old bus stand, Vapi', N'358800', CAST(N'2020-03-15T10:39:00.853' AS DateTime), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 
GO
INSERT [dbo].[Patient] ([PatientId], [StateMasterId], [CityMasterId], [Aadhaar], [BirthDate], [Mobile], [FirstName], [MiddleName], [LastName], [Gender], [BloodGroup], [Address], [Pincode], [CreatedDate], [Profile], [IsActive]) VALUES (1, 1, 1699, N'222222222222', CAST(N'2020-03-11T00:00:00.000' AS DateTime), N'8800088000', N'Ajay', N'Tinu', N'Virani', N'Male', N'A +ve', N'Zadeshwar Chokadi, Bharuch', N'369980', CAST(N'2020-03-13T22:38:27.787' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Patient] ([PatientId], [StateMasterId], [CityMasterId], [Aadhaar], [BirthDate], [Mobile], [FirstName], [MiddleName], [LastName], [Gender], [BloodGroup], [Address], [Pincode], [CreatedDate], [Profile], [IsActive]) VALUES (2, 6, 1554, N'444444444444', CAST(N'2020-03-15T00:00:00.000' AS DateTime), N'6600066000', N'Will', N'D', N'Smith', N'Male', N'O -ve', N'B/H X Mall, TN', N'892200', CAST(N'2020-03-15T10:41:06.363' AS DateTime), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
SET IDENTITY_INSERT [dbo].[Prescription] ON 
GO
INSERT [dbo].[Prescription] ([PrescriptionId], [TreatmentId], [Medicine], [Quntity], [Morning], [Noon], [Evening]) VALUES (1, 1, N'M1', 5, 1, 0, 0)
GO
INSERT [dbo].[Prescription] ([PrescriptionId], [TreatmentId], [Medicine], [Quntity], [Morning], [Noon], [Evening]) VALUES (2, 1, N'M2', 10, 1, 0, 1)
GO
INSERT [dbo].[Prescription] ([PrescriptionId], [TreatmentId], [Medicine], [Quntity], [Morning], [Noon], [Evening]) VALUES (3, 1, N'M3', 15, 1, 1, 1)
GO
INSERT [dbo].[Prescription] ([PrescriptionId], [TreatmentId], [Medicine], [Quntity], [Morning], [Noon], [Evening]) VALUES (4, 2, N'C1', 10, 1, 1, 1)
GO
INSERT [dbo].[Prescription] ([PrescriptionId], [TreatmentId], [Medicine], [Quntity], [Morning], [Noon], [Evening]) VALUES (5, 2, N'C2', 5, 0, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Prescription] OFF
GO
SET IDENTITY_INSERT [dbo].[StateMaster] ON 
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (1, N'Gujarat')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (2, N'Maharashtra')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (3, N'Delhi')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (4, N'Karnataka')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (5, N'Telangana')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (6, N'Tamil Nadu')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (7, N'West Bengal')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (8, N'Rajasthan')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (9, N'Uttar Pradesh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (10, N'Bihar')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (11, N'Madhya Pradesh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (12, N'Andhra Pradesh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (13, N'Punjab')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (14, N'Haryana')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (15, N'Jammu and Kashmir')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (16, N'Jharkhand')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (17, N'Chhattisgarh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (18, N'Assam')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (19, N'Chandigarh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (20, N'Odisha')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (21, N'Kerala')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (22, N'Uttarakhand')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (23, N'Puducherry')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (24, N'Tripura')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (25, N'Karnatka')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (26, N'Mizoram')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (27, N'Meghalaya')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (28, N'Manipur')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (29, N'Himachal Pradesh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (30, N'Nagaland')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (31, N'Goa')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (32, N'Andaman and Nicobar Islands')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (33, N'Arunachal Pradesh')
GO
INSERT [dbo].[StateMaster] ([StateMasterId], [Name]) VALUES (34, N'Dadra and Nagar Haveli')
GO
SET IDENTITY_INSERT [dbo].[StateMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Treatment] ON 
GO
INSERT [dbo].[Treatment] ([TreatmentId], [DoctorId], [PatientId], [DiseaseName], [DiseaseReview], [DiseaseRating], [Advice], [CreatedDate], [UpdatedDate], [AttachedFile]) VALUES (1, 2, 1, N'Covid-19', N'test', CAST(9.00 AS Decimal(18, 2)), N'test', CAST(N'2020-03-14T00:00:00.000' AS DateTime), NULL, N'17f9425f-a0f5-448b-bad0-7463a76b8474.jpg')
GO
INSERT [dbo].[Treatment] ([TreatmentId], [DoctorId], [PatientId], [DiseaseName], [DiseaseReview], [DiseaseRating], [Advice], [CreatedDate], [UpdatedDate], [AttachedFile]) VALUES (2, 3, 2, N'Flu', N'test', CAST(2.60 AS Decimal(18, 2)), N'test', CAST(N'2020-03-15T00:00:00.000' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Treatment] OFF
GO
ALTER TABLE [dbo].[Doctor] ADD  CONSTRAINT [DF_Doctor_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_Quntity]  DEFAULT ((0)) FOR [Quntity]
GO
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_Morning]  DEFAULT ((0)) FOR [Morning]
GO
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_Noon]  DEFAULT ((0)) FOR [Noon]
GO
ALTER TABLE [dbo].[Prescription] ADD  CONSTRAINT [DF_Prescription_Evening]  DEFAULT ((0)) FOR [Evening]
GO
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_StateMaster] FOREIGN KEY([StateMasterId])
REFERENCES [dbo].[StateMaster] ([StateMasterId])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_StateMaster]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_CityMaster] FOREIGN KEY([CityMasterId])
REFERENCES [dbo].[CityMaster] ([CityMasterId])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_CityMaster]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_StateMaster] FOREIGN KEY([StateMasterId])
REFERENCES [dbo].[StateMaster] ([StateMasterId])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_StateMaster]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_CityMaster] FOREIGN KEY([CityMasterId])
REFERENCES [dbo].[CityMaster] ([CityMasterId])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_CityMaster]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_StateMaster] FOREIGN KEY([StateMasterId])
REFERENCES [dbo].[StateMaster] ([StateMasterId])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_StateMaster]
GO
ALTER TABLE [dbo].[Prescription]  WITH CHECK ADD  CONSTRAINT [FK_Prescription_Treatment] FOREIGN KEY([TreatmentId])
REFERENCES [dbo].[Treatment] ([TreatmentId])
GO
ALTER TABLE [dbo].[Prescription] CHECK CONSTRAINT [FK_Prescription_Treatment]
GO
ALTER TABLE [dbo].[Treatment]  WITH CHECK ADD  CONSTRAINT [FK_Treatment_Doctor] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctor] ([DoctorId])
GO
ALTER TABLE [dbo].[Treatment] CHECK CONSTRAINT [FK_Treatment_Doctor]
GO
ALTER TABLE [dbo].[Treatment]  WITH CHECK ADD  CONSTRAINT [FK_Treatment_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([PatientId])
GO
ALTER TABLE [dbo].[Treatment] CHECK CONSTRAINT [FK_Treatment_Patient]
GO
