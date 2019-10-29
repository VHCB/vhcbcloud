CREATE VIEW dbo.VW_All_Assignments
AS
SELECT DISTINCT 
                      dbo.Trans.ProjectID AS [From ProjectID], dbo.Project.Proj_num AS [From Project Number], dbo.VWLK_ProjectNames.Description AS [From Project Name], 
                      dbo.[VWLK_Primary Applicant].[Primary Applicant] AS [From Applicant], dbo.Trans.Date, dbo.ReallocateLink.FromTransID, dbo.ReallocateLink.ToTransID, 
                      dbo.ReallocateLink.ToProjectId, [VWLK_Primary Applicant_1].[Primary Applicant] AS [To Applicant], Project_1.Proj_num AS [To Project Number], 
                      VWLK_ProjectNames_1.Description AS [To Project Name], dbo.Detail.Amount AS [From Detail Amt], Detail_1.Amount AS [To Detail Amt], dbo.Detail.DetailID, 
                      dbo.Trans.RowIsActive AS [From Trans Rowisactive], dbo.Detail.RowIsActive AS [From Detail Rowisactive], dbo.LookupValues.Description AS Status, 
                      dbo.VWLK_VHCBPrograms.Description AS Program, dbo.Fund.name AS [From Fund], Fund_1.name AS [To Fund], 
                      dbo.VWLK_FinancialTransactionType.Description AS [From Transaction Type], VWLK_FinancialTransactionType_1.Description AS [To Transaction Type], 
                      dbo.ReallocateLink.ReallocateGUID
FROM         dbo.Fund INNER JOIN
                      dbo.[VWLK_Primary Applicant] AS [VWLK_Primary Applicant_1] INNER JOIN
                      dbo.VWLK_ProjectNames AS VWLK_ProjectNames_1 INNER JOIN
                      dbo.Trans AS Trans_1 INNER JOIN
                      dbo.ReallocateLink ON Trans_1.TransId = dbo.ReallocateLink.ToTransID INNER JOIN
                      dbo.Detail AS Detail_1 ON Trans_1.TransId = Detail_1.TransId INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId ON dbo.ReallocateLink.FromTransID = dbo.Trans.TransId INNER JOIN
                      dbo.Project AS Project_1 ON dbo.ReallocateLink.ToProjectId = Project_1.ProjectId ON VWLK_ProjectNames_1.ProjectID = Project_1.ProjectId ON 
                      [VWLK_Primary Applicant_1].ProjectId = dbo.ReallocateLink.ToProjectId INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkStatus = dbo.LookupValues.TypeID ON dbo.Fund.FundId = dbo.Detail.FundId INNER JOIN
                      dbo.Fund AS Fund_1 ON Detail_1.FundId = Fund_1.FundId INNER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID INNER JOIN
                      dbo.VWLK_FinancialTransactionType AS VWLK_FinancialTransactionType_1 ON Detail_1.LkTransType = VWLK_FinancialTransactionType_1.TypeID LEFT OUTER JOIN
                      dbo.VWLK_VHCBPrograms INNER JOIN
                      dbo.[VWLK_Primary Applicant] INNER JOIN
                      dbo.VWLK_ProjectNames INNER JOIN
                      dbo.Project ON dbo.VWLK_ProjectNames.ProjectID = dbo.Project.ProjectId ON dbo.[VWLK_Primary Applicant].ProjectId = dbo.Project.ProjectId ON 
                      dbo.VWLK_VHCBPrograms.TypeID = dbo.Project.LkProgram ON dbo.Trans.ProjectID = dbo.Project.ProjectId AND Project_1.Proj_num <> dbo.Project.Proj_num
WHERE     (dbo.Trans.LkTransaction = 26552) AND (dbo.Project.Proj_num <> Project_1.Proj_num) AND (dbo.VWLK_ProjectNames.DefName = 1) AND 
                      (VWLK_ProjectNames_1.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[15] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VWLK_ProjectNames_1"
            Begin Extent = 
               Top = 6
               Left = 887
               Bottom = 114
               Right = 1039
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 164
               Left = 423
               Bottom = 272
               Right = 596
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 163
               Left = 205
               Bottom = 271
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 158
               Left = 667
               Bottom = 266
               Right = 818
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 5
               Left = 320
               Bottom = 113
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 6
               Left = 698
               Bottom = 114
               Right = 849
            End
            D', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Assignments';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Assignments';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'pBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Assignments';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'isplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 277
               Left = 19
               Bottom = 385
               Right = 171
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 143
               Left = 14
               Bottom = 251
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Primary Applicant"
            Begin Extent = 
               Top = 292
               Left = 652
               Bottom = 370
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Primary Applicant_1"
            Begin Extent = 
               Top = 152
               Left = 900
               Bottom = 230
               Right = 1063
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 301
               Left = 222
               Bottom = 409
               Right = 373
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 6
               Left = 509
               Bottom = 84
               Right = 660
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 1077
               Bottom = 114
               Right = 1228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund_1"
            Begin Extent = 
               Top = 264
               Left = 1094
               Bottom = 372
               Right = 1245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 294
               Left = 437
               Bottom = 372
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType_1"
            Begin Extent = 
               Top = 269
               Left = 865
               Bottom = 347
               Right = 1016
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3105
         Table = 2010
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         Grou', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Assignments';

