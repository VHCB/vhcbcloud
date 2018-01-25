CREATE VIEW dbo.VW_Committed_Funds
AS
SELECT DISTINCT 
                      dbo.Trans.Date, SUM(dbo.Trans.TransAmt) AS TotAmount, dbo.LookupValues.Description, dbo.Trans.PayeeApplicant, LookupValues_1.Description AS PendFinal, 
                      dbo.AppName.Applicantname, dbo.Trans.LkTransaction, dbo.Fund.name AS FundName, dbo.ProjectName.LkProjectname, LookupValues_2.Description AS ProjName, 
                      dbo.Project.Proj_num
FROM         dbo.Trans INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID AND dbo.Trans.LkTransaction = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkStatus = LookupValues_1.TypeID INNER JOIN
                      dbo.Applicant ON dbo.Trans.PayeeApplicant = dbo.Applicant.ApplicantId INNER JOIN
                      dbo.ApplicantAppName ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.ApplicantAppNameID = dbo.AppName.AppNameID INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.ProjectName ON dbo.Trans.ProjectID = dbo.ProjectName.ProjectID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.ProjectName.LkProjectname = LookupValues_2.TypeID INNER JOIN
                      dbo.Project ON dbo.ProjectName.ProjectID = dbo.Project.ProjectId
GROUP BY dbo.Trans.Date, dbo.Trans.TransAmt, dbo.LookupValues.Description, dbo.Trans.PayeeApplicant, LookupValues_1.Description, dbo.AppName.Applicantname, 
                      dbo.Trans.LkTransaction, dbo.Fund.name, dbo.ProjectName.LkProjectname, LookupValues_2.Description, dbo.Project.Proj_num
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Committed_Funds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 181
               Left = 1023
               Bottom = 289
               Right = 1174
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectName"
            Begin Extent = 
               Top = 149
               Left = 7
               Bottom = 257
               Right = 159
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 247
               Left = 455
               Bottom = 355
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 130
               Left = 517
               Bottom = 238
               Right = 668
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Committed_Funds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[17] 2[18] 3) )"
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
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 4
               Left = 323
               Bottom = 112
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 179
               Left = 244
               Bottom = 287
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applicant"
            Begin Extent = 
               Top = 193
               Left = 725
               Bottom = 301
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 8
               Left = 512
               Bottom = 116
               Right = 705
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 4
               Left = 785
               Bottom = 112
               Right = 966
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 12
               Left = 1049
               Bottom = 120
               Right = 1200
            End
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Committed_Funds';

