CREATE VIEW dbo.[VW_Check Request Approvals]
AS
SELECT     TOP (100) PERCENT dbo.ProjectCheckReq.ProjectCheckReqID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.ProjectCheckReq.Final, dbo.LkPCRQuestions.Description AS Question, dbo.ProjectCheckReqQuestions.Approved, 
                      dbo.ProjectCheckReqQuestions.Date AS [Approval Date], dbo.UserInfo.Username AS [Approved By], dbo.ProjectCheckReq.InitDate AS [Initial Date entered], 
                      dbo.ProjectCheckReq.CRDate AS [Check Request Date], dbo.ProjectCheckReqQuestions.ProjectCheckReqQuestionID
FROM         dbo.LkPCRQuestions INNER JOIN
                      dbo.ProjectCheckReqQuestions INNER JOIN
                      dbo.ProjectCheckReq ON dbo.ProjectCheckReqQuestions.ProjectCheckReqID = dbo.ProjectCheckReq.ProjectCheckReqID INNER JOIN
                      dbo.PCRQuestions ON dbo.ProjectCheckReqQuestions.LkPCRQuestionsID = dbo.PCRQuestions.PCRQuestionID ON 
                      dbo.LkPCRQuestions.TypeID = dbo.PCRQuestions.LkPCRQuestions INNER JOIN
                      dbo.Project ON dbo.ProjectCheckReq.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 INNER JOIN
                      dbo.UserInfo ON dbo.ProjectCheckReqQuestions.StaffID = dbo.UserInfo.UserId
ORDER BY dbo.ProjectCheckReqQuestions.ProjectCheckReqID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Approvals';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         End
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Approvals';


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
            TopColumn = 0
         End
         Begin Table = "ProjectCheckReqQuestions"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PCRQuestions"
            Begin Extent = 
               Top = 6
               Left = 503
               Bottom = 114
               Right = 676
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkPCRQuestions"
            Begin Extent = 
               Top = 6
               Left = 714
               Bottom = 114
               Right = 865
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 148
               Left = 489
               Bottom = 256
               Right = 643
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 180
               Left = 82
               Bottom = 288
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 178
               Left = 317
               Bottom = 286
               Right = 469
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Approvals';

