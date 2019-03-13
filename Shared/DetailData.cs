using System;
using System.Collections.Generic;
using System.Linq;

[Serializable]
public class DetailData
{
    public int? Id;
    public string FirstName;
    public string LastName;
    public string Email;
    public string PhoneNumber;
    public int? IdChurch;
    public string OtherChurch;
    public int? IdJob;
    public string Note;
    public DateTime? DtRegistered;
    public DateTime? DtPlatba;
    public DateTime? DtShowedUp;
    public float Costs;
    public float Paid;
    public float Donation;
    public float Surplus;
    public float? ExtraFee;
    public List<IdName> Group;
    public List<Product> Products;
    public List<int> OrderedProducts;

    public DetailData()
    {
        Group = new List<IdName>();
        Products = new List<Product>();
    }
}
