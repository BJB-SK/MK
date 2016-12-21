using System;
using System.Collections.Generic;
using System.Linq;

[Serializable]
public class NewRegistration
{
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
    public int? IdSluziaci;
    public int? IdDobrovolnik;
    public string Poznamka;
    public float Dar;

    public float GetRegistrationFee(List<PoplatokInfo> poplatky)
    {
        float registracny = 0;
        var now = DateTime.UtcNow;
        foreach (var poplatok in poplatky)
        {
            if ((poplatok.From == null || poplatok.From <= now) && now <= poplatok.To)
            {
                registracny = poplatok.Amount;
            }
        }
        return registracny;
    }

    public float GetCost(List<SluziaciInfo> sluziaci, List<PoplatokInfo> poplatky)
    {
        float registracny = GetRegistrationFee(poplatky);

        float strava = 0;
        if (PiatokVecera) strava += Prices.Vecera;
        if (PiatokVecera2) strava += Prices.Vecera2;
        if (SobotaRanajky) strava += Prices.Ranajky;
        if (SobotaObed) strava += Prices.Obed;
        if (SobotaVecera) strava += Prices.Vecera;
        if (SobotaVecera2) strava += Prices.Vecera2;
        if (NedelaRanajky) strava += Prices.Ranajky;
        if (NedelaObed) strava += Prices.Obed;

        float ubytovanie =
            (IdUbytovaniePiatokSobota == (int)Ubytovanie.Internat1 ? Prices.Internat1 : 0) +
            (IdUbytovaniePiatokSobota == (int)Ubytovanie.Internat2 ? Prices.Internat2 : 0) +
            (IdUbytovanieSobotaNedela == (int)Ubytovanie.Internat1 ? Prices.Internat1 : 0) +
            (IdUbytovanieSobotaNedela == (int)Ubytovanie.Internat2 ? Prices.Internat2 : 0);

        if (IdSluziaci != 0 && sluziaci.Any(x => x.Id == IdSluziaci))
        {
            var sluziaci2 = sluziaci.First(x => x.Id == IdSluziaci);
            if (sluziaci2.FreeFood) strava = 0;
            if (sluziaci2.FreeRegistration) registracny = 0;
            if (sluziaci2.FreeDorm) ubytovanie = 0;
        }
        return registracny + strava + ubytovanie + Dar;
    }
}
