﻿using Microsoft.EntityFrameworkCore;

namespace skiCentar.Services.Database;

public partial class SkiCenterContext : DbContext
{
    public SkiCenterContext()
    {
    }

    public SkiCenterContext(DbContextOptions<SkiCenterContext> options)
        : base(options)
    {
    }

    public virtual DbSet<DailyWeather> DailyWeathers { get; set; }

    public virtual DbSet<Lift> Lifts { get; set; }

    public virtual DbSet<LiftLocation> LiftLocations { get; set; }

    public virtual DbSet<LiftMaintenance> LiftMaintenances { get; set; }

    public virtual DbSet<LiftType> LiftTypes { get; set; }

    public virtual DbSet<PoiCategory> PoiCategories { get; set; }

    public virtual DbSet<PointOfInterest> PointOfInterests { get; set; }

    public virtual DbSet<Resort> Resorts { get; set; }

    public virtual DbSet<SkiAccident> SkiAccidents { get; set; }

    public virtual DbSet<Ticket> Tickets { get; set; }

    public virtual DbSet<TicketPurchase> TicketPurchases { get; set; }

    public virtual DbSet<TicketType> TicketTypes { get; set; }

    public virtual DbSet<TicketTypeSeniority> TicketTypeSeniorities { get; set; }

    public virtual DbSet<Trail> Trails { get; set; }

    public virtual DbSet<TrailDifficulty> TrailDifficulties { get; set; }

    public virtual DbSet<TrailLocation> TrailLocations { get; set; }

    public virtual DbSet<TrailMaintenance> TrailMaintenances { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserDetail> UserDetails { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }

    public virtual DbSet<UserVerification> UserVerifications { get; set; }

    public DbSet<UserPoiInteraction> UserPoiInteractions { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<DailyWeather>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__daily_we__3213E83F8DDADEE6");

            entity.ToTable("daily_weather");

            entity.HasIndex(e => e.ResortId, "IX_daily_weather_resort_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Date)
                .HasColumnType("datetime")
                .HasColumnName("date");
            entity.Property(e => e.Humidity)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("humidity");
            entity.Property(e => e.Precipitation)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("precipitation");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");
            entity.Property(e => e.SnowHeight)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("snow_height");
            entity.Property(e => e.Temperature)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("temperature");
            entity.Property(e => e.WeatherCondition)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("weather_condition");
            entity.Property(e => e.WindSpeed)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("wind_speed");

            entity.HasOne(d => d.Resort).WithMany(p => p.DailyWeathers)
                .HasForeignKey(d => d.ResortId)
                .HasConstraintName("FK__daily_wea__resor__267ABA7A");
        });

        modelBuilder.Entity<Lift>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__lift__3213E83F0CC826DF");

            entity.ToTable("lift");

            entity.HasIndex(e => e.LiftTypeId, "IX_lift_lift_type_id");

            entity.HasIndex(e => e.ResortId, "IX_lift_resort_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Capacity).HasColumnName("capacity");
            entity.Property(e => e.IsFunctional)
                .IsRequired()
                .HasDefaultValueSql("((1))")
                .HasColumnName("is_functional");
            entity.Property(e => e.LiftTypeId).HasColumnName("lift_type_id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");
            entity.Property(e => e.StateMachine)
                .HasMaxLength(100)
                .HasColumnName("state_machine");

            entity.HasOne(d => d.LiftType).WithMany(p => p.Lifts)
                .HasForeignKey(d => d.LiftTypeId)
                .HasConstraintName("FK__lift__lift_type___34C8D9D1");

            entity.HasOne(d => d.Resort).WithMany(p => p.Lifts)
                .HasForeignKey(d => d.ResortId)
                .HasConstraintName("FK__lift__resort_id__35BCFE0A");
        });

        modelBuilder.Entity<LiftLocation>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__lift_loc__3213E83F658B649E");

            entity.ToTable("lift_location");

