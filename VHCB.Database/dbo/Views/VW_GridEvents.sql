CREATE VIEW dbo.VW_GridEvents
AS
SELECT     dbo.ProjectEvent.Date, dbo.VWLK_Event_Housing.Description AS SubEvent, dbo.AppName.Applicantname, dbo.VWLK_Event_SubEvent.Description AS Event, 
                      dbo.VWLK_ProjectNames.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectEvent.EventID, dbo.ProjectEvent.Note, 
                      dbo.UserInfo.Username
FROM         dbo.UserInfo INNER JOIN
                      dbo.ProjectEvent INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.ProjectEvent.ProjectID = dbo.VWLK_ProjectNames.ProjectID ON dbo.UserInfo.UserId = dbo.ProjectEvent.UserID LEFT OUTER JOIN
                      dbo.VWLK_Event_Housing ON dbo.ProjectEvent.EventID = dbo.VWLK_Event_Housing.TypeID LEFT OUTER JOIN
                      dbo.VWLK_Event_SubEvent ON dbo.ProjectEvent.SubEventID = dbo.VWLK_Event_SubEvent.TypeID LEFT OUTER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ProjectEvent.ApplicantID = dbo.ApplicantAppName.ApplicantID
WHERE     (dbo.ProjectEvent.EventID <> 0) AND (dbo.ProjectEvent.RowIsActive = 1) AND (dbo.ApplicantAppName.DefName = 1) AND (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GridEvents';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           End
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
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GridEvents';


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
               Top = 6
               Left = 38
               Bottom = 114
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "VWLK_Event_Housing"
            Begin Extent = 
               Top = 133
               Left = 282
               Bottom = 211
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 6
               Left = 418
               Bottom = 114
               Right = 599
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 6
               Left = 637
               Bottom = 114
               Right = 790
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Event_SubEvent"
            Begin Extent = 
               Top = 164
               Left = 32
               Bottom = 242
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 146
               Left = 536
               Bottom = 254
               Right = 688
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 152
               Left = 828
               Bottom = 260
               Right = 982
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GridEvents';

