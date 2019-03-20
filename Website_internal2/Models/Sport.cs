using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Sport
    {
        public Sport()
        {
            Team = new HashSet<Team>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Team> Team { get; set; }
    }
}
