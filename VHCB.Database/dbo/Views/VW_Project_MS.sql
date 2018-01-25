CREATE VIEW dbo.VW_Project_MS
AS
SELECT     dbo.ProjectEvent.ProjectEventID, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS [Admin Milestone], LookupValues_1.Description AS [Program Milestone], dbo.ProjectEvent.Date, dbo.ProjectEvent.Note, 
                      dbo.ProjectEvent.URL, dbo.UserInfo.Username, dbo.LookupSubValues.SubDescription AS [Program Sub], dbo.VWLK_ProjectNames.ProjectID, 
                      LookupSubValues_1.SubDescription, dbo.ProjectEvent.EntityMSID, dbo.ProjectEvent.EntitySubMSID
FROM         dbo.LookupValues AS LookupValues_1 LEFT OUTER JOIN
                      dbo.LookupSubValues ON LookupValues_1.TypeID = dbo.LookupSubValues.TypeID RIGHT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_1 RIGHT OUTER JOIN
                      dbo.LookupValues ON LookupSubValues_1.TypeID = dbo.LookupValues.TypeID RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames RIGHT OUTER JOIN
                      dbo.ProjectEvent LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId ON dbo.VWLK_ProjectNames.ProjectID = dbo.ProjectEvent.ProjectID ON 
                      dbo.LookupValues.TypeID = dbo.ProjectEvent.EventID ON LookupValues_1.TypeID = dbo.ProjectEvent.ProgEventID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectEvent.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_MS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       End
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
      Begin ColumnWidths = 19
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_MS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[14] 2[20] 3) )"
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
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 3
               Left = 240
               Bottom = 111
               Right = 392
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectEvent"
            Begin Extent = 
               Top = 17
               Left = 30
               Bottom = 125
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 166
               Left = 60
               Bottom = 274
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 6
               Left = 430
               Bottom = 114
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupSubValues"
            Begin Extent = 
               Top = 6
               Left = 619
               Bottom = 114
               Right = 770
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupSubValues_1"
            Begin Extent = 
               Top = 143
               Left = 775
               Bottom = 251
               Right = 926
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 6
               Left = 997
               Bottom = 114
               Right = 1148
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_MS';

