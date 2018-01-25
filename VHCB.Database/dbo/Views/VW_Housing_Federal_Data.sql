CREATE VIEW dbo.VW_Housing_Federal_Data
AS
SELECT DISTINCT 
                      dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectFederal.ProjectID, dbo.ProjectFederal.ProjectFederalID, 
                      dbo.ProjectFederal.NumUnits, dbo.LookupValues.Description AS [Federal Program], dbo.ProjectFederalProgramDetail.AffrdPeriod, 
                      dbo.ProjectFederalProgramDetail.AffrdStart, dbo.ProjectFederalProgramDetail.AffrdEnd, LookupValues_1.Description AS [Recertification Month], 
                      LookupValues_2.Description AS [Afford Period], dbo.ProjectFederalProgramDetail.freq AS [Inspection Freq], dbo.ProjectFederalProgramDetail.IDISNum, 
                      dbo.ProjectFederalProgramDetail.Setup, dbo.ProjectFederalProgramDetail.FundedDate, dbo.ProjectFederalProgramDetail.IDISClose, 
                      dbo.UserInfo.Username AS [Fund Completed By], UserInfo_1.Username AS [Completed By], UserInfo_2.Username AS [IDIS Completed By], 
                      dbo.ProjectFederalProgramDetail.CHDO, LookupValues_3.Description AS [CHDO Recert]
FROM         dbo.LookupValues AS LookupValues_1 RIGHT OUTER JOIN
                      dbo.ProjectFederalProgramDetail ON LookupValues_1.TypeID = dbo.ProjectFederalProgramDetail.Recert LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.ProjectFederalProgramDetail.LKAffrdPer = LookupValues_2.TypeID LEFT OUTER JOIN
                      dbo.UserInfo AS UserInfo_2 ON dbo.ProjectFederalProgramDetail.IDISCompleteBy = UserInfo_2.UserId LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectFederalProgramDetail.FundCompleteBy = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.UserInfo AS UserInfo_1 ON dbo.ProjectFederalProgramDetail.CompleteBy = UserInfo_1.UserId LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_3 ON dbo.ProjectFederalProgramDetail.CHDORecert = LookupValues_3.TypeID RIGHT OUTER JOIN
                      dbo.ProjectFederal INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID LEFT OUTER JOIN
                      dbo.FederalUnit ON dbo.ProjectFederal.ProjectFederalID = dbo.FederalUnit.ProjectFederalID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectFederal.LkFedProg = dbo.LookupValues.TypeID ON 
                      dbo.ProjectFederalProgramDetail.ProjectFederalId = dbo.ProjectFederal.ProjectFederalID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederal.RowIsActive = 1) AND (dbo.ProjectFederalProgramDetail.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing_Federal_Data';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 95
               Left = 510
               Bottom = 203
               Right = 661
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FederalUnit"
            Begin Extent = 
               Top = 189
               Left = 649
               Bottom = 297
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 20
               Left = 706
               Bottom = 128
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 3
               Left = 359
               Bottom = 111
               Right = 510
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_3"
            Begin Extent = 
               Top = 399
               Left = 447
               Bottom = 507
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 23
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1860
         Table = 3150
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing_Federal_Data';


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
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 167
               Left = 260
               Bottom = 275
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectFederalProgramDetail"
            Begin Extent = 
               Top = 167
               Left = 0
               Bottom = 275
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 390
               Left = 695
               Bottom = 498
               Right = 846
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 313
               Left = 67
               Bottom = 421
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo_1"
            Begin Extent = 
               Top = 405
               Left = 260
               Bottom = 513
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo_2"
            Begin Extent = 
               Top = 455
               Left = 55
               Bottom = 563
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectFederal"
            Begin Extent = 
               Top = 0
               Left = 12
               Bottom = 108
               Right = 173', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing_Federal_Data';

