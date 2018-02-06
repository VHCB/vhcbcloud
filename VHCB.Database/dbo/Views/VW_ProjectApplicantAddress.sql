CREATE VIEW dbo.VW_ProjectApplicantAddress
AS
SELECT DISTINCT 
                      dbo.ProjectApplicant.ProjectId, dbo.Project.Proj_num, dbo.AppName.Applicantname, dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Address2, 
                      dbo.Address.Village, dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County, dbo.Address.latitude, dbo.Address.longitude, dbo.Applicant.email, 
                      dbo.Applicant.CellPhone, dbo.Applicant.Phone, dbo.Applicant.HomePhone, dbo.Applicant.WorkPhone, dbo.ProjectApplicant.ProjectApplicantID, 
                      dbo.ProjectApplicant.IsApplicant, dbo.ProjectApplicant.FinLegal, dbo.ProjectApplicant.Defapp, dbo.VWLK_ApplicantRole.Description AS [Applicant Role]
FROM         dbo.Project INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId INNER JOIN
                      dbo.Address INNER JOIN
                      dbo.ApplicantAddress ON dbo.Address.AddressId = dbo.ApplicantAddress.AddressId INNER JOIN
                      dbo.Applicant ON dbo.ApplicantAddress.ApplicantId = dbo.Applicant.ApplicantId INNER JOIN
                      dbo.ApplicantAppName ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID ON dbo.ProjectApplicant.ApplicantId = dbo.ApplicantAddress.ApplicantId INNER JOIN
                      dbo.VWLK_ApplicantRole ON dbo.ProjectApplicant.LkApplicantRole = dbo.VWLK_ApplicantRole.TypeID
WHERE     (dbo.ProjectApplicant.ProjectId = 6588) AND (dbo.Applicant.RowIsActive = 1) AND (dbo.ProjectApplicant.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectApplicantAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantRole"
            Begin Extent = 
               Top = 193
               Left = 24
               Bottom = 271
               Right = 175
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
      Begin ColumnWidths = 24
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
         Width = 2025
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
         Table = 2235
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectApplicantAddress';




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
               Top = 163
               Left = 826
               Bottom = 271
               Right = 977
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Address"
            Begin Extent = 
               Top = 13
               Left = 616
               Bottom = 121
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAddress"
            Begin Extent = 
               Top = 167
               Left = 242
               Bottom = 275
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applicant"
            Begin Extent = 
               Top = 21
               Left = 286
               Bottom = 129
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 166
               Left = 536
               Bottom = 274
               Right = 717
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 23
               Left = 830
               Bottom = 131
               Right = 983
            End
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectApplicantAddress';



