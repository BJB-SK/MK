using System;
using System.Collections.Generic;

[Serializable]
public class DetailData
{
    public int? Id;
    public string Meno;
    public string Priezvisko;
    public string Email;
    public string Telefon;
    public int? IdZbor;
    public string InyZbor;
    public bool PiatokVecera;
    public bool PiatokVecera2;
    public int IdUbytovaniePiatokSobota;
    public bool SobotaRanajky;
    public bool SobotaObed;
    public bool SobotaVecera;
    public bool SobotaVecera2;
    public int IdUbytovanieSobotaNedela;
    public bool NedelaRanajky;
    public bool NedelaObed;
    public bool Sach;
    public bool PingPong;
    public int? IdTricko;
    public int? IdSluziaci;
    public int? IdDobrovolnik;
    public string Poznamka;
    public DateTime? DtRegistered;
    public bool InternatZadarmo;
    public bool RegistraciaZadarmo;
    public bool JedloZadarmo;
    public bool TrickoZadarmo;
    public DateTime? DtPlatba;
    public DateTime? DtPrisli;
    public float Naklady;
    public float Zaplatili;
    public float Dar;
    public float Preplatok;
    public float RegistracnyPoplatok;
    public float? RegistracnyOverride;

    public List<IdName> Group;
}
