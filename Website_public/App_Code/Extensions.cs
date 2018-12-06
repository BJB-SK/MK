using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Extensions
/// </summary>
public static class Extensions
{
    public static void SetPlaceHolder(this TextBox textBox, string placeholder)
    {
        textBox.Attributes.Add("placeholder", placeholder);
    }

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

    public static List<IdName> GetListOfIdNames(this SqlDataReader reader)
    {
        var result = new List<IdName>();
        while (reader.Read())
        {
            result.Add(new IdName
            {
                Id = reader.GetInt32(0),
                Name = reader.GetString(1)
            });
        }
        reader.NextResult();
        return result;
    }

    public static ListItem[] ToListItems<T>(this IEnumerable<T> data) where T : IIdName
    {
        return data.Select(x => new ListItem { Value = x.Id.ToString(), Text = x.Name }).ToArray();
    }

    public static ListItem[] ToListItems<T>(this IEnumerable<T> data, bool feminine) where T : IIdName
    {
        return data.Select(x => new ListItem { Value = x.Id.ToString(), Text = feminine ? x.Name.Replace("e", "a") : x.Name }).ToArray();
    }

    public static List<IdNameToolTip> GetListOfIdNameToolTips(this SqlDataReader reader)
    {
        var result = new List<IdNameToolTip>();
        while (reader.Read())
        {
            result.Add(new IdNameToolTip
            {
                Id = reader.GetInt32(0),
                Name = reader.GetString(1),
                ToolTip = reader.GetStringNull(2)
            });
        }
        reader.NextResult();
        return result;
    }

    public static System.Web.UI.WebControls.ListItem[] ToListItems2<T>(this IEnumerable<T> data) where T : IIdNameToolTip
    {
        return data.Select(x => 
        {
            var item = new System.Web.UI.WebControls.ListItem
            {
                Value = x.Id.ToString(),
                Text = x.Name
            };
            item.Attributes.Add("title", x.ToolTip);
            return item;
        }).ToArray();
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

    public static decimal? GetDecimalNull(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? (decimal?)null : reader.GetDecimal(i);
    }

    public static float? GetFloatNull(this SqlDataReader reader, int i)
    {
        return reader.IsDBNull(i) ? (float?)null : (float)reader.GetDecimal(i);
    }
}