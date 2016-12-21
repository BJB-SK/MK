using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public struct IdNameToolTip : IIdNameToolTip
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string ToolTip { get; set; }
}
