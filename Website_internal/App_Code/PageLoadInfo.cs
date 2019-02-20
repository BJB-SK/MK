using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class PageLoadInfo
{
    public List<IdName> Tricka;
    public List<IdName> Zbory;
    public List<IdNameToolTip> Dobrovolnici;
    public List<SluziaciInfo> Sluziaci;
    public List<CurrencyInfo> Currencies;
    public List<PoplatokInfo> Poplatky;
    public List<IdName> Ubytovanie;
}