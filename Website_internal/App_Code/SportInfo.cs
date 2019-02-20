﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public struct SportInfo: IIdName
{
    public int Id { get; set; }
    public string Name { get; set; }
    public int? Players;
}