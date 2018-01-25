CREATE VIEW dbo.VW_GrantInfoPayment
AS
SELECT DISTINCT 
                      dbo.GrantInfo.GrantinfoID, dbo.GrantInfo.VHCBName, dbo.VWLK_Grantors.Description AS Grantor, dbo.VWLK_GrantSource.Description AS GrantSource, 
                      dbo.GrantInfo.AwardNum, dbo.GrantInfo.AwardAmt, dbo.GrantInfo.BeginDate, dbo.GrantInfo.EndDate, dbo.UserInfo.Fname AS StaffFname, 
                      dbo.UserInfo.Lname AS StaffLName, dbo.Contact.Firstname, dbo.Contact.Lastname, dbo.GrantInfo.CFDA, dbo.GrantInfo.SignAgree, dbo.GrantInfo.FedFunds, 
                      dbo.GrantInfo.FedSignDate, dbo.GrantInfo.Fundsrec, dbo.GrantInfo.Match, dbo.GrantInfo.Admin, dbo.GrantInfo.Notes, dbo.VWLK_year.Description AS Year, 
                      dbo.Fund.name AS Fund, dbo.GrantinfoFYAmt.Amount
FROM         dbo.GrantInfo INNER JOIN
                      dbo.GrantinfoFYAmt ON dbo.GrantInfo.GrantinfoID = dbo.GrantinfoFYAmt.GrantinfoID INNER JOIN
                      dbo.FundGrantinfo ON dbo.GrantInfo.GrantinfoID = dbo.FundGrantinfo.GrantinfoID INNER JOIN
                      dbo.VWLK_year ON dbo.GrantinfoFYAmt.LkYear = dbo.VWLK_year.TypeID INNER JOIN
                      dbo.VWLK_Grantors ON dbo.GrantInfo.LkGrantor = dbo.VWLK_Grantors.TypeID INNER JOIN
                      dbo.VWLK_GrantSource ON dbo.GrantInfo.LkGrantSource = dbo.VWLK_GrantSource.TypeID INNER JOIN
                      dbo.Fund ON dbo.FundGrantinfo.FundID = dbo.Fund.FundId LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.GrantInfo.Staff = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.Contact ON dbo.GrantInfo.ContactID = dbo.Contact.ContactId
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
         Begin Table = "GrantInfo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "GrantinfoFYAmt"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "FundGrantinfo"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 576
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_year"
            Begin Extent = 
               Top = 157
               Left = 15
               Bottom = 235
               Right = 166
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Grantors"
            Begin Extent = 
               Top = 23
               Left = 626
               Bottom = 101
               Right = 777
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_GrantSource"
            Begin Extent = 
               Top = 135
               Left = 494
               Bottom = 213
               Right = 645
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Contact"
            Begin Extent = 
               Top = 195
               Left = 200
               Bottom = 303
               Right = 351
            End
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GrantInfoPayment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GrantInfoPayment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 224
               Left = 376
               Bottom = 332
               Right = 530
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 815
               Bottom = 114
               Right = 966
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
      Begin ColumnWidths = 25
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GrantInfoPayment';

