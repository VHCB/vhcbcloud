CREATE VIEW dbo.VW_Financial_Data
AS
SELECT     dbo.Trans.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Trans.Date AS [Transaction Date], 
                      dbo.Trans.TransAmt AS [Transaction Amount], dbo.AppName.Applicantname AS Payee, LookupValues_1.Description AS [Trans Action], 
                      LookupValues_2.Description AS Status, dbo.Detail.DetailID, dbo.Fund.name AS Fund, dbo.LookupValues.Description AS [Trans Type], 
                      dbo.Detail.Amount AS [Detail Amount]
FROM         dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID RIGHT OUTER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkTransaction = LookupValues_1.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID ON dbo.ApplicantAppName.ApplicantID = dbo.Trans.PayeeApplicant
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Detail.RowIsActive = 1) AND (dbo.Trans.RowIsActive = 1) AND (dbo.ApplicantAppName.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Financial_Data';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'layFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 167
               Left = 223
               Bottom = 275
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 114
               Left = 416
               Bottom = 222
               Right = 597
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 114
               Left = 635
               Bottom = 222
               Right = 788
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
      Begin ColumnWidths = 13
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Financial_Data';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[24] 3) )"
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
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 590
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 243
               Left = 505
               Bottom = 351
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 142
               Left = 847
               Bottom = 250
               Right = 998
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 1006
               Bottom = 114
               Right = 1157
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 140
               Left = 39
               Bottom = 248
               Right = 190
            End
            Disp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Financial_Data';

