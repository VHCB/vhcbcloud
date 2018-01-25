CREATE VIEW dbo.VW_RPT_BasicProjectFinancial
AS
SELECT     dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.Detail.Amount, dbo.Project.LkProjectType, dbo.Trans.TransId, dbo.Trans.Date, dbo.Detail.DetailID, 
                      dbo.Fund.name AS [Fund Name], dbo.Fund.abbrv, dbo.LkFundType.Description AS [Fund Group], dbo.Trans.TransAmt, dbo.Trans.LkTransaction, dbo.Trans.LkStatus, 
                      dbo.Detail.LkTransType, dbo.LkFundType.LkSource, LookupValues_1.Description AS [Fund Source], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      LookupValues_2.Description AS [Conserve Goal], dbo.LookupValues.Description AS Program, dbo.[VWLK_Primary Applicant].[Primary Applicant]
FROM         dbo.[VWLK_Primary Applicant] RIGHT OUTER JOIN
                      dbo.Project ON dbo.[VWLK_Primary Applicant].ProjectId = dbo.Project.ProjectId LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.Project.LkProgram = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Project.Goal = LookupValues_2.TypeID LEFT OUTER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID AND dbo.Project.RowIsActive = 1 AND 
                      dbo.VWLK_ProjectNames.DefName = 1 LEFT OUTER JOIN
                      dbo.Detail INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId AND dbo.Trans.RowIsActive = 1 INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId AND dbo.Fund.RowIsActive = 1 INNER JOIN
                      dbo.LkFundType ON dbo.Fund.LkFundType = dbo.LkFundType.TypeId AND dbo.LkFundType.RowIsActive = 1 INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.LkFundType.LkSource = LookupValues_1.TypeID AND LookupValues_1.RowIsActive = 1 ON 
                      dbo.Project.ProjectId = dbo.Trans.ProjectID AND dbo.Trans.RowIsActive = 1
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_BasicProjectFinancial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 28
               Left = 769
               Bottom = 136
               Right = 920
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkFundType"
            Begin Extent = 
               Top = 34
               Left = 941
               Bottom = 142
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 181
               Left = 950
               Bottom = 289
               Right = 1101
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
      Begin ColumnWidths = 21
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_BasicProjectFinancial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "VWLK_Primary Applicant"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 22
               Left = 55
               Bottom = 130
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 213
               Left = 412
               Bottom = 321
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 173
               Left = 25
               Bottom = 281
               Right = 176
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 202
               Left = 235
               Bottom = 310
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 26
               Left = 549
               Bottom = 134
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 24
               Left = 296
               Bottom = 132
               Right = 469
            End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_BasicProjectFinancial';

