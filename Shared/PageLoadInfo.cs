using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class PageLoadInfo
{
    public List<IdName> Churches;
    public List<JobInfo> Jobs;
    public List<CurrencyInfo> Currencies;
    public List<FeeInfo> Fees;
    public List<Product> Products;
}