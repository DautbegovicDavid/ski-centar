using Microsoft.EntityFrameworkCore;

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

        modelBuilder.Entity<Resort>().HasData(
            new Resort { Id = 1, Elevation = 2000, Location = "Sarajevo", Name = "Jahorina", SkiWorkHours = "od 9 do 4" },
            new Resort { Id = 2, Elevation = 1500, Location = "Travnik", Name = "Vlasic", SkiWorkHours = "9 AM - 5 PM" }
        );

        modelBuilder.Entity<LiftType>().HasData(
            new LiftType { Id = 1, Name = "Sjedeznica" },
            new LiftType { Id = 2, Name = "Gondola" },
            new LiftType { Id = 3, Name = "Sidro" },
            new LiftType { Id = 4, Name = "Pokretna staza" },
            new LiftType { Id = 5, Name = "Tanjir" },
            new LiftType { Id = 6, Name = "Rukohvat" }
        );

        modelBuilder.Entity<PoiCategory>().HasData(
            new PoiCategory { Id = 1, Name = "Info" },
            new PoiCategory { Id = 2, Name = "Ski School" },
            new PoiCategory { Id = 3, Name = "Ski Rent" },
            new PoiCategory { Id = 4, Name = "Hotel" },
            new PoiCategory { Id = 5, Name = "Medical" },
            new PoiCategory { Id = 6, Name = "Parking" },
            new PoiCategory { Id = 7, Name = "Restaurant" },
            new PoiCategory { Id = 8, Name = "Coffee & Tea" },
            new PoiCategory { Id = 9, Name = "Bar" }
        );

        modelBuilder.Entity<PointOfInterest>().HasData(
            new PointOfInterest { Id = 1, CategoryId = 1, Description = "Info and Tickets shop", LocationX = 43.732600m, LocationY = 18.565900m, Name = "Informacije", ResortId = 1 },
            new PointOfInterest { Id = 2, CategoryId = 2, Description = "Ski School", LocationX = 43.732700m, LocationY = 18.566000m, Name = "PRO SKI SCHOOL", ResortId = 1 },
            new PointOfInterest { Id = 3, CategoryId = 3, Description = "Ski rental", LocationX = 43.732800m, LocationY = 18.566100m, Name = "Vucko SKI rent", ResortId = 1 },
            new PointOfInterest { Id = 4, CategoryId = 4, Description = "Hotel & Spa", LocationX = 43.732900m, LocationY = 18.566200m, Name = "Hotel Vucko", ResortId = 1 },
            new PointOfInterest { Id = 5, CategoryId = 5, Description = "Medic & Apotecary 0-24", LocationX = 43.733000m, LocationY = 18.566300m, Name = "Hitna", ResortId = 1 },
            new PointOfInterest { Id = 6, CategoryId = 6, Description = "PARKING 0-24", LocationX = 43.733100m, LocationY = 18.566400m, Name = "Parking", ResortId = 1 },
            new PointOfInterest { Id = 7, CategoryId = 7, Description = "Restaurant 1", LocationX = 43.733200m, LocationY = 18.566500m, Name = "Restaurant 1", ResortId = 1 },
            new PointOfInterest { Id = 8, CategoryId = 8, Description = "Coffeee & Tea", LocationX = 43.733300m, LocationY = 18.566600m, Name = "Cafe bar 1", ResortId = 1 },
            new PointOfInterest { Id = 9, CategoryId = 9, Description = "Bar", LocationX = 43.733400m, LocationY = 18.566700m, Name = "Peggy", ResortId = 1 },
            new PointOfInterest { Id = 10, CategoryId = 1, Description = "Info and Tickets shop", LocationX = 44.302800m, LocationY = 17.595000m, Name = "Info Center Vlasic", ResortId = 2 },
            new PointOfInterest { Id = 11, CategoryId = 2, Description = "Ski School Vlasic", LocationX = 44.302900m, LocationY = 17.595100m, Name = "Vlasic SKI SCHOOL", ResortId = 2 },
            new PointOfInterest { Id = 12, CategoryId = 3, Description = "Ski rental Vlasic", LocationX = 44.303000m, LocationY = 17.595200m, Name = "Vlasic SKI rent", ResortId = 2 }
        );

        modelBuilder.Entity<TrailDifficulty>().HasData(
            new TrailDifficulty { Id = 1, Name = "Pocetnicke staza", Color = "Green" },
            new TrailDifficulty { Id = 2, Name = "Staze za srednje vjestine", Color = "Blue" },
            new TrailDifficulty { Id = 3, Name = "Napredne staza", Color = "Crvena" },
            new TrailDifficulty { Id = 4, Name = "Ekspertne staze", Color = "Black" }
        );

        modelBuilder.Entity<UserRole>().HasData(
            new UserRole { Id = 1, Name = "Admin" },
            new UserRole { Id = 2, Name = "Employee" },
            new UserRole { Id = 3, Name = "User" }
        );

        modelBuilder.Entity<User>().HasData(
            new User { Id = 1, Email = "employee@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 2 },
            new User { Id = 2, Email = "admin@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 1 },
            new User { Id = 3, Email = "user@email.com", IsVerified = true, LastLoginDate = DateTime.Now, Password = "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", RegistrationDate = DateTime.Now, UserDetailsId = null, UserRoleId = 3 }
        );

        modelBuilder.Entity<UserPoiInteraction>().HasData(
            new UserPoiInteraction { Id = 1, UserId = 3, PoiId = 1, InteractionType = "view", InteractionTimestamp = DateTime.UtcNow },
            new UserPoiInteraction { Id = 2, UserId = 3, PoiId = 1, InteractionType = "view", InteractionTimestamp = DateTime.UtcNow }
        );

        modelBuilder.Entity<TicketTypeSeniority>().HasData(
            new TicketTypeSeniority { Id = 1, Seniority = "Junior" },
            new TicketTypeSeniority { Id = 2, Seniority = "Adult" },
            new TicketTypeSeniority { Id = 3, Seniority = "Senior" }
        );

        modelBuilder.Entity<TicketType>().HasData(
            new TicketType { Id = 1, FullDay = true, Price = 100, TicketTypeSeniorityId = 2, ResortId = 1 },
            new TicketType { Id = 2, FullDay = false, Price = 67, TicketTypeSeniorityId = 2, ResortId = 1 },
            new TicketType { Id = 3, FullDay = true, Price = 50, TicketTypeSeniorityId = 1, ResortId = 1 },
            new TicketType { Id = 4, FullDay = false, Price = 50, TicketTypeSeniorityId = 1, ResortId = 1 },
            new TicketType { Id = 5, FullDay = true, Price = 67, TicketTypeSeniorityId = 3, ResortId = 1 },
            new TicketType { Id = 6, FullDay = true, Price = 57, TicketTypeSeniorityId = 2, ResortId = 2 },
            new TicketType { Id = 7, FullDay = false, Price = 37, TicketTypeSeniorityId = 2, ResortId = 2 },
            new TicketType { Id = 8, FullDay = true, Price = 37, TicketTypeSeniorityId = 1, ResortId = 2 },
            new TicketType { Id = 9, FullDay = true, Price = 47, TicketTypeSeniorityId = 3, ResortId = 2 }
        );

        modelBuilder.Entity<Lift>().HasData(
            new Lift { Id = 1, IsFunctional = true, Capacity = 6, ResortId = 1, StateMachine = "draft", LiftTypeId = 1, Name = "Ogorjelica" },
            new Lift { Id = 2, IsFunctional = true, Capacity = 2, ResortId = 1, StateMachine = "draft", LiftTypeId = 3, Name = "Poljice" },
            new Lift { Id = 3, IsFunctional = true, Capacity = 2, ResortId = 2, StateMachine = "draft", LiftTypeId = 3, Name = "Babanovac" }
        );

        modelBuilder.Entity<LiftLocation>().HasData(
           new LiftLocation { Id = 1, LiftId = 1, LocationX = 43.729465m, LocationY = 18.565698m },
           new LiftLocation { Id = 2, LiftId = 1, LocationX = 43.732628m, LocationY = 18.571362m },
           new LiftLocation { Id = 3, LiftId = 2, LocationX = 43.736905m, LocationY = 18.566122m },
           new LiftLocation { Id = 4, LiftId = 2, LocationX = 43.732582m, LocationY = 18.562523m },
           new LiftLocation { Id = 5, LiftId = 3, LocationX = 44.314474m, LocationY = 17.573487m },
           new LiftLocation { Id = 6, LiftId = 3, LocationX = 44.311628m, LocationY = 17.581339m }
        );

        modelBuilder.Entity<Trail>().HasData(
            new Trail { Id = 1, IsFunctional = true, DifficultyId = 2, ResortId = 2, Name = "Babanovac", Length = 357 },
            new Trail { Id = 2, IsFunctional = true, DifficultyId = 3, ResortId = 1, Name = "Poljice", Length = 699 }
        );

        modelBuilder.Entity<TrailLocation>().HasData(
          new TrailLocation { Id = 1, TrailId = 1, LocationX = 44.314662m, LocationY = 17.573635m },
          new TrailLocation { Id = 2, TrailId = 1, LocationX = 44.313771m, LocationY = 17.575462m },
          new TrailLocation { Id = 3, TrailId = 1, LocationX = 44.313441m, LocationY = 17.578091m },
          new TrailLocation { Id = 4, TrailId = 1, LocationX = 44.312513m, LocationY = 17.580054m },
          new TrailLocation { Id = 5, TrailId = 1, LocationX = 44.311523m, LocationY = 17.580822m },
          new TrailLocation { Id = 6, TrailId = 2, LocationX = 43.736601m, LocationY = 18.565749m },
          new TrailLocation { Id = 7, TrailId = 2, LocationX = 43.734914m, LocationY = 18.564499m },
          new TrailLocation { Id = 8, TrailId = 2, LocationX = 43.733705m, LocationY = 18.564546m },
          new TrailLocation { Id = 9, TrailId = 2, LocationX = 43.732563m, LocationY = 18.562966m },
          new TrailLocation { Id = 10, TrailId = 2, LocationX = 43.732035m, LocationY = 18.560514m }
        );

        modelBuilder.Entity<DailyWeather>().HasData(
           new DailyWeather { Id = 1, Temperature = -5, Precipitation = 0, ResortId = 2, WindSpeed = 10, Humidity = 3, WeatherCondition = "ok", SnowHeight = 14, Date = DateTime.Now },
           new DailyWeather { Id = 2, Temperature = 3, Precipitation = 10, ResortId = 1, WindSpeed = 3, Humidity = 45, WeatherCondition = "not recommended for beginners", SnowHeight = 24, Date = DateTime.Now }
        );

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
