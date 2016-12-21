using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public struct IdName : IIdName
{
    public int Id { get; set; }
    public string Name { get; set; }
}
