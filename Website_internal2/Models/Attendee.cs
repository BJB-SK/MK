using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Attendee
    {
        public Attendee()
        {
            AttendeeProduct = new HashSet<AttendeeProduct>();
        }

        public int Id { get; set; }
        public int IdAccount { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public int? IdChurch { get; set; }
        public string OtherChurch { get; set; }
        public string Note { get; set; }
        public DateTime? DtModified { get; set; }
        public int? IdJob { get; set; }
        public DateTime? DtShowedUp { get; set; }
        public decimal? ExtraFee { get; set; }
        public int? IdFrontend { get; set; }

        public virtual Account IdAccountNavigation { get; set; }
        public virtual Church IdChurchNavigation { get; set; }
        public virtual Job IdJobNavigation { get; set; }
        public virtual ICollection<AttendeeProduct> AttendeeProduct { get; set; }
    }
}
