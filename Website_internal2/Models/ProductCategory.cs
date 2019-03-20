using System;
using System.Collections.Generic;

namespace Website_internal2.Models
{
    public partial class ProductCategory
    {
        public ProductCategory()
        {
            JobProductCategory = new HashSet<JobProductCategory>();
            Product = new HashSet<Product>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<JobProductCategory> JobProductCategory { get; set; }
        public virtual ICollection<Product> Product { get; set; }
    }
}
