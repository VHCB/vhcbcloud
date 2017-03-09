using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Diagnostics;
using System.Security.Principal;
using System.Configuration;
using System.DirectoryServices.ActiveDirectory;
public class LdapAuthentication
{
    private string _path;
    public LdapAuthentication(string path)
    {
        _path = path;
    }

    public bool IsAuthenticated(string domain, string username, string pwd)
    {
        string domainAndUsername = domain + @"\" + username;
        DirectoryEntry entry = new DirectoryEntry(_path, domainAndUsername, pwd);
        try
        {
            //bool isexist = DirectoryEntry.Exists(_path);
            // Bind to the native AdsObject to force authentication.
            // if username/password is incorrect, then this will throw an exception.
            Object obj = entry.NativeObject;
        }
        catch (DirectoryServicesCOMException ex)
        {
            if (ex.ExtendedErrorMessage.Contains(" 773")) throw new Exception("Error 773. User must change password at next logon is set.​ Please contact support.");
            else if (ex.ExtendedErrorMessage.Contains(" 525")) throw new Exception("Error 525. User not found.");
            else if (ex.ExtendedErrorMessage.Contains(" 52e")) throw new Exception("Error 52e. Invalid credentials.");
            else if (ex.ExtendedErrorMessage.Contains(" 530")) throw new Exception("Error 530. Not permitted to logon at this time.");
            else if (ex.ExtendedErrorMessage.Contains(" 531")) throw new Exception("Error 531. Not permitted to logon at this workstation​.");
            else if (ex.ExtendedErrorMessage.Contains(" 532")) throw new Exception("Error 532. Password expired.");
            else if (ex.ExtendedErrorMessage.Contains(" 533")) throw new Exception("Error 533. Account disabled.");
            else if (ex.ExtendedErrorMessage.Contains(" 701")) throw new Exception("Error 701. Account expired.");
            else if (ex.ExtendedErrorMessage.Contains(" 775")) throw new Exception("Error 775. User account is locked.");
            else throw ex;              // otherwise throw exception as it is.
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return true;
    }}