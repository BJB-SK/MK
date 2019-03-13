using System.Collections.Generic;
using System.Data;

public class Utils
{
    public static DataTable GetListOfStringsDataTable(string name, List<string> data)
    {
        var dt = new DataTable(name);

        var colValue = new DataColumn("value", typeof(string));

        dt.Columns.Add(colValue);

        foreach (var entry in data)
        {
            var row = dt.NewRow();
            row[colValue] = entry;
            dt.Rows.Add(row);
        }
        return dt;
    }

    public static DataTable GetListOfIntsDataTable(string name, List<int> data)
    {
        var dt = new DataTable(name);

        var colValue = new DataColumn("value", typeof(int));

        dt.Columns.Add(colValue);

        foreach (var entry in data)
        {
            var row = dt.NewRow();
            row[colValue] = entry;
            dt.Rows.Add(row);
        }
        return dt;
    }
}