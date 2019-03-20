using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Identifier
    {
        public Identifier()
        {
            Account = new HashSet<Account>();
            Email = new HashSet<Email>();
        }

        public int Id { get; set; }
        public int Identifier1 { get; set; }

        public virtual ICollection<Account> Account { get; set; }
        public virtual ICollection<Email> Email { get; set; }
    }
}
