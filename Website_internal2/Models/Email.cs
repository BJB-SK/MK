using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Email
    {
        public int Id { get; set; }
        public string Address { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public int Retries { get; set; }
        public bool Success { get; set; }
        public string Result { get; set; }
        public DateTime? DtLastAttempt { get; set; }
        public int? IdIdentifier { get; set; }

        public virtual Identifier IdIdentifierNavigation { get; set; }
    }
}
