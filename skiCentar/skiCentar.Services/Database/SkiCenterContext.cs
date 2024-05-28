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

    public virtual DbSet<Trail> Trails { get; set; }

    public virtual DbSet<TrailDifficulty> TrailDifficulties { get; set; }

    public virtual DbSet<TrailLocation> TrailLocations { get; set; }

    public virtual DbSet<TrailMaintenance> TrailMaintenances { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserDetail> UserDetails { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }

    //    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
    //        => optionsBuilder.UseSqlServer("Data Source=.; TrustServerCertificate=true;Initial Catalog=ski_center; trusted_connection=true");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<DailyWeather>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__daily_we__3213E83F8DDADEE6");

            entity.ToTable("daily_weather");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Date)
                .HasColumnType("date")
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

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Capacity).HasColumnName("capacity");
            entity.Property(e => e.IsFunctional)
                .IsRequired()
                .HasDefaultValueSql("((1))")
                .HasColumnName("is_functional");
            entity.Property(e => e.StateMachine).HasColumnName("state_machine");
            entity.Property(e => e.LiftTypeId).HasColumnName("lift_type_id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.ResortId).HasColumnName("resort_id");

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

            entity.Property(e => e.Id).HasColumnName("id");
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

        modelBuilder.Entity<Trail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__trail__3213E83FB5BAFCDF");

            entity.ToTable("trail");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.DifficultyId).HasColumnName("difficulty_id");
            entity.Property(e => e.IsFunctional)
                .IsRequired()
                .HasDefaultValueSql("((1))")
                .HasColumnName("is_functional");
            entity.Property(e => e.Length)
                .HasColumnType("decimal(5, 2)")
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

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.LastLoginDate)
                .HasColumnType("datetime")
                .HasColumnName("last_login_date");
            entity.Property(e => e.IsVerified)
                .HasDefaultValueSql("((1))")
                .HasColumnName("is_verified");
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
                        j.IndexerProperty<int>("UserId").HasColumnName("user_id");
                        j.IndexerProperty<int>("ResortId").HasColumnName("resort_id");
                    });
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

        base.OnModelCreating(modelBuilder);

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
            new UserRole { Name = "Uposlenik" },
            new UserRole { Name = "Korisnik" }
            );
        }

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
