CREATE VIEW dbo.VW_checkrequest2
AS
SELECT     TOP (100) PERCENT dbo.Project.Proj_num, dbo.ProjectCheckReq.LkProgram, dbo.LookupValues.Description AS [Nature of Dsibursement], 
                      dbo.LkPCRQuestions.Description, dbo.VW_ProjectName.Description AS Expr1, dbo.VW_ProjectName.Applicantname
FROM         dbo.ProjectCheckReq INNER JOIN
                      dbo.Project ON dbo.ProjectCheckReq.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.ProjectCheckReqNOD ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.ProjectCheckReqNOD.ProjectCheckReqID INNER JOIN
                      dbo.ProjectCheckReqQuestions ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.ProjectCheckReqQuestions.ProjectCheckReqID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectCheckReqNOD.LKNOD = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LkPCRQuestions ON dbo.ProjectCheckReqQuestions.LkPCRQuestionsID = dbo.LkPCRQuestions.TypeID INNER JOIN
                      dbo.VW_ProjectName ON dbo.Project.ProjectId = dbo.VW_ProjectName.ProjectId CROSS JOIN
                      dbo.VW_PayeeName
ORDER BY dbo.Project.Proj_num
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_checkrequest2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'72
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VW_PayeeName"
            Begin Extent = 
               Top = 254
               Left = 214
               Bottom = 332
               Right = 365
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
         Width = 1500
         Width = 1500
         Width = 3945
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_checkrequest2';


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
         Begin Table = "ProjectCheckReq"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 133
               Left = 37
               Bottom = 241
               Right = 188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectCheckReqNOD"
            Begin Extent = 
               Top = 7
               Left = 321
               Bottom = 115
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectCheckReqQuestions"
            Begin Extent = 
               Top = 133
               Left = 317
               Bottom = 241
               Right = 533
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 6
               Left = 543
               Bottom = 114
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkPCRQuestions"
            Begin Extent = 
               Top = 6
               Left = 732
               Bottom = 114
               Right = 883
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VW_ProjectName"
            Begin Extent = 
               Top = 6
               Left = 921
               Bottom = 114
               Right = 10', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_checkrequest2';

