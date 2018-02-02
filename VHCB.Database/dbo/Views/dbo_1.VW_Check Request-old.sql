CREATE VIEW dbo.[dbo.VW_Check Request-old]
AS
SELECT DISTINCT 
                      dbo.Project.Proj_num, dbo.ApplicantName.Applicantname, dbo.Trans.TransAmt, dbo.ProjectCheckReq.Final, dbo.ProjectCheckReq.Voucher#, 
                      dbo.ProjectCheckReq.VoucherDate, dbo.LkProgram.Description, dbo.LkNOD.Description AS [Nature of Disburse], dbo.Trans.Date
FROM         dbo.LkProgram INNER JOIN
                      dbo.ProjectCheckReq ON dbo.LkProgram.TypeId = dbo.ProjectCheckReq.LkProgram INNER JOIN
                      dbo.LkNOD ON dbo.ProjectCheckReq.LkNOD = dbo.LkNOD.TypeID INNER JOIN
                      dbo.PCRPCRQuestions ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.PCRPCRQuestions.ProjectCheckReqID INNER JOIN
                      dbo.PCRQuestions ON dbo.PCRPCRQuestions.PCRQuestionID = dbo.PCRQuestions.PCRQuestionID LEFT OUTER JOIN
                      dbo.LkPCRQuestions ON dbo.PCRQuestions.LkPCRQuestion = dbo.LkPCRQuestions.TypeID LEFT OUTER JOIN
                      dbo.Detail INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.ProjectApplicant ON dbo.Trans.PayeeApplicant = dbo.ProjectApplicant.ProjectApplicantID INNER JOIN
                      dbo.ApplicantName ON dbo.ProjectApplicant.ApplicantId = dbo.ApplicantName.ApplicantId INNER JOIN
                      dbo.ProjectName ON dbo.Project.ProjectId = dbo.ProjectName.ProjectID ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.Trans.ProjectCheckReqID
WHERE     (dbo.ApplicantName.DefName = 1) AND (dbo.ProjectName.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'dbo.VW_Check Request-old';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'splayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ProjectName"
            Begin Extent = 
               Top = 273
               Left = 32
               Bottom = 381
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkProgram"
            Begin Extent = 
               Top = 221
               Left = 689
               Bottom = 314
               Right = 840
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkNOD"
            Begin Extent = 
               Top = 102
               Left = 838
               Bottom = 195
               Right = 989
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PCRPCRQuestions"
            Begin Extent = 
               Top = 283
               Left = 346
               Bottom = 391
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PCRQuestions"
            Begin Extent = 
               Top = 318
               Left = 557
               Bottom = 426
               Right = 711
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkPCRQuestions"
            Begin Extent = 
               Top = 318
               Left = 749
               Bottom = 426
               Right = 900
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'dbo.VW_Check Request-old';


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
         Top = -116
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProjectCheckReq"
            Begin Extent = 
               Top = 6
               Left = 13
               Bottom = 114
               Right = 186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 460
               Bottom = 114
               Right = 611
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 649
               Bottom = 114
               Right = 800
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 140
               Left = 51
               Bottom = 248
               Right = 202
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 158
               Left = 252
               Bottom = 266
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantName"
            Begin Extent = 
               Top = 160
               Left = 478
               Bottom = 268
               Right = 640
            End
            Di', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'dbo.VW_Check Request-old';

