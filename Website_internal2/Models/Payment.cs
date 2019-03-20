using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Payment
    {
        public int Id { get; set; }
        public int IdAccount { get; set; }
        public int IdCurrency { get; set; }
        public decimal Amount { get; set; }
        public string Note { get; set; }
        public string Payer { get; set; }
        public bool Cash { get; set; }
        public DateTime DtCreated { get; set; }

        public virtual Currency IdCurrencyNavigation { get; set; }
    }
}
