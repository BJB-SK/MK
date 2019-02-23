using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

[Serializable]
public class SummaryData
{
    public int TotalPeople;
    public int ShowedUp;
    public int PiatokVecera;
    public int PiatokVecera2;
    public int PiatokVeceraZaplatene;
    public int PiatokVecera2Zaplatene;
    public int TichaTriedaPiatokSobota;
    public int SobotaRanajky;
    public int SobotaObed;
    public int SobotaVecera;
    public int SobotaVecera2;
    public int SobotaRanajkyZaplatene;
    public int SobotaObedZaplatene;
    public int SobotaVeceraZaplatene;
    public int SobotaVecera2Zaplatene;
    public int TichaTriedaSobotaNedela;
    public int NedelaRanajky;
    public int NedelaObed;
    public int NedelaRanajkyZaplatene;
    public int NedelaObedZaplatene;
    public int Sach;
    public int PingPong;
    public int InternatPiatokSobota1;
    public int InternatPiatokSobotaZaplatene1;
    public int InternatSobotaNedela1;
    public int InternatSobotaNedelaZaplatene1;
    public int InternatPiatokSobota2;
    public int InternatPiatokSobotaZaplatene2;
    public int InternatSobotaNedela2;
    public int InternatSobotaNedelaZaplatene2;
    public float ExpectingEur;
    public float MoneyFromPeople;

    public List<TeeShirtInfo> Tricka;
    public List<TeeShirtInfo> Mikiny;
    public List<NameCount> Sluziaci;
    public List<NameCount> Dobrovolnici;
    public List<NoteInfo> Poznamky;
    public List<NameCount> Churches;
}
