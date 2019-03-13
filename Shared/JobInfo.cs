using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class JobInfo : IIdNameToolTip
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string ToolTip { get; set; }
    public bool Allowed;
    public bool IsPublic;
    public List<int> FreeCategories;
}
