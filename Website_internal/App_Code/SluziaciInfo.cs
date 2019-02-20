using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public struct SluziaciInfo : IIdNameToolTip
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string ToolTip { get; set; }
    public bool FreeRegistration;
    public bool FreeTeeShirt;
    public bool FreeMikina;
    public bool FreeFood;
    public bool FreeDorm;
    public bool Allowed;
    public bool IsPublic;
}
