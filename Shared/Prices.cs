﻿//TODO: update
public class Prices
{
    /*
    public const float Ranajky = 1.5f;
    public const float Obed = 2.7f;
    public const float Vecera = 2.5f;
    public const float Vecera2 = 1;
    */
    public const float Tricko = 5.5f;
    public const float Mikina = 16f;
    public const float Ubytovanie = 1;
    public const float Internat1 = 12;
    public const float Internat2 = 12;
    public const float LenDnesPiatok = 5;
    public const float LenDnesSobota = 10;
    public const float LenDnesNedela = 3;

    public static float? GetCenaLenDnes()
    {
        if (System.DateTime.Now.DayOfWeek == System.DayOfWeek.Friday)
        {
            return LenDnesPiatok;
        }
        if (System.DateTime.Now.DayOfWeek == System.DayOfWeek.Saturday)
        {
            return LenDnesSobota;
        }
        if (System.DateTime.Now.DayOfWeek == System.DayOfWeek.Sunday)
        {
            return LenDnesNedela;
        }
        return null;
    }
}