CREATE VIEW dbo.VWDH_ApplicantAddress
AS
SELECT DISTINCT 
                      dbo.AppName.Applicantname, dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Address2, dbo.Address.Town, dbo.Address.County, dbo.Address.State, 
                      dbo.Address.Zip, dbo.ApplicantAppName.ApplicantID, dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.ApplicantAddress.DefAddress, dbo.ApplicantAppName.DefName,
                       dbo.Applicant.email, dbo.Applicant.Phone, dbo.ProjectApplicant.ProjectApplicantID
FROM         dbo.Project INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId INNER JOIN
                      dbo.Applicant ON dbo.ProjectApplicant.ApplicantId = dbo.Applicant.ApplicantId INNER JOIN
                      dbo.Address INNER JOIN
                      dbo.ApplicantAddress ON dbo.Address.AddressId = dbo.ApplicantAddress.AddressId INNER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ApplicantAddress.ApplicantId = dbo.ApplicantAppName.ApplicantID ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID
WHERE     (dbo.Project.LkProgram = 146) AND (dbo.ProjectApplicant.IsApplicant = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWDH_ApplicantAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          DisplayFlags = 280
            TopColumn = 2
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWDH_ApplicantAddress';


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
               Left = 58
               Bottom = 120
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 12
               Left = 339
               Bottom = 120
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applicant"
            Begin Extent = 
               Top = 161
               Left = 480
               Bottom = 269
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Address"
            Begin Extent = 
               Top = 173
               Left = 65
               Bottom = 281
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAddress"
            Begin Extent = 
               Top = 6
               Left = 844
               Bottom = 114
               Right = 1018
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 206
               Left = 781
               Bottom = 314
               Right = 934
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 7
               Left = 548
               Bottom = 115
               Right = 729
            End
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWDH_ApplicantAddress';