            entity.HasIndex(e => e.LiftId, "IX_lift_location_lift_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.LiftId).HasColumnName("lift_id");
            entity.Property(e => e.LocationX)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_x");
            entity.Property(e => e.LocationY)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_y");

            entity.HasOne(d => d.Lift).WithMany(p => p.LiftLocations)
                .HasForeignKey(d => d.LiftId)
                .HasConstraintName("FK__lift_loca__lift___3C69FB99");
        });

        modelBuilder.Entity<LiftMaintenance>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__lift_mai__3213E83F1677EEE9");

            entity.ToTable("lift_maintenance");

            entity.HasIndex(e => e.LiftId, "IX_lift_maintenance_lift_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.LiftId).HasColumnName("lift_id");
            entity.Property(e => e.MaintenanceEnd)
                .HasColumnType("datetime")
                .HasColumnName("maintenance_end");
            entity.Property(e => e.MaintenanceStart)
                .HasColumnType("datetime")
                .HasColumnName("maintenance_start");

            entity.HasOne(d => d.Lift).WithMany(p => p.LiftMaintenances)
                .HasForeignKey(d => d.LiftId)
                .HasConstraintName("FK__lift_main__lift___398D8EEE");
        });

        modelBuilder.Entity<LiftType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__lift_typ__3213E83F09F8F725");

            entity.ToTable("lift_type");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<PoiCategory>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__poi_cate__3213E83FDA520F22");

            entity.ToTable("poi_category");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<PointOfInterest>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__point_of__3213E83FB040CD86");

            entity.ToTable("point_of_interest");

            entity.HasIndex(e => e.CategoryId, "IX_point_of_interest_category_id");

            entity.HasIndex(e => e.ResortId, "IX_point_of_interest_resort_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.LocationX)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_x");
            entity.Property(e => e.LocationY)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_y");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");

            entity.HasOne(d => d.Category).WithMany(p => p.PointOfInterests)
                .HasForeignKey(d => d.CategoryId)
                .HasConstraintName("FK__point_of___categ__5165187F");

            entity.HasOne(d => d.Resort).WithMany(p => p.PointOfInterests)
                .HasForeignKey(d => d.ResortId)
                .HasConstraintName("FK__point_of___resor__52593CB8");

            entity.HasMany(d => d.UserPoiInteractions)
                .WithOne(p => p.PointOfInterest)
                .HasForeignKey(d => d.PoiId)
                .HasConstraintName("FK__user_poi_interaction__poi_id");

        });

        modelBuilder.Entity<Resort>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__resort__3213E83F95FCDA33");

            entity.ToTable("resort");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Elevation).HasColumnName("elevation");
            entity.Property(e => e.Location)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("location");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.SkiWorkHours)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("ski_work_hours");
        });

        modelBuilder.Entity<SkiAccident>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ski_acci__3213E83FBC915BFB");

            entity.ToTable("ski_accident");

            entity.HasIndex(e => e.TrailId, "IX_ski_accident_trail_id");

            entity.HasIndex(e => e.UserId, "IX_ski_accident_user_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .IsUnicode(false)
                .HasColumnName("description");

            entity.Property(e => e.IsActive)
               .HasDefaultValueSql("((1))")
               .HasColumnName("is_active");

            entity.Property(e => e.IsReporterInjured)
               .HasDefaultValueSql("((0))")
               .HasColumnName("is_reporter_injured");

            entity.Property(e => e.PeopleInvolved).HasColumnName("people_involved");

            entity.Property(e => e.LocationX)
                .IsRequired()
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_x");
            entity.Property(e => e.LocationY)
                .IsRequired()
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_y");
            entity.Property(e => e.Timestamp)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("timestamp");
            entity.Property(e => e.TrailId).HasColumnName("trail_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Trail).WithMany(p => p.SkiAccidents)
                .HasForeignKey(d => d.TrailId)
                .HasConstraintName("FK__ski_accid__trail__5629CD9C");

            entity.HasOne(d => d.User).WithMany(p => p.SkiAccidents)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__ski_accid__user___5535A963");
        });

        modelBuilder.Entity<Ticket>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ticket__3213E83FADDC681A");

            entity.ToTable("ticket");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Active).HasColumnName("active");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.TicketTypeId).HasColumnName("ticket_type_id");
            entity.Property(e => e.TotalPrice)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("total_price");
            entity.Property(e => e.ValidFrom)
                .HasColumnType("date")
                .HasColumnName("valid_from");
            entity.Property(e => e.ValidTo)
                .HasColumnType("date")
                .HasColumnName("valid_to");

            entity.HasOne(d => d.TicketType).WithMany(p => p.Tickets)
                .HasForeignKey(d => d.TicketTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ticket__ticket_t__2B0A656D");
        });

        modelBuilder.Entity<TicketPurchase>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ticket_p__3213E83FF58BF17D");

            entity.ToTable("ticket_purchase");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.PurchaseDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("purchase_date");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.StripePaymentIntentId)
                .HasMaxLength(255)
                .HasColumnName("stripe_payment_intent_id");
            entity.Property(e => e.TicketId).HasColumnName("ticket_id");
            entity.Property(e => e.TotalPrice)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("total_price");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Ticket).WithMany(p => p.TicketPurchases)
                .HasForeignKey(d => d.TicketId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ticket_pu__ticke__32AB8735");

            entity.HasOne(d => d.User).WithMany(p => p.TicketPurchases)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ticket_pu__user___31B762FC");
        });

        modelBuilder.Entity<TicketType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ticket_t__3213E83F8918DEA6");

            entity.ToTable("ticket_type");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.FullDay).HasColumnName("full_day");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("price");
            entity.Property(e => e.TicketTypeSeniorityId).HasColumnName("ticket_type_seniority_id");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");

            entity.HasOne(d => d.TicketTypeSeniority).WithMany(p => p.TicketTypes)
                .HasForeignKey(d => d.TicketTypeSeniorityId)
                .HasConstraintName("FK_ticket_type_ticket_type_seniority");

            entity.HasOne(d => d.Resort).WithMany(p => p.TicketTypes)
                .HasForeignKey(d => d.ResortId)
                .HasConstraintName("FK_ticket_type_resort");
        });

        modelBuilder.Entity<TicketTypeSeniority>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ticket_t__3213E83F6EE6FBB4");

            entity.ToTable("ticket_type_seniority");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Seniority)
                .HasMaxLength(50)
                .HasColumnName("seniority");
        });

        modelBuilder.Entity<Trail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__trail__3213E83FB5BAFCDF");

            entity.ToTable("trail");

            entity.HasIndex(e => e.DifficultyId, "IX_trail_difficulty_id");

            entity.HasIndex(e => e.ResortId, "IX_trail_resort_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.DifficultyId).HasColumnName("difficulty_id");
            entity.Property(e => e.IsFunctional)
                .IsRequired()
                .HasDefaultValueSql("((1))")
                .HasColumnName("is_functional");
            entity.Property(e => e.Length)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("length");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");

            entity.HasOne(d => d.Difficulty).WithMany(p => p.Trails)
                .HasForeignKey(d => d.DifficultyId)
                .HasConstraintName("FK__trail__difficult__2B3F6F97");

            entity.HasOne(d => d.Resort).WithMany(p => p.Trails)
                .HasForeignKey(d => d.ResortId)
                .HasConstraintName("FK__trail__resort_id__2C3393D0");
        });

        modelBuilder.Entity<TrailDifficulty>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__trail_di__3213E83F5DF5ADE9");

            entity.ToTable("trail_difficulty");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Color)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("color");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<TrailLocation>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__trail_lo__3213E83F2E8E656F");

            entity.ToTable("trail_location");

            entity.HasIndex(e => e.TrailId, "IX_trail_location_trail_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.LocationX)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_x");
            entity.Property(e => e.LocationY)
                .HasColumnType("decimal(10, 6)")
                .HasColumnName("location_y");
            entity.Property(e => e.TrailId).HasColumnName("trail_id");

            entity.HasOne(d => d.Trail).WithMany(p => p.TrailLocations)
                .HasForeignKey(d => d.TrailId)
                .HasConstraintName("FK__trail_loc__trail__3F466844");
        });

        modelBuilder.Entity<TrailMaintenance>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__trail_ma__3213E83F335D1040");

            entity.ToTable("trail_maintenance");

            entity.HasIndex(e => e.TrailId, "IX_trail_maintenance_trail_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.MaintenanceEnd)
                .HasColumnType("datetime")
                .HasColumnName("maintenance_end");
            entity.Property(e => e.MaintenanceStart)
                .HasColumnType("datetime")
                .HasColumnName("maintenance_start");
            entity.Property(e => e.TrailId).HasColumnName("trail_id");

            entity.HasOne(d => d.Trail).WithMany(p => p.TrailMaintenances)
                .HasForeignKey(d => d.TrailId)
                .HasConstraintName("FK__trail_mai__trail__300424B4");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user__3213E83FDCF4DEF2");

            entity.ToTable("user");

            entity.HasIndex(e => e.UserDetailsId, "IX_user_user_details_id");

            entity.HasIndex(e => e.UserRoleId, "IX_user_user_role_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.IsVerified)
                .HasDefaultValueSql("((0))")
                .HasColumnName("is_verified");
            entity.Property(e => e.LastLoginDate)
                .HasColumnType("datetime")
                .HasColumnName("last_login_date");
            entity.Property(e => e.Password)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("password");
            entity.Property(e => e.RegistrationDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("registration_date");
            entity.Property(e => e.UserDetailsId).HasColumnName("user_details_id");
            entity.Property(e => e.UserRoleId).HasColumnName("user_role_id");

            entity.HasOne(d => d.UserDetails).WithMany(p => p.Users)
                .HasForeignKey(d => d.UserDetailsId)
                .HasConstraintName("FK__user__user_detai__48CFD27E");

            entity.HasOne(d => d.UserRole).WithMany(p => p.Users)
                .HasForeignKey(d => d.UserRoleId)
                .HasConstraintName("FK__user__user_role___47DBAE45");

            entity.HasMany(d => d.Resorts).WithMany(p => p.Users)
                .UsingEntity<Dictionary<string, object>>(
                    "UserResort",
                    r => r.HasOne<Resort>().WithMany()
                        .HasForeignKey("ResortId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__user_reso__resor__4CA06362"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__user_reso__user___4BAC3F29"),
                    j =>
                    {
                        j.HasKey("UserId", "ResortId").HasName("PK__user_res__D2DFBAD28F0E6CB8");
                        j.ToTable("user_resort");
                        j.HasIndex(new[] { "ResortId" }, "IX_user_resort_resort_id");
                        j.IndexerProperty<int>("UserId").HasColumnName("user_id");
                        j.IndexerProperty<int>("ResortId").HasColumnName("resort_id");
                    });

            entity.HasMany(d => d.UserPoiInteractions)
              .WithOne(p => p.User)
              .HasForeignKey(d => d.UserId)
              .HasConstraintName("FK__user_poi_interaction__user_id");
        });

        modelBuilder.Entity<UserDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user_det__3213E83F47A47460");

            entity.ToTable("user_details");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("last_name");
            entity.Property(e => e.DateOfBirth)
               .HasColumnType("datetime")
               .HasColumnName("date_of_birth");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<UserRole>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user_rol__3213E83FD6D48D1E");

            entity.ToTable("user_role");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<UserVerification>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user_ver__3213E83DB5BAFCDC");

            entity.ToTable("user_verification");

            entity.HasIndex(e => e.UserId, "IX_user_verification_user_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.VerificationCode)
                .HasMaxLength(256)
                .IsUnicode(false)
                .HasColumnName("verification_code");

            entity.HasOne(d => d.User).WithMany(p => p.UserVerifications)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__user_ver__user_id__2C3393D0");
        });
        modelBuilder.Entity<UserPoiInteraction>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user_poi_interaction__3213E83F8DDADEE6");

            entity.ToTable("user_poi_interaction");

            entity.HasIndex(e => e.UserId, "IX_user_poi_interaction_user_id");
            entity.HasIndex(e => e.PoiId, "IX_user_poi_interaction_poi_id");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.PoiId).HasColumnName("poi_id");
            entity.Property(e => e.InteractionType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("interaction_type");
            entity.Property(e => e.InteractionTimestamp)
                .HasColumnType("datetime")
                .HasColumnName("interaction_timestamp");

            entity.HasOne(d => d.User)
                .WithMany(p => p.UserPoiInteractions)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__user_poi_interaction__user_id__267ABA7A");

            entity.HasOne(d => d.PointOfInterest)
                .WithMany(p => p.UserPoiInteractions)
                .HasForeignKey(d => d.PoiId)
                .HasConstraintName("FK__user_poi_interaction__poi_id__267ABA7A");
        });

        base.OnModelCreating(modelBuilder);
        if (!modelBuilder.Model.FindEntityType(typeof(Resort)).GetNavigations().Any())
        {
            // Add default data for Resort
            modelBuilder.Entity<Resort>().HasData(
            new Resort { Id = 1, Elevation = 1500, Location = "Sarajevo", Name = "Jahorina", SkiWorkHours = "9 AM - 5 PM" },
            new Resort { Id = 2, Elevation = 1500, Location = "Travnik", Name = "Vlasic", SkiWorkHours = "9 AM - 5 PM" }

        );
        }

        //
        if (!modelBuilder.Model.FindEntityType(typeof(LiftType)).GetNavigations().Any())
        {
            modelBuilder.Entity<LiftType>().HasData(
            new LiftType { Name = "Sjedeznica" },
            new LiftType { Name = "Gondola" },
            new LiftType { Name = "Sidro" },
            new LiftType { Name = "Pokretna staza" },
            new LiftType { Name = "Tanjir" },
            new LiftType { Name = "Rukohvat" }
            );
        }

        if (!modelBuilder.Model.FindEntityType(typeof(PoiCategory)).GetNavigations().Any())
        {
            modelBuilder.Entity<PoiCategory>().HasData(
            new PoiCategory { Name = "Ski kasa" },
            new PoiCategory { Name = "Ski skola" },
            new PoiCategory { Name = "Ski Rental" },
            new PoiCategory { Name = "Hitna" },
            new PoiCategory { Name = "WC" },
            new PoiCategory { Name = "Parking" },
            new PoiCategory { Name = "Restoran" },
            new PoiCategory { Name = "Kafic" }
            );
        }
        if (!modelBuilder.Model.FindEntityType(typeof(PointOfInterest)).GetNavigations().Any())
        {
            // Add default data for PointOfInterest
            modelBuilder.Entity<PointOfInterest>().HasData(
            new PointOfInterest { Id = 1, CategoryId = 7, Description = "Restaurant 1", LocationX = 45.123456m, LocationY = 14.123456m, Name = "Restaurant 1", ResortId = 1 }
        );
        }

        if (!modelBuilder.Model.FindEntityType(typeof(TrailDifficulty)).GetNavigations().Any())
        {
            modelBuilder.Entity<TrailDifficulty>().HasData(
            new TrailDifficulty { Name = "Pocetnicke staza", Color = "Green" },
            new TrailDifficulty { Name = "Staze za srednje vjestine", Color = "Blue" },
            new TrailDifficulty { Name = "Napredne staza", Color = "Crvena" },
            new TrailDifficulty { Name = "Ekspertne staze", Color = "Black" }
            );
        }

        if (!modelBuilder.Model.FindEntityType(typeof(UserRole)).GetNavigations().Any())
        {
            modelBuilder.Entity<UserRole>().HasData(
            new UserRole { Name = "Admin" },
            new UserRole { Name = "Employee" },
            new UserRole { Name = "User" }
            );
        }


        if (!modelBuilder.Model.FindEntityType(typeof(User)).GetNavigations().Any())
        {
            modelBuilder.Entity<User>().HasData(
            new User { Id = 1, Email = "employee@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 2 },

            new User { Id = 1, Email = "admin@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 1 },

            new User { Id = 1, Email = "user@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 3 }
);
        }


        if (!modelBuilder.Model.FindEntityType(typeof(UserPoiInteraction)).GetNavigations().Any())
        {
            modelBuilder.Entity<UserPoiInteraction>().HasData(
new UserPoiInteraction { Id = 1, UserId = 1, PoiId = 1, InteractionType = "view", InteractionTimestamp = DateTime.UtcNow },
new UserPoiInteraction { Id = 2, UserId = 2, PoiId = 2, InteractionType = "view", InteractionTimestamp = DateTime.UtcNow }
);
        }


        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
