CREATE VIEW dbo.GridFederalProgramInspections
AS
SELECT DISTINCT 
                      dbo.ProjectFederal.ProjectFederalID, dbo.ProjectFederal.ProjectID, dbo.Project.Proj_num, dbo.FederalProjectInspection.InspectDate, 
                      dbo.FederalProjectInspection.NextInspect, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectFederal.NumUnits, 
                      dbo.LookupValues.Description AS [Federal Program], dbo.FederalProjectInspection.InspectLetter, dbo.FederalProjectInspection.RespDate, 
                      dbo.FederalProjectInspection.Deficiency, dbo.FederalProjectInspection.InspectDeadline, dbo.VWLK_ApplicantName.Applicantname, 
                      dbo.ProjectFederal.LkFedProg
FROM         dbo.ProjectFederal INNER JOIN
                      dbo.FederalProjectInspection ON dbo.ProjectFederal.ProjectFederalID = dbo.FederalProjectInspection.ProjectFederalID INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectFederal.LkFedProg = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.FederalProjectInspection.InspectStaff = dbo.VWLK_ApplicantName.ApplicantId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederal.RowIsActive = 1) AND (dbo.FederalProjectInspection.RowIsActive = 1) AND 
                      (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'GridFederalProgramInspections';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'GridFederalProgramInspections';


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
         Begin Table = "ProjectFederal"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FederalProjectInspection"
            Begin Extent = 
               Top = 6
               Left = 237
               Bottom = 114
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 159
               Left = 24
               Bottom = 267
               Right = 175
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 173
               Left = 211
               Bottom = 281
               Right = 363
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 6
               Left = 486
               Bottom = 114
               Right = 637
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 164
               Left = 421
               Bottom = 272
               Right = 576
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
      Begin ColumnWidths = 14
         Width = 284
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'GridFederalProgramInspections';

