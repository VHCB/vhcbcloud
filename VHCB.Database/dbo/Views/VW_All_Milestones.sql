CREATE VIEW dbo.VW_All_Milestones
AS
SELECT     dbo.ProjectEvent.ProjectEventID, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.AppName.Applicantname, dbo.LookupValues.Description AS [Admin Milestone], LookupValues_1.Description AS [Program Milestone], 
                      LookupValues_2.Description AS [Entity Milestone], dbo.ProjectEvent.Date, dbo.ProjectEvent.Note, dbo.ProjectEvent.URL, dbo.UserInfo.Username, 
                      dbo.LookupValues.TypeID, LookupSubValues_1.SubDescription AS [Admin Sub], dbo.LookupSubValues.SubDescription AS [Program Sub], 
                      LookupSubValues_2.SubDescription AS [Entity Sub], dbo.ApplicantAppName.ApplicantID, dbo.VWLK_ProjectNames.ProjectID
FROM         dbo.LookupSubValues AS LookupSubValues_1 RIGHT OUTER JOIN
                      dbo.LookupValues ON LookupSubValues_1.TypeID = dbo.LookupValues.TypeID RIGHT OUTER JOIN
                      dbo.ProjectEvent LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ProjectEvent.ApplicantID = dbo.ApplicantAppName.ApplicantID LEFT OUTER JOIN
                      dbo.VWLK_ProjectNames ON dbo.ProjectEvent.ProjectID = dbo.VWLK_ProjectNames.ProjectID ON 
                      dbo.LookupValues.TypeID = dbo.ProjectEvent.EventID LEFT OUTER JOIN
                      dbo.LookupSubValues RIGHT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.LookupSubValues.TypeID = LookupValues_1.TypeID ON 
                      dbo.ProjectEvent.ProgEventID = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_2 RIGHT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON LookupSubValues_2.TypeID = LookupValues_2.TypeID ON dbo.ProjectEvent.EntityMSID = LookupValues_2.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectEvent.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Milestones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LookupSubValues"
            Begin Extent = 
               Top = 339
               Left = 714
               Bottom = 447
               Right = 865
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 215
               Left = 618
               Bottom = 323
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupSubValues_2"
            Begin Extent = 
               Top = 324
               Left = 923
               Bottom = 432
               Right = 1074
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 184
               Left = 775
               Bottom = 292
               Right = 926
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 2160
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
         Alias = 1890
         Table = 1830
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Milestones';


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
         Begin Table = "LookupSubValues_1"
            Begin Extent = 
               Top = 332
               Left = 443
               Bottom = 440
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 171
               Left = 407
               Bottom = 279
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectEvent"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 111
               Left = 958
               Bottom = 219
               Right = 1112
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 26
               Left = 514
               Bottom = 134
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 0
               Left = 292
               Bottom = 108
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 185
               Left = 216
               Bottom = 293
               Right = 368
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_All_Milestones';

