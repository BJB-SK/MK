using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public static class Extensions
{
    public static int? StringToInt(this string source)
    {
        int id;
        if(int.TryParse(source, out id))
        {
            return id;
        }
        return null;
    }

    public static float? StringToFloat(this string source)
    {
        float number;
        if (float.TryParse(source, out number))
        {
            return number;
        }
        return null;
    }

    public static void AddParameterInt(this SqlCommand command, string name, int? value)
    {
        var parameter = command.Parameters.AddWithValue(name, value);
        parameter.SqlDbType = SqlDbType.Int;
    }

    public static void AddOutputParameterInt(this SqlCommand command, string name)
    {
        var parameter = command.Parameters.Add(name, SqlDbType.Int);
        parameter.Direction = ParameterDirection.Output;
    }

    public static void AddParameterFloat(this SqlCommand command, string name, float? value)
    {
        var parameter = command.Parameters.AddWithValue(name, value);
        parameter.SqlDbType = SqlDbType.Decimal;
    }

    public static void AddParameterString(this SqlCommand command, string name, string value)
    {
        var parameter = command.Parameters.AddWithValue(name, value);
        parameter.SqlDbType = SqlDbType.NVarChar;
    }

    public static void AddParameterBool(this SqlCommand command, string name, bool value)
    {
        var parameter = command.Parameters.AddWithValue(name, value);
        parameter.SqlDbType = SqlDbType.Bit;
    }

    public static void AddParameterUserDefined(this SqlCommand command, string name, string type, object value)
    {
        var parameter = command.Parameters.AddWithValue(name, value);
        parameter.SqlDbType = SqlDbType.Structured;
        parameter.TypeName = type;
    }

    public static bool? GetBooleanNull(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? (bool?)null : reader.GetBoolean(i);
    }

    public static DateTime? GetDateTimeNull(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? (DateTime?)null : reader.GetDateTime(i);
    }

    public static string GetStringNull(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? null : reader.GetString(i);
    }

    public static int? GetInt32Null(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? (int?)null : reader.GetInt32(i);
    }
}