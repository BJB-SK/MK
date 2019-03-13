using System.Collections.Generic;
using System.Linq;

public static class Emails
{
    public const string RegistrationSubject = 
        "Registrácia na Mládežnícku konferenciu 2020";

    public const string MailHeader = 
        "<b>Mládežnícka konferencia 2020</b><br/>" +
        "22. - 24. február 2020<br/>";

    public const string SportRegistration =
        "<br/>Registrácia volejbalového alebo futbalového teamu je v samostatnej prihláške - <a href=" +
        "\"http://mk.baptist.sk/Sports.aspx\">klikni sem</a> (max. do 18.2.2020!!!)<br/>";

    public const string MailFooter1 =
        "<br/><b>Informácie ohľadom registrácie:</b> mladeznicka.konfera@gmail.com<br/>" +
        "Všeobecne informácie:<br/>" +
        "<a href=\"http://mk.baptist.sk\">mk.baptist.sk</a>, <a href=\"mailto:mladez@baptist.sk\">mladez@baptist.sk</a>, " +
        "Martin Tobák 0917349474<br/>";
        
    public const string MailFooter2 = "<br/>Na požehnaný čas aj s tebou sa teší";
    public const string MailFooter3 = "<br/>Organizačný team MK2020";

    public static string GetParticipantInfo(RegistrationEntry data, PageLoadInfo info)
    {
        var foundJob = info.Jobs.FirstOrDefault(x => x.Id == data.IdJob);

        return
            string.Format("<br/>Milá/milý {0} {1},<br/>", data.FirstName, data.LastName) +
            "vítame Ťa medzi prihlásenými účastníkmi Mládežníckej konferencie BJB 2020.<br/>" +
            "<br/><b>Máš objednané:</b><br/>" +
            string.Join("<br/>", data.Codes.Select(x => info.Products.First(y => y.Code == x).Name)) +
            "<br/>(k ubytovaniu je potrebný vlastný spacák a karimatka)<br/>" +
            (foundJob != null && foundJob.IsPublic ?
                "V registračnom formulári si zaškrtol/zaškrtla, že si ochotný/ochotná slúžiť a byť k dispozícii pre rôzne úlohy počas celého " +
                "času trvania konferencie. Ohľadom možnosti služby Ťa budeme kontaktovať.<br/>" : "");
    }

    public static string GetPaymentInfo(string ucelPlatby, float toPay, CurrencyInfo currency)
    {
        return toPay > 0 ?
            "<br/>Suma: <b>" + currency.FormatMoney(toPay) + "</b>" +
            "<br/>" + currency.PaymentInfo + 
            "<br/>Účel platby: " + ucelPlatby + 
            "<br/>" : "";
    }

    public static string GetPaymentInfo(RegistrationEntry data, float toPay, CurrencyInfo currency)
    {
        return GetPaymentInfo(string.Format("<b>{0} {1}</b> (uveď bez diakritiky)", data.FirstName, data.LastName), toPay, currency);
    }

    public static string GetSingle(RegistrationEntry data, float toPay, CurrencyInfo currency, PageLoadInfo info)
    {
        return
            MailHeader +
            GetParticipantInfo(data, info) +
            "<br/>Tvoja celková čiastka za konferenciu je <b>v hodnote " + currency.FormatMoney(toPay) + "</b>, táto čiastka obsahuje konferenčný poplatok " +
            "a pripočítaný je aj tvoj sponzorský príspevok, ak si ho zvolil(a).<br/> POZOR!  Registračný poplatok závisí od dátumu zaplatenia (datum odoslania penazí z účtu), nie od dátumu registrácie. " +
            "Registácia, ktorá nebude zaplatená do 14.2.2020 bude zrušená. <br/>" +
            GetPaymentInfo(data, toPay, currency) +
            SportRegistration +
            MailFooter1 +
            MailFooter2 +
            MailFooter3;
    }

    public static string GetMultiple(RegistrationEntry data, string payerEmail, PageLoadInfo info)
    {
        return
            MailHeader +
            GetParticipantInfo(data, info) +
            string.Format("<br/><b>Na konferenciu Ťa zaregistroval(a) a zaplatil(a) za teba {0}.</b><br/>", payerEmail) +            
            SportRegistration +
            MailFooter1 +
            MailFooter2 +
            MailFooter3;
    }

    public static string GetMultiplePayerRegistered(List<RegistrationEntry> data, int index, float toPay, CurrencyInfo currency, PageLoadInfo info)
    {
        return
            MailHeader +
            GetParticipantInfo(data[index], info) +
            "<br/>Tvoja celková čiastka za konferenciu je <b>v hodnote " + currency.FormatMoney(toPay) + "</b>, táto čiastka obsahuje aj všetky registračné poplatky " +
            "mládežníkov, ktorých si zaregistroval(a) (" + string.Join(", ", data.Select(x => x.FirstName + " " + x.LastName)) + ").<br/>" +
            GetPaymentInfo(data[index], toPay, currency) +
            SportRegistration +
            MailFooter1 +
            MailFooter2 +
            MailFooter3;
    }

    public static string GetMultiplePayerNotRegistered(List<RegistrationEntry> data, float toPay, CurrencyInfo currency, string payerEmail)
    {
        return
            MailHeader +
            "<br/>Ďakujeme za Vašu registráciu.<br/>" +
            "<br/>Zaregistrovali ste:<br/>" +
            string.Join("<br/>", data.Select(x => x.FirstName + " " + x.LastName)) + "<br/>" +
            (toPay > 0 ? "<br/>Celková suma k úhrade je <b>" + currency.FormatMoney(toPay) + "</b><br/>" : "") +
            GetPaymentInfo("<b>" + payerEmail + "</b>", toPay, currency) +
            MailFooter1 +
            MailFooter3;
    }
}