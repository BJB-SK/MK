using System;
using System.Collections.Generic;
using System.Data;

[Serializable]
public class Product : ProductInfo, IIdName
{
    public int Id { get; set; }
    public float Price { get; set; }
    public bool IsOrdered { get; set; }
    public string Code { get; set; }
    public int IdCategory { get; set; }
    public int? IdMapping { get; set; }
}
