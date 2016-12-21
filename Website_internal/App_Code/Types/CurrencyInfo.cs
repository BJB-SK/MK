using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public struct CurrencyInfo: IIdName
{
    public int Id { get; set; }
    public string Name { get; set; }
    public float Rate;
    public string PaymentInfo;

    public string FormatMoney(float amount)
    {
        return string.Format("{0:0.00} {1}", amount * Rate, Name);
    }
}
