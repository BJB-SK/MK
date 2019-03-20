using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Account
    {
        public Account()
        {
            Attendee = new HashSet<Attendee>();
            Donation = new HashSet<Donation>();
        }

        public int Id { get; set; }
        public int? IdIdentifier { get; set; }
        public string Email { get; set; }
        public DateTime DtCreated { get; set; }

        public virtual Identifier IdIdentifierNavigation { get; set; }
        public virtual ICollection<Attendee> Attendee { get; set; }
        public virtual ICollection<Donation> Donation { get; set; }
    }
}
