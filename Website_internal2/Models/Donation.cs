using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Donation
    {
        public int Id { get; set; }
        public int? IdAccount { get; set; }
        public decimal Amount { get; set; }
        public int IdCurrency { get; set; }
        public DateTime? DtModified { get; set; }

        public virtual Account IdAccountNavigation { get; set; }
        public virtual Currency IdCurrencyNavigation { get; set; }
    }
}
