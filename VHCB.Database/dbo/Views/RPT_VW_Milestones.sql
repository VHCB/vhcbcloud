CREATE VIEW dbo.RPT_VW_Milestones
AS
SELECT     dbo.VWLK_VHCBPrograms.Description AS Program, dbo.VWLK_ProjectNames.Description AS ProjectName, dbo.VWLK_ApplicantName.Applicantname, 
                      dbo.VWLK_Events_All.Description AS ProgramMilestone, dbo.VWLK_Event_SubEvent.Description AS Milestone, dbo.ProjectEvent.Date, dbo.ProjectEvent.Note
FROM         dbo.ProjectEvent INNER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.ProjectEvent.Prog = dbo.VWLK_VHCBPrograms.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.ProjectEvent.ProjectID = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_ApplicantName ON dbo.ProjectEvent.ApplicantID = dbo.VWLK_ApplicantName.ApplicantId INNER JOIN
                      dbo.VWLK_Events_All ON dbo.ProjectEvent.EventID = dbo.VWLK_Events_All.TypeID INNER JOIN
                      dbo.VWLK_Event_SubEvent ON dbo.ProjectEvent.SubEventID = dbo.VWLK_Event_SubEvent.TypeID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'RPT_VW_Milestones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'RPT_VW_Milestones';


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
            TopColumn = 7
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 6
               Left = 229
               Bottom = 84
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 418
               Bottom = 114
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 6
               Left = 607
               Bottom = 114
               Right = 762
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Events_All"
            Begin Extent = 
               Top = 6
               Left = 800
               Bottom = 84
               Right = 951
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Event_SubEvent"
            Begin Extent = 
               Top = 6
               Left = 989
               Bottom = 84
               Right = 1140
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
      Begin ColumnWidths = 9
         Width = 284
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'RPT_VW_Milestones';

