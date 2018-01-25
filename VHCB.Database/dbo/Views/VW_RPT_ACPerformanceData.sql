CREATE VIEW dbo.VW_RPT_ACPerformanceData
AS
SELECT DISTINCT 
                      dbo.ACYrQtr.Year, dbo.ACYrQtr.Qtr, dbo.UserInfo.Fname, dbo.UserInfo.Lname, dbo.VWLK_ProjectNames.Proj_num, 
                      dbo.VWLK_ProjectNames.Description AS [Host Site], dbo.ACPerformanceMaster.QuestionNum, dbo.ACPerformanceMaster.LabelDefinition, dbo.ACPerfData.Response, 
                      dbo.ACPerfData.IsCompleted, dbo.ACYrQtr.ACYrQtrID, dbo.VWLK_ApplicantName.Applicantname, dbo.ACPerfData.ACPerfDataID, 
                      dbo.ACPerformanceMaster.ResultType, dbo.ACMemberPerfData.MemberIncluded, dbo.ACMemberPerfData.UserID
FROM         dbo.ACPerformanceMaster INNER JOIN
                      dbo.ACPerfData ON dbo.ACPerformanceMaster.ACPerformanceMasterID = dbo.ACPerfData.ACPerformanceMasterID INNER JOIN
                      dbo.ACMemberPerfData INNER JOIN
                      dbo.ACYrQtr ON dbo.ACMemberPerfData.ACYrQtrID = dbo.ACYrQtr.ACYrQtrID ON dbo.ACPerfData.UserID = dbo.ACMemberPerfData.UserID AND 
                      dbo.ACPerformanceMaster.ACYrQtrID = dbo.ACYrQtr.ACYrQtrID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName INNER JOIN
                      dbo.UserInfo INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.UserInfo.NumbProj = dbo.VWLK_ProjectNames.ProjectID ON dbo.VWLK_ApplicantName.ApplicantId = dbo.UserInfo.HostSite ON 
                      dbo.ACPerfData.UserID = dbo.UserInfo.UserId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.VWLK_ApplicantName.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ACPerformanceData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            End
            DisplayFlags = 280
            TopColumn = 1
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
         Width = 2220
         Width = 1500
         Width = 3435
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4305
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ACPerformanceData';


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
         Begin Table = "ACPerformanceMaster"
            Begin Extent = 
               Top = 174
               Left = 126
               Bottom = 282
               Right = 325
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ACPerfData"
            Begin Extent = 
               Top = 109
               Left = 460
               Bottom = 217
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 40
               Left = 991
               Bottom = 148
               Right = 1146
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 27
               Left = 59
               Bottom = 135
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 4
               Left = 706
               Bottom = 112
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ACYrQtr"
            Begin Extent = 
               Top = 207
               Left = 905
               Bottom = 300
               Right = 1056
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ACMemberPerfData"
            Begin Extent = 
               Top = 281
               Left = 302
               Bottom = 389
               Right = 472', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ACPerformanceData';

