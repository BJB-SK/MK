﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public class Common
{
    public const string ChybaMeno = "Prosím zadaj meno";
    public const string ChybaPriezvisko = "Prosím vyplň priezvisko";
    public const string ChybaEmail = "Prosím vyplň email";
    public const string ChybaTelefon = "Prosím vyplň telefón";
    public const string ChybaZbor = "Žiaden zbor";
    public const string ChybaSponzorskyDar = "Prosím zadajte číslo";
    public const string ChybaPreplacame = "Prosím zadajte preplatenú sumu ako číslo";
    public const string ChybaDoplatili = "Prosím zadajte doplatenú sumu ako číslo";
    public const string ChybaMenoTimu = "Prosím zadajte meno tímu";
    public const string ChybaCaptcha = "To nevyzerá správne";
    public const string ChybaEmailSaOpakuje = "Tento email sa opakuje";
    public const string ChybaEmailUzZaregistrovany = "Osoba s týmto emailom je už zaregistrovaná";

    private static Regex _validEmail = new Regex(@"^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$", RegexOptions.IgnoreCase);
    private static Regex _validPhoneNumber = new Regex(@"^\+?[\d\s]{6,}$");

    public static bool ValidatePhoneNumber(string phoneNumber)
    {
        return !string.IsNullOrEmpty(phoneNumber) && _validPhoneNumber.IsMatch(phoneNumber);
    }

    public static bool ValidateEmail(string email)
    {
        return !string.IsNullOrEmpty(email) && _validEmail.IsMatch(email);
    }

    public static string GetIpAddress()
    {
        if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
        {
            return HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
        }
        if (HttpContext.Current.Request.UserHostAddress.Length != 0)
        {
            return HttpContext.Current.Request.UserHostAddress;
        }
        return "Unknown IP address";
    }

    public static void FillTeeShirts(DropDownList ddlTricko, List<IdName> data, bool feminine)
    {
        ddlTricko.Items.Clear();
        ddlTricko.Items.Add(new ListItem("Žiadne", "0"));
        ddlTricko.Items.AddRange(data.ToListItems(feminine));
    }

    public static void FillTeeShirts(RadioButtonList rblTricko, List<IdName> data)
    {
        rblTricko.Items.Clear();
        rblTricko.Items.Add(new ListItem("Žiadne", "0"));
        rblTricko.Items.AddRange(data.ToListItems());
    }

    public static void FillDropDown(DropDownList dropDown, ListItem[] data)
    {
        dropDown.Items.Clear();
        dropDown.Items.AddRange(data);
    }

    public static void FillDropDown(DropDownList dropDown, List<IdName> data, ListItem emptyItem)
    {
        dropDown.Items.Clear();
        dropDown.Items.Add(emptyItem);
        dropDown.Items.AddRange(data.ToListItems());
    }

    public static void FillJobs(RadioButtonList rblSluziaci, List<JobInfo> data, bool showPrivate)
    {
        rblSluziaci.Items.Clear();
        if (showPrivate)
        {
            rblSluziaci.Items.AddRange(data.Where(x => !x.IsPublic).ToListItems2());
        }
        else
        {
            rblSluziaci.Items.Add(new ListItem { Text = "Nie", Value = "0" });
            rblSluziaci.Items.AddRange(data.Where(x => x.Allowed && x.IsPublic).ToListItems2());
            rblSluziaci.SelectedValue = "0";
        }
    }

    public static void FillJobs(DropDownList ddlSluziaci, List<JobInfo> data, bool showAll)
    {
        ddlSluziaci.Items.Clear();
        if (showAll)
        {
            ddlSluziaci.Items.Add(new ListItem { Text = "Nie", Value = "0" });
            ddlSluziaci.Items.AddRange(data.ToListItems2());
        }
        else
        {
            ddlSluziaci.Items.Add(new ListItem { Text = "Nie", Value = "0" });
            ddlSluziaci.Items.AddRange(data.Where(x => x.Allowed && x.IsPublic).ToListItems2());
            ddlSluziaci.SelectedValue = "0";
        }
    }

    public static void FillDobrovolnici(RadioButtonList rblDobrovolnici, List<IdNameToolTip> data)
    {
        rblDobrovolnici.Items.Clear();
        rblDobrovolnici.Items.AddRange(data.ToListItems2());
    }

    public static void FillDobrovolnici(DropDownList ddlDobrovolnici, List<IdNameToolTip> data)
    {
        ddlDobrovolnici.Items.Clear();
        ddlDobrovolnici.Items.Add(new ListItem { Text = "Priraďte ma tam, kde ma treba najviac", Value = "0" });
        ddlDobrovolnici.Items.AddRange(data.ToListItems2());
        ddlDobrovolnici.SelectedValue = "0";
    }

    public static void FillInternat(DropDownList ddlInternat, List<IdName> data)
    {
        ddlInternat.Items.Clear();
        ddlInternat.Items.AddRange(data.ToListItems());
        ddlInternat.SelectedValue = "0";
    }
}