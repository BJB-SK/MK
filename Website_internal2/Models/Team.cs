using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Team
    {
        public int Id { get; set; }
        public int IdSport { get; set; }
        public string Name { get; set; }
        public string Player1 { get; set; }
        public string Player2 { get; set; }
        public string Player3 { get; set; }
        public string Player4 { get; set; }
        public string Player5 { get; set; }
        public string Player6 { get; set; }
        public string Player7 { get; set; }
        public DateTime? DtModified { get; set; }

        public virtual Sport IdSportNavigation { get; set; }
    }
}
