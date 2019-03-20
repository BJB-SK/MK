using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Job
    {
        public Job()
        {
            Attendee = new HashSet<Attendee>();
            JobProductCategory = new HashSet<JobProductCategory>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Tooltip { get; set; }
        public int? MaxCount { get; set; }
        public bool Public { get; set; }

        public virtual ICollection<Attendee> Attendee { get; set; }
        public virtual ICollection<JobProductCategory> JobProductCategory { get; set; }
    }
}
