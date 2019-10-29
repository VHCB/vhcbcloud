CREATE VIEW dbo.VW_Events_RPT
AS
SELECT DISTINCT 
                      dbo.ProjectEvent.ProjectID, dbo.ProjectEvent.ProjectEventID, dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectEvent.Date, 
                      dbo.ProjectEvent.Note, dbo.UserInfo.Username, dbo.VWLK_Events_All.Description AS SubEvent, dbo.VWLK_Event_SubEvent.Description AS Event, 
                      dbo.VWLK_ProjectNames.DefName
FROM         dbo.UserInfo RIGHT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames INNER JOIN
                      dbo.ProjectEvent ON dbo.VWLK_ProjectNames.ProjectID = dbo.ProjectEvent.ProjectID ON dbo.Project.ProjectId = dbo.ProjectEvent.ProjectID AND 
                      dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_Event_SubEvent ON dbo.ProjectEvent.SubEventID = dbo.VWLK_Event_SubEvent.TypeID INNER JOIN
                      dbo.VWLK_Events_All ON dbo.ProjectEvent.EventID = dbo.VWLK_Events_All.TypeID ON dbo.UserInfo.UserId = dbo.ProjectEvent.UserID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)
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
         Begin Table = "ProjectEvent"
            Begin Extent = 
               Top = 29
               Left = 11
               Bottom = 137
               Right = 164
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "VWLK_Events_All"
            Begin Extent = 
               Top = 0
               Left = 204
               Bottom = 78
               Right = 355
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Event_SubEvent"
            Begin Extent = 
               Top = 8
               Left = 447
               Bottom = 86
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 257
               Left = 75
               Bottom = 365
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 34
               Left = 1000
               Bottom = 127
               Right = 1151
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 193
               Left = 1039
               Bottom = 301
               Right = 1190
            End
            DisplayFlags = 280
            TopColumn = 11
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Widt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Events_RPT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Events_RPT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'h = 1500
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
         Table = 2265
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Events_RPT';

