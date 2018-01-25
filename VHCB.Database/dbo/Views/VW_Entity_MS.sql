CREATE VIEW dbo.VW_Entity_MS
AS
SELECT     dbo.ProjectEvent.ProjectEventID, dbo.AppName.Applicantname AS [Applicant Name], LookupValues_2.Description AS [Entity Milestone], dbo.ProjectEvent.Date, 
                      dbo.ProjectEvent.Note, dbo.ProjectEvent.URL, dbo.UserInfo.Username, LookupSubValues_2.SubDescription AS [Entity Sub], dbo.ApplicantAppName.ApplicantID
FROM         dbo.LookupValues AS LookupValues_2 RIGHT OUTER JOIN
                      dbo.ProjectEvent LEFT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_2 ON dbo.ProjectEvent.EntitySubMSID = LookupSubValues_2.SubTypeID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.AppName RIGHT OUTER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON dbo.ProjectEvent.ApplicantID = dbo.ApplicantAppName.ApplicantID ON 
                      LookupValues_2.TypeID = dbo.ProjectEvent.EntityMSID
WHERE     (dbo.ProjectEvent.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Entity_MS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'00
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Entity_MS';


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
               Top = 1
               Left = 35
               Bottom = 109
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "LookupSubValues_2"
            Begin Extent = 
               Top = 198
               Left = 39
               Bottom = 306
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 214
               Left = 228
               Bottom = 322
               Right = 382
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 47
               Left = 229
               Bottom = 155
               Right = 382
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 3
               Left = 583
               Bottom = 111
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 114
               Left = 829
               Bottom = 222
               Right = 980
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
      Begin ColumnWidths = 19
         Width = 284
         Width = 15', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Entity_MS';

