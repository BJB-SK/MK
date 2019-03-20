using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Fee
    {
        public int Id { get; set; }
        public DateTime? DtFrom { get; set; }
        public DateTime? DtTo { get; set; }
        public bool Online { get; set; }
        public string Comment { get; set; }
        public DateTime? DtPaymentFrom { get; set; }
        public DateTime? DtPaymentTo { get; set; }
        public int? IdProduct { get; set; }

        public virtual Product IdProductNavigation { get; set; }
    }
}
