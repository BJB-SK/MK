using System;

[Serializable]
public struct CurrencyInfo: IIdName
{
    public int Id { get; set; }
    public string Name { get; set; }
    public float Rate;
    public string PaymentInfo;

    public string FormatMoney(float? amount)
    {
        return amount != null ? string.Format("{0:0.00} {1}", amount * Rate, Name) : "";
    }
}
