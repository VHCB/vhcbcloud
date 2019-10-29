CREATE VIEW dbo.VW_RPT_ProjectMilestones
AS
SELECT DISTINCT 
                      dbo.ProjectEvent.ProjectEventID, dbo.Project.Proj_num AS [Project Number], dbo.ProjectEvent.ProjectID, dbo.VWLK_ProjectNames.Description AS ProjectName, 
                      dbo.VWLK_VHCBPrograms.Description AS Program, LookupValues_1.Description AS [Admin Milestone], 
                      dbo.LookupSubValues.SubDescription AS [Admin SubMilestone], dbo.LookupValues.Description AS [Program Milestone], 
                      LookupSubValues_1.SubDescription AS [Program SubMilestone], dbo.ProjectEvent.Date, dbo.ProjectEvent.Note, dbo.UserInfo.Username, 
                      dbo.VWLK_ApplicantName.Applicantname, dbo.ProjectEvent.URL
FROM         dbo.Project RIGHT OUTER JOIN
                      dbo.ProjectEvent ON dbo.Project.ProjectId = dbo.ProjectEvent.ProjectID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectEvent.ProgEventID = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_1 ON dbo.ProjectEvent.ProgSubEventID = LookupSubValues_1.SubTypeID LEFT OUTER JOIN
                      dbo.LookupSubValues ON dbo.ProjectEvent.SubEventID = dbo.LookupSubValues.SubTypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectEvent.EventID = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.ProjectEvent.Prog = dbo.VWLK_VHCBPrograms.TypeID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.ProjectEvent.ApplicantID = dbo.VWLK_ApplicantName.ApplicantId LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectEvent.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMilestones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 5
               Left = 518
               Bottom = 83
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 86
               Left = 503
               Bottom = 194
               Right = 658
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 247
               Left = 539
               Bottom = 355
               Right = 693
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
      Begin ColumnWidths = 17
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3165
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
         Column = 2745
         Alias = 2100
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMilestones';


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
         Begin Table = "Project"
            Begin Extent = 
               Top = 12
               Left = 55
               Bottom = 120
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 0
               Left = 253
               Bottom = 108
               Right = 405
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ProjectEvent"
            Begin Extent = 
               Top = 164
               Left = 12
               Bottom = 272
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 154
               Left = 1000
               Bottom = 262
               Right = 1151
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupSubValues_1"
            Begin Extent = 
               Top = 301
               Left = 760
               Bottom = 409
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupSubValues"
            Begin Extent = 
               Top = 364
               Left = 543
               Bottom = 472
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 337
               Left = 125
               Bottom = 445
               Right = 276', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMilestones';

