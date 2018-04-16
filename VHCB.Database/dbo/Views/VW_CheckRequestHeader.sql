CREATE VIEW dbo.VW_CheckRequestHeader
AS
SELECT     dbo.Project.Proj_num, dbo.LookupValues.Description AS Program, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectCheckReq.InitDate, 
                      dbo.ProjectCheckReq.LegalReview, dbo.ProjectCheckReq.MatchAmt, LookupValues_1.Description AS [Grant Match], dbo.ProjectCheckReq.Notes, 
                      dbo.ProjectCheckReq.LCB, dbo.ProjectCheckReq.ProjectID, dbo.ProjectCheckReq.Paiddate, dbo.AppName.Applicantname AS Payee, AppName_1.Applicantname, 
                      dbo.ProjectCheckReq.Voucher#, LookupValues_2.Description AS Status, dbo.UserInfo.Username, dbo.Applicant.Stvendid
FROM         dbo.ProjectCheckReq INNER JOIN
                      dbo.Project ON dbo.ProjectCheckReq.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectCheckReq.LkProgram = dbo.LookupValues.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.Trans ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.Trans.ProjectCheckReqID INNER JOIN
                      dbo.ApplicantAppName ON dbo.Trans.PayeeApplicant = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId INNER JOIN
                      dbo.ApplicantAppName AS ApplicantAppName_1 ON dbo.ProjectApplicant.ApplicantId = ApplicantAppName_1.ApplicantID INNER JOIN
                      dbo.AppName AS AppName_1 ON ApplicantAppName_1.AppNameID = AppName_1.AppNameID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID INNER JOIN
                      dbo.UserInfo ON dbo.ProjectCheckReq.UserID = dbo.UserInfo.UserId INNER JOIN
                      dbo.Applicant ON dbo.ApplicantAppName.ApplicantID = dbo.Applicant.ApplicantId LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectCheckReq.LkFVGrantMatch = LookupValues_1.TypeID
WHERE     (dbo.ProjectApplicant.Defapp = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestHeader';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 50
               Left = 642
               Bottom = 158
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName_1"
            Begin Extent = 
               Top = 170
               Left = 507
               Bottom = 278
               Right = 688
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName_1"
            Begin Extent = 
               Top = 207
               Left = 709
               Bottom = 315
               Right = 862
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 6
               Left = 1057
               Bottom = 114
               Right = 1208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 205
               Left = 214
               Bottom = 313
               Right = 368
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 144
               Left = 331
               Bottom = 252
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Applicant"
            Begin Extent = 
               Top = 282
               Left = 894
               Bottom = 390
               Right = 1058
            End
            DisplayFlags = 280
            TopColumn = 13
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestHeader';




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
            TopColumn = 16
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 138
               Left = 35
               Bottom = 246
               Right = 186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 589
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 846
               Bottom = 114
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 139
               Left = 849
               Bottom = 247
               Right = 1030
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 137
               Left = 1065
               Bottom = 245
               Right = 1218
            End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestHeader';

