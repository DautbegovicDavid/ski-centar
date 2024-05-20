﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using skiCentar.Services.Database;

#nullable disable

namespace skiCentar.Services.Migrations
{
    [DbContext(typeof(SkiCenterContext))]
    [Migration("20240516141444_updatedLiftTable")]
    partial class updatedLiftTable
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.14")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("UserResort", b =>
                {
                    b.Property<int>("UserId")
                        .HasColumnType("int")
                        .HasColumnName("user_id");

                    b.Property<int>("ResortId")
                        .HasColumnType("int")
                        .HasColumnName("resort_id");

                    b.HasKey("UserId", "ResortId")
                        .HasName("PK__user_res__D2DFBAD28F0E6CB8");

                    b.HasIndex("ResortId");

                    b.ToTable("user_resort", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.DailyWeather", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("Date")
                        .HasColumnType("date")
                        .HasColumnName("date");

                    b.Property<decimal?>("Humidity")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("humidity");

                    b.Property<decimal?>("Precipitation")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("precipitation");

                    b.Property<int?>("ResortId")
                        .HasColumnType("int")
                        .HasColumnName("resort_id");

                    b.Property<decimal?>("SnowHeight")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("snow_height");

                    b.Property<decimal?>("Temperature")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("temperature");

                    b.Property<string>("WeatherCondition")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("weather_condition");

                    b.Property<decimal?>("WindSpeed")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("wind_speed");

                    b.HasKey("Id")
                        .HasName("PK__daily_we__3213E83F8DDADEE6");

                    b.HasIndex("ResortId");

                    b.ToTable("daily_weather", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.Lift", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("Capacity")
                        .HasColumnType("int")
                        .HasColumnName("capacity");

                    b.Property<bool?>("IsFunctional")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasColumnName("is_functional")
                        .HasDefaultValueSql("((1))");

                    b.Property<int?>("LiftTypeId")
                        .HasColumnType("int")
                        .HasColumnName("lift_type_id");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.Property<int?>("ResortId")
                        .HasColumnType("int")
                        .HasColumnName("resort_id");

                    b.Property<string>("StateMachine")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id")
                        .HasName("PK__lift__3213E83F0CC826DF");

                    b.HasIndex("LiftTypeId");

                    b.HasIndex("ResortId");

                    b.ToTable("lift", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftLocation", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("LiftId")
                        .HasColumnType("int")
                        .HasColumnName("lift_id");

                    b.Property<decimal?>("LocationX")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_x");

                    b.Property<decimal?>("LocationY")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_y");

                    b.HasKey("Id")
                        .HasName("PK__lift_loc__3213E83F658B649E");

                    b.HasIndex("LiftId");

                    b.ToTable("lift_location", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftMaintenance", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)")
                        .HasColumnName("description");

                    b.Property<int?>("LiftId")
                        .HasColumnType("int")
                        .HasColumnName("lift_id");

                    b.Property<DateTime?>("MaintenanceEnd")
                        .HasColumnType("datetime")
                        .HasColumnName("maintenance_end");

                    b.Property<DateTime?>("MaintenanceStart")
                        .HasColumnType("datetime")
                        .HasColumnName("maintenance_start");

                    b.HasKey("Id")
                        .HasName("PK__lift_mai__3213E83F1677EEE9");

                    b.HasIndex("LiftId");

                    b.ToTable("lift_maintenance", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftType", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.HasKey("Id")
                        .HasName("PK__lift_typ__3213E83F09F8F725");

                    b.ToTable("lift_type", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.PoiCategory", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.HasKey("Id")
                        .HasName("PK__poi_cate__3213E83FDA520F22");

                    b.ToTable("poi_category", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.PointOfInterest", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("CategoryId")
                        .HasColumnType("int")
                        .HasColumnName("category_id");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasMaxLength(1000)
                        .IsUnicode(false)
                        .HasColumnType("varchar(1000)")
                        .HasColumnName("description");

                    b.Property<decimal?>("LocationX")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_x");

                    b.Property<decimal?>("LocationY")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_y");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.Property<int?>("ResortId")
                        .HasColumnType("int")
                        .HasColumnName("resort_id");

                    b.HasKey("Id")
                        .HasName("PK__point_of__3213E83FB040CD86");

                    b.HasIndex("CategoryId");

                    b.HasIndex("ResortId");

                    b.ToTable("point_of_interest", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.Resort", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("Elevation")
                        .HasColumnType("int")
                        .HasColumnName("elevation");

                    b.Property<string>("Location")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("location");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.Property<string>("SkiWorkHours")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("ski_work_hours");

                    b.HasKey("Id")
                        .HasName("PK__resort__3213E83F95FCDA33");

                    b.ToTable("resort", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.SkiAccident", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasMaxLength(1000)
                        .IsUnicode(false)
                        .HasColumnType("varchar(1000)")
                        .HasColumnName("description");

                    b.Property<decimal?>("LocationX")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_x");

                    b.Property<decimal?>("LocationY")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_y");

                    b.Property<DateTime?>("Timestamp")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("datetime")
                        .HasColumnName("timestamp")
                        .HasDefaultValueSql("(getdate())");

                    b.Property<int?>("TrailId")
                        .HasColumnType("int")
                        .HasColumnName("trail_id");

                    b.Property<int?>("UserId")
                        .HasColumnType("int")
                        .HasColumnName("user_id");

                    b.HasKey("Id")
                        .HasName("PK__ski_acci__3213E83FBC915BFB");

                    b.HasIndex("TrailId");

                    b.HasIndex("UserId");

                    b.ToTable("ski_accident", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.Trail", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("DifficultyId")
                        .HasColumnType("int")
                        .HasColumnName("difficulty_id");

                    b.Property<bool?>("IsFunctional")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasColumnName("is_functional")
                        .HasDefaultValueSql("((1))");

                    b.Property<decimal?>("Length")
                        .HasColumnType("decimal(5, 2)")
                        .HasColumnName("length");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.Property<int?>("ResortId")
                        .HasColumnType("int")
                        .HasColumnName("resort_id");

                    b.HasKey("Id")
                        .HasName("PK__trail__3213E83FB5BAFCDF");

                    b.HasIndex("DifficultyId");

                    b.HasIndex("ResortId");

                    b.ToTable("trail", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailDifficulty", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Color")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("color");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.HasKey("Id")
                        .HasName("PK__trail_di__3213E83F5DF5ADE9");

                    b.ToTable("trail_difficulty", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailLocation", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal?>("LocationX")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_x");

                    b.Property<decimal?>("LocationY")
                        .HasColumnType("decimal(10, 6)")
                        .HasColumnName("location_y");

                    b.Property<int?>("TrailId")
                        .HasColumnType("int")
                        .HasColumnName("trail_id");

                    b.HasKey("Id")
                        .HasName("PK__trail_lo__3213E83F2E8E656F");

                    b.HasIndex("TrailId");

                    b.ToTable("trail_location", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailMaintenance", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)")
                        .HasColumnName("description");

                    b.Property<DateTime?>("MaintenanceEnd")
                        .HasColumnType("datetime")
                        .HasColumnName("maintenance_end");

                    b.Property<DateTime?>("MaintenanceStart")
                        .HasColumnType("datetime")
                        .HasColumnName("maintenance_start");

                    b.Property<int?>("TrailId")
                        .HasColumnType("int")
                        .HasColumnName("trail_id");

                    b.HasKey("Id")
                        .HasName("PK__trail_ma__3213E83F335D1040");

                    b.HasIndex("TrailId");

                    b.ToTable("trail_maintenance", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("email");

                    b.Property<DateTime?>("LastLoginDate")
                        .HasColumnType("datetime")
                        .HasColumnName("last_login_date");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("password");

                    b.Property<DateTime?>("RegistrationDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("datetime")
                        .HasColumnName("registration_date")
                        .HasDefaultValueSql("(getdate())");

                    b.Property<int?>("UserDetailsId")
                        .HasColumnType("int")
                        .HasColumnName("user_details_id");

                    b.Property<int?>("UserRoleId")
                        .HasColumnType("int")
                        .HasColumnName("user_role_id");

                    b.HasKey("Id")
                        .HasName("PK__user__3213E83FDCF4DEF2");

                    b.HasIndex("UserDetailsId");

                    b.HasIndex("UserRoleId");

                    b.ToTable("user", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.UserDetail", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("last_name");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.HasKey("Id")
                        .HasName("PK__user_det__3213E83F47A47460");

                    b.ToTable("user_details", (string)null);
                });

            modelBuilder.Entity("skiCentar.Services.Database.UserRole", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("name");

                    b.HasKey("Id")
                        .HasName("PK__user_rol__3213E83FD6D48D1E");

                    b.ToTable("user_role", (string)null);
                });

            modelBuilder.Entity("UserResort", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Resort", null)
                        .WithMany()
                        .HasForeignKey("ResortId")
                        .IsRequired()
                        .HasConstraintName("FK__user_reso__resor__4CA06362");

                    b.HasOne("skiCentar.Services.Database.User", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .IsRequired()
                        .HasConstraintName("FK__user_reso__user___4BAC3F29");
                });

            modelBuilder.Entity("skiCentar.Services.Database.DailyWeather", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Resort", "Resort")
                        .WithMany("DailyWeathers")
                        .HasForeignKey("ResortId")
                        .HasConstraintName("FK__daily_wea__resor__267ABA7A");

                    b.Navigation("Resort");
                });

            modelBuilder.Entity("skiCentar.Services.Database.Lift", b =>
                {
                    b.HasOne("skiCentar.Services.Database.LiftType", "LiftType")
                        .WithMany("Lifts")
                        .HasForeignKey("LiftTypeId")
                        .HasConstraintName("FK__lift__lift_type___34C8D9D1");

                    b.HasOne("skiCentar.Services.Database.Resort", "Resort")
                        .WithMany("Lifts")
                        .HasForeignKey("ResortId")
                        .HasConstraintName("FK__lift__resort_id__35BCFE0A");

                    b.Navigation("LiftType");

                    b.Navigation("Resort");
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftLocation", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Lift", "Lift")
                        .WithMany("LiftLocations")
                        .HasForeignKey("LiftId")
                        .HasConstraintName("FK__lift_loca__lift___3C69FB99");

                    b.Navigation("Lift");
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftMaintenance", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Lift", "Lift")
                        .WithMany("LiftMaintenances")
                        .HasForeignKey("LiftId")
                        .HasConstraintName("FK__lift_main__lift___398D8EEE");

                    b.Navigation("Lift");
                });

            modelBuilder.Entity("skiCentar.Services.Database.PointOfInterest", b =>
                {
                    b.HasOne("skiCentar.Services.Database.PoiCategory", "Category")
                        .WithMany("PointOfInterests")
                        .HasForeignKey("CategoryId")
                        .HasConstraintName("FK__point_of___categ__5165187F");

                    b.HasOne("skiCentar.Services.Database.Resort", "Resort")
                        .WithMany("PointOfInterests")
                        .HasForeignKey("ResortId")
                        .HasConstraintName("FK__point_of___resor__52593CB8");

                    b.Navigation("Category");

                    b.Navigation("Resort");
                });

            modelBuilder.Entity("skiCentar.Services.Database.SkiAccident", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Trail", "Trail")
                        .WithMany("SkiAccidents")
                        .HasForeignKey("TrailId")
                        .HasConstraintName("FK__ski_accid__trail__5629CD9C");

                    b.HasOne("skiCentar.Services.Database.User", "User")
                        .WithMany("SkiAccidents")
                        .HasForeignKey("UserId")
                        .HasConstraintName("FK__ski_accid__user___5535A963");

                    b.Navigation("Trail");

                    b.Navigation("User");
                });

            modelBuilder.Entity("skiCentar.Services.Database.Trail", b =>
                {
                    b.HasOne("skiCentar.Services.Database.TrailDifficulty", "Difficulty")
                        .WithMany("Trails")
                        .HasForeignKey("DifficultyId")
                        .HasConstraintName("FK__trail__difficult__2B3F6F97");

                    b.HasOne("skiCentar.Services.Database.Resort", "Resort")
                        .WithMany("Trails")
                        .HasForeignKey("ResortId")
                        .HasConstraintName("FK__trail__resort_id__2C3393D0");

                    b.Navigation("Difficulty");

                    b.Navigation("Resort");
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailLocation", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Trail", "Trail")
                        .WithMany("TrailLocations")
                        .HasForeignKey("TrailId")
                        .HasConstraintName("FK__trail_loc__trail__3F466844");

                    b.Navigation("Trail");
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailMaintenance", b =>
                {
                    b.HasOne("skiCentar.Services.Database.Trail", "Trail")
                        .WithMany("TrailMaintenances")
                        .HasForeignKey("TrailId")
                        .HasConstraintName("FK__trail_mai__trail__300424B4");

                    b.Navigation("Trail");
                });

            modelBuilder.Entity("skiCentar.Services.Database.User", b =>
                {
                    b.HasOne("skiCentar.Services.Database.UserDetail", "UserDetails")
                        .WithMany("Users")
                        .HasForeignKey("UserDetailsId")
                        .HasConstraintName("FK__user__user_detai__48CFD27E");

                    b.HasOne("skiCentar.Services.Database.UserRole", "UserRole")
                        .WithMany("Users")
                        .HasForeignKey("UserRoleId")
                        .HasConstraintName("FK__user__user_role___47DBAE45");

                    b.Navigation("UserDetails");

                    b.Navigation("UserRole");
                });

            modelBuilder.Entity("skiCentar.Services.Database.Lift", b =>
                {
                    b.Navigation("LiftLocations");

                    b.Navigation("LiftMaintenances");
                });

            modelBuilder.Entity("skiCentar.Services.Database.LiftType", b =>
                {
                    b.Navigation("Lifts");
                });

            modelBuilder.Entity("skiCentar.Services.Database.PoiCategory", b =>
                {
                    b.Navigation("PointOfInterests");
                });

            modelBuilder.Entity("skiCentar.Services.Database.Resort", b =>
                {
                    b.Navigation("DailyWeathers");

                    b.Navigation("Lifts");

                    b.Navigation("PointOfInterests");

                    b.Navigation("Trails");
                });

            modelBuilder.Entity("skiCentar.Services.Database.Trail", b =>
                {
                    b.Navigation("SkiAccidents");

                    b.Navigation("TrailLocations");

                    b.Navigation("TrailMaintenances");
                });

            modelBuilder.Entity("skiCentar.Services.Database.TrailDifficulty", b =>
                {
                    b.Navigation("Trails");
                });

            modelBuilder.Entity("skiCentar.Services.Database.User", b =>
                {
                    b.Navigation("SkiAccidents");
                });

            modelBuilder.Entity("skiCentar.Services.Database.UserDetail", b =>
                {
                    b.Navigation("Users");
                });

            modelBuilder.Entity("skiCentar.Services.Database.UserRole", b =>
                {
                    b.Navigation("Users");
                });
#pragma warning restore 612, 618
        }
    }
}
