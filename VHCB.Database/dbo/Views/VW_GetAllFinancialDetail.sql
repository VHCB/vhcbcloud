CREATE VIEW dbo.VW_GetAllFinancialDetail
AS
SELECT     dbo.Trans.TransId, dbo.Detail.DetailID, dbo.Trans.Date, dbo.Trans.TransAmt, dbo.Detail.Amount AS [Detail Amount], dbo.Trans.ProjectCheckReqID, 
                      dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS [TransAction], 
                      LookupValues_1.Description AS Status, dbo.Trans.Balanced, dbo.Trans.Adjust AS Adjustment, dbo.AppName.Applicantname, dbo.Fund.name AS Fund, 
                      LookupValues_2.Description AS TransType, dbo.UserInfo.Username, dbo.Act250Farm.UsePermit, dbo.Fund.account AS [Fund Acct]
FROM         dbo.Fund INNER JOIN
                      dbo.LookupValues AS LookupValues_1 INNER JOIN
                      dbo.LookupValues INNER JOIN
                      dbo.VWLK_ProjectNames INNER JOIN
                      dbo.Detail ON dbo.VWLK_ProjectNames.ProjectID = dbo.Detail.ProjectID INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId ON dbo.LookupValues.TypeID = dbo.Trans.LkTransaction ON LookupValues_1.TypeID = dbo.Trans.LkStatus ON 
                      dbo.Fund.FundId = dbo.Detail.FundId INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Detail.LkTransType = LookupValues_2.TypeID LEFT OUTER JOIN
                      dbo.Act250Farm ON dbo.Detail.LandUsePermitID = dbo.Act250Farm.Act250FarmID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.Trans.UserID = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON dbo.Trans.PayeeApplicant = dbo.ApplicantAppName.ApplicantID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Trans.RowIsActive = 1) AND (dbo.Trans.Balanced = 1) AND (dbo.Trans.RowIsActive = 1) AND 
                      (dbo.Detail.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GetAllFinancialDetail';




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
         Begin Table = "Fund"
            Begin Extent = 
               Top = 138
               Left = 454
               Bottom = 246
               Right = 605
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 267
               Left = 267
               Bottom = 375
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 261
               Left = 24
               Bottom = 369
               Right = 175
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 138
               Left = 27
               Bottom = 246
               Right = 179
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 104
               Left = 247
               Bottom = 212
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 9
               Left = 34
               Bottom = 117
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 269
               Left = 513
               Bottom = 377
               Right = 664
            End
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GetAllFinancialDetail';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Act250Farm"
            Begin Extent = 
               Top = 6
               Left = 436
               Bottom = 114
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 6
               Left = 857
               Bottom = 114
               Right = 1011
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 6
               Left = 666
               Bottom = 114
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 126
               Left = 637
               Bottom = 234
               Right = 818
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
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2220
         Table = 2160
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GetAllFinancialDetail';

