using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Church
    {
        public Church()
        {
            Attendee = new HashSet<Attendee>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Attendee> Attendee { get; set; }
    }
}
