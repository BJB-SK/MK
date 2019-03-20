using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class Product
    {
        public Product()
        {
            AttendeeProduct = new HashSet<AttendeeProduct>();
            Fee = new HashSet<Fee>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
        public int? Max { get; set; }
        public string Code { get; set; }
        public int? IdProductCategory { get; set; }

        public virtual ProductCategory IdProductCategoryNavigation { get; set; }
        public virtual ICollection<AttendeeProduct> AttendeeProduct { get; set; }
        public virtual ICollection<Fee> Fee { get; set; }
    }
}
