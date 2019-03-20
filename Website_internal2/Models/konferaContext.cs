using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace Website_internal2.Models
{
    public partial class konferaContext : DbContext
    {
        public konferaContext()
        {
        }

        public konferaContext(DbContextOptions<konferaContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Account> Account { get; set; }
        public virtual DbSet<Attendee> Attendee { get; set; }
        public virtual DbSet<AttendeeProduct> AttendeeProduct { get; set; }
        public virtual DbSet<Church> Church { get; set; }
        public virtual DbSet<Currency> Currency { get; set; }
        public virtual DbSet<Donation> Donation { get; set; }
        public virtual DbSet<Email> Email { get; set; }
        public virtual DbSet<Fee> Fee { get; set; }
        public virtual DbSet<Identifier> Identifier { get; set; }
        public virtual DbSet<Job> Job { get; set; }
        public virtual DbSet<JobProductCategory> JobProductCategory { get; set; }
        public virtual DbSet<Payment> Payment { get; set; }
        public virtual DbSet<Product> Product { get; set; }
        public virtual DbSet<ProductCategory> ProductCategory { get; set; }
        public virtual DbSet<Qr> Qr { get; set; }
        public virtual DbSet<Sport> Sport { get; set; }
        public virtual DbSet<Team> Team { get; set; }

        // Unable to generate entity type for table 'dbo.hist_attendee'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.import'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.import_cz'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.hist_attendee_product'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=X220\\SQLEXPRESS;Database=konfera;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.Entity<Account>(entity =>
            {
                entity.ToTable("account");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.DtCreated)
                    .HasColumnName("dtCreated")
                    .HasColumnType("datetime");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.IdIdentifier).HasColumnName("idIdentifier");

                entity.HasOne(d => d.IdIdentifierNavigation)
                    .WithMany(p => p.Account)
                    .HasForeignKey(d => d.IdIdentifier)
                    .HasConstraintName("FK_account_variabilny");
            });

            modelBuilder.Entity<Attendee>(entity =>
            {
                entity.ToTable("attendee");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.DtModified)
                    .HasColumnName("dtModified")
                    .HasColumnType("datetime");

                entity.Property(e => e.DtShowedUp)
                    .HasColumnName("dtShowedUp")
                    .HasColumnType("datetime");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.ExtraFee)
                    .HasColumnName("extraFee")
                    .HasColumnType("decimal(18, 4)");

                entity.Property(e => e.FirstName).HasColumnName("firstName");

                entity.Property(e => e.IdAccount).HasColumnName("idAccount");

                entity.Property(e => e.IdChurch).HasColumnName("idChurch");

                entity.Property(e => e.IdFrontend).HasColumnName("idFrontend");

                entity.Property(e => e.IdJob).HasColumnName("idJob");

                entity.Property(e => e.LastName).HasColumnName("lastName");

                entity.Property(e => e.Note).HasColumnName("note");

                entity.Property(e => e.OtherChurch).HasColumnName("otherChurch");

                entity.Property(e => e.PhoneNumber).HasColumnName("phoneNumber");

                entity.HasOne(d => d.IdAccountNavigation)
                    .WithMany(p => p.Attendee)
                    .HasForeignKey(d => d.IdAccount)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_attendee_account");

                entity.HasOne(d => d.IdChurchNavigation)
                    .WithMany(p => p.Attendee)
                    .HasForeignKey(d => d.IdChurch)
                    .HasConstraintName("FK_attendee_church");

                entity.HasOne(d => d.IdJobNavigation)
                    .WithMany(p => p.Attendee)
                    .HasForeignKey(d => d.IdJob)
                    .HasConstraintName("FK_attendee_job");
            });

            modelBuilder.Entity<AttendeeProduct>(entity =>
            {
                entity.ToTable("attendee_product");

                entity.HasIndex(e => new { e.IdAttendee, e.IdProduct })
                    .HasName("UQ_person_product")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.DtModified)
                    .HasColumnName("dtModified")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdAttendee).HasColumnName("idAttendee");

                entity.Property(e => e.IdProduct).HasColumnName("idProduct");

                entity.HasOne(d => d.IdAttendeeNavigation)
                    .WithMany(p => p.AttendeeProduct)
                    .HasForeignKey(d => d.IdAttendee)
                    .HasConstraintName("FK_person_food_person");

                entity.HasOne(d => d.IdProductNavigation)
                    .WithMany(p => p.AttendeeProduct)
                    .HasForeignKey(d => d.IdProduct)
                    .HasConstraintName("FK_person_food_food");
            });

            modelBuilder.Entity<Church>(entity =>
            {
                entity.ToTable("church");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Currency>(entity =>
            {
                entity.ToTable("currency");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name");

                entity.Property(e => e.PaymentInfo).HasColumnName("paymentInfo");

                entity.Property(e => e.Rate).HasColumnName("rate");
            });

            modelBuilder.Entity<Donation>(entity =>
            {
                entity.ToTable("donation");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Amount)
                    .HasColumnName("amount")
                    .HasColumnType("decimal(18, 4)");

                entity.Property(e => e.DtModified)
                    .HasColumnName("dtModified")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdAccount).HasColumnName("idAccount");

                entity.Property(e => e.IdCurrency).HasColumnName("idCurrency");

                entity.HasOne(d => d.IdAccountNavigation)
                    .WithMany(p => p.Donation)
                    .HasForeignKey(d => d.IdAccount)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_donation_account");

                entity.HasOne(d => d.IdCurrencyNavigation)
                    .WithMany(p => p.Donation)
                    .HasForeignKey(d => d.IdCurrency)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_donation_currency");
            });

            modelBuilder.Entity<Email>(entity =>
            {
                entity.ToTable("email");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Address).HasColumnName("address");

                entity.Property(e => e.Body).HasColumnName("body");

                entity.Property(e => e.DtLastAttempt)
                    .HasColumnName("dtLastAttempt")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdIdentifier).HasColumnName("idIdentifier");

                entity.Property(e => e.Result).HasColumnName("result");

                entity.Property(e => e.Retries).HasColumnName("retries");

                entity.Property(e => e.Subject).HasColumnName("subject");

                entity.Property(e => e.Success).HasColumnName("success");

                entity.HasOne(d => d.IdIdentifierNavigation)
                    .WithMany(p => p.Email)
                    .HasForeignKey(d => d.IdIdentifier)
                    .HasConstraintName("FK_email_variabilny");
            });

            modelBuilder.Entity<Fee>(entity =>
            {
                entity.ToTable("fee");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Comment).HasColumnName("comment");

                entity.Property(e => e.DtFrom)
                    .HasColumnName("dtFrom")
                    .HasColumnType("datetime");

                entity.Property(e => e.DtPaymentFrom)
                    .HasColumnName("dtPaymentFrom")
                    .HasColumnType("datetime");

                entity.Property(e => e.DtPaymentTo)
                    .HasColumnName("dtPaymentTo")
                    .HasColumnType("datetime");

                entity.Property(e => e.DtTo)
                    .HasColumnName("dtTo")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdProduct).HasColumnName("idProduct");

                entity.Property(e => e.Online).HasColumnName("online");

                entity.HasOne(d => d.IdProductNavigation)
                    .WithMany(p => p.Fee)
                    .HasForeignKey(d => d.IdProduct)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("FK_fee_product");
            });

            modelBuilder.Entity<Identifier>(entity =>
            {
                entity.ToTable("identifier");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Identifier1).HasColumnName("identifier");
            });

            modelBuilder.Entity<Job>(entity =>
            {
                entity.ToTable("job");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.MaxCount).HasColumnName("maxCount");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name");

                entity.Property(e => e.Public).HasColumnName("public");

                entity.Property(e => e.Tooltip).HasColumnName("tooltip");
            });

            modelBuilder.Entity<JobProductCategory>(entity =>
            {
                entity.ToTable("job_productCategory");

                entity.HasIndex(e => new { e.IdProductCategory, e.IdJob })
                    .HasName("UQ_job_productCategory")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.IdJob).HasColumnName("idJob");

                entity.Property(e => e.IdProductCategory).HasColumnName("idProductCategory");

                entity.HasOne(d => d.IdJobNavigation)
                    .WithMany(p => p.JobProductCategory)
                    .HasForeignKey(d => d.IdJob)
                    .HasConstraintName("FK_job_productCategory_job");

                entity.HasOne(d => d.IdProductCategoryNavigation)
                    .WithMany(p => p.JobProductCategory)
                    .HasForeignKey(d => d.IdProductCategory)
                    .HasConstraintName("FK_job_productCategory_productCategory");
            });

            modelBuilder.Entity<Payment>(entity =>
            {
                entity.ToTable("payment");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Amount)
                    .HasColumnName("amount")
                    .HasColumnType("decimal(18, 4)");

                entity.Property(e => e.Cash).HasColumnName("cash");

                entity.Property(e => e.DtCreated)
                    .HasColumnName("dtCreated")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdAccount).HasColumnName("idAccount");

                entity.Property(e => e.IdCurrency).HasColumnName("idCurrency");

                entity.Property(e => e.Note).HasColumnName("note");

                entity.Property(e => e.Payer).HasColumnName("payer");

                entity.HasOne(d => d.IdCurrencyNavigation)
                    .WithMany(p => p.Payment)
                    .HasForeignKey(d => d.IdCurrency)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_payments_currency");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("product");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Code)
                    .IsRequired()
                    .HasColumnName("code")
                    .HasMaxLength(15);

                entity.Property(e => e.IdProductCategory).HasColumnName("idProductCategory");

                entity.Property(e => e.Max).HasColumnName("max");

                entity.Property(e => e.Name)
                    .HasColumnName("name")
                    .HasMaxLength(50);

                entity.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("decimal(18, 4)");

                entity.HasOne(d => d.IdProductCategoryNavigation)
                    .WithMany(p => p.Product)
                    .HasForeignKey(d => d.IdProductCategory)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_product_productCategory");
            });

            modelBuilder.Entity<ProductCategory>(entity =>
            {
                entity.ToTable("productCategory");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name).HasColumnName("name");
            });

            modelBuilder.Entity<Qr>(entity =>
            {
                entity.ToTable("qr");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Seminar)
                    .IsRequired()
                    .HasColumnName("seminar");
            });

            modelBuilder.Entity<Sport>(entity =>
            {
                entity.ToTable("sport");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Team>(entity =>
            {
                entity.ToTable("team");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.DtModified)
                    .HasColumnName("dtModified")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdSport).HasColumnName("idSport");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name");

                entity.Property(e => e.Player1).HasColumnName("player1");

                entity.Property(e => e.Player2).HasColumnName("player2");

                entity.Property(e => e.Player3).HasColumnName("player3");

                entity.Property(e => e.Player4).HasColumnName("player4");

                entity.Property(e => e.Player5).HasColumnName("player5");

                entity.Property(e => e.Player6).HasColumnName("player6");

                entity.Property(e => e.Player7).HasColumnName("player7");

                entity.HasOne(d => d.IdSportNavigation)
                    .WithMany(p => p.Team)
                    .HasForeignKey(d => d.IdSport)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_team_sport");
            });
        }
    }
}
