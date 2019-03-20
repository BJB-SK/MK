using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class JobProductCategory
    {
        public int Id { get; set; }
        public int IdJob { get; set; }
        public int IdProductCategory { get; set; }

        public virtual Job IdJobNavigation { get; set; }
        public virtual ProductCategory IdProductCategoryNavigation { get; set; }
    }
}
