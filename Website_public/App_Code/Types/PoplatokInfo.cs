﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class PoplatokInfo
{
    public int Id { get; set; }
    public DateTime? From { get; set; }
    public DateTime? To { get; set; }
    public float Amount { get; set; }
    public string CostString { get; set; }
    public string Comment { get; set; }
    public bool Online { get; set; }
    public string CssClass { get; set; }
}
