CREATE VIEW dbo.VW_App_Project_addresses
AS
SELECT     dbo.Project.Proj_num, dbo.AppName.Applicantname, dbo.Address.Street# AS Appstreet, dbo.Address.Address1 AS Appaddress1, dbo.Address.Town AS apptown, 
                      dbo.Address.Zip AS appzip, dbo.Applicant.Phone AS appphone, Address_1.Street# AS projstreet, Address_1.Address1 AS projadd1, Address_1.Town AS projtown, 
                      Address_1.Zip AS projzip, dbo.LookupValues.Description AS projname, dbo.Project.ProjectId
FROM         dbo.ProjectName INNER JOIN
                      dbo.ApplicantAddress INNER JOIN
                      dbo.ApplicantAppName INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId ON dbo.ApplicantAppName.ApplicantID = dbo.ProjectApplicant.ApplicantId ON 
                      dbo.ApplicantAddress.AddressId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.Address ON dbo.ApplicantAddress.AddressId = dbo.Address.AddressId INNER JOIN
                      dbo.Applicant ON dbo.ApplicantAddress.ApplicantId = dbo.Applicant.ApplicantId ON dbo.ProjectName.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectName.LkProjectname = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.ProjectAddress RIGHT OUTER JOIN
                      dbo.Address AS Address_1 ON dbo.ProjectAddress.AddressId = Address_1.AddressId ON dbo.Project.ProjectId = dbo.ProjectAddress.ProjectId
WHERE     (dbo.ProjectApplicant.LkApplicantRole = 358) AND (dbo.ApplicantAppName.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_App_Project_addresses';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "Applicant"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 356
               Left = 679
               Bottom = 464
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectAddress"
            Begin Extent = 
               Top = 183
               Left = 218
               Bottom = 291
               Right = 381
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Address_1"
            Begin Extent = 
               Top = 202
               Left = 800
               Bottom = 310
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 11
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_App_Project_addresses';


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
         Begin Table = "ProjectName"
            Begin Extent = 
               Top = 283
               Left = 426
               Bottom = 391
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAddress"
            Begin Extent = 
               Top = 149
               Left = 500
               Bottom = 257
               Right = 674
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 16
               Left = 418
               Bottom = 124
               Right = 599
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 21
               Left = 620
               Bottom = 129
               Right = 773
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Address"
            Begin Extent = 
               Top = 6
               Left = 811
               Bottom = 114
               Right = 964
            End
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_App_Project_addresses';

