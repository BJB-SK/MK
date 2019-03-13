using System;
using System.Collections.Generic;

[Serializable]
public class SummaryData
{
    public int TotalPeople;
    public int ShowedUp;
    public float ExpectingEur;
    public float MoneyFromPeople;

    public List<ProductInfo> Products;
    public List<NameCount> Jobs;
    public List<NoteInfo> Notes;
    public List<NameCount> Churches;
}
