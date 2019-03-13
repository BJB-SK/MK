using System;

[Serializable]
public class ProductInfo
{
    public string Name { get; set; }
    public int? Available { get; set; }
    public int Ordered { get; set; }
    public int Paid { get; set; }
    public int? NotOrdered
    {
        get
        {
            return Available == null ? null : Available - Ordered;
        }
    }
}
