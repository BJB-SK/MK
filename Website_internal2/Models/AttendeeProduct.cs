using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class AttendeeProduct
    {
        public int Id { get; set; }
        public int IdProduct { get; set; }
        public int IdAttendee { get; set; }
        public DateTime? DtModified { get; set; }

        public virtual Attendee IdAttendeeNavigation { get; set; }
        public virtual Product IdProductNavigation { get; set; }
    }
}
