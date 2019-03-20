using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Currency
    {
        public Currency()
        {
            Donation = new HashSet<Donation>();
            Payment = new HashSet<Payment>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public double Rate { get; set; }
        public string PaymentInfo { get; set; }

        public virtual ICollection<Donation> Donation { get; set; }
        public virtual ICollection<Payment> Payment { get; set; }
    }
}
