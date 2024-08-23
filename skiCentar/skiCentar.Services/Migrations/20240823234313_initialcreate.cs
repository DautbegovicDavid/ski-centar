using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class initialcreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "lift_type",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__lift_typ__3213E83F09F8F725", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "poi_category",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__poi_cate__3213E83FDA520F22", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "resort",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    location = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    elevation = table.Column<int>(type: "int", nullable: true),
                    ski_work_hours = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__resort__3213E83F95FCDA33", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "ticket_type_seniority",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    seniority = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket_t__3213E83F6EE6FBB4", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "trail_difficulty",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    color = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__trail_di__3213E83F5DF5ADE9", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "user_details",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    last_name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    date_of_birth = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user_det__3213E83F47A47460", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "user_role",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user_rol__3213E83FD6D48D1E", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "daily_weather",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    date = table.Column<DateTime>(type: "datetime", nullable: true),
                    temperature = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    precipitation = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    wind_speed = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    humidity = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    weather_condition = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    snow_height = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    resort_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__daily_we__3213E83F8DDADEE6", x => x.id);
                    table.ForeignKey(
                        name: "FK__daily_wea__resor__267ABA7A",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "lift",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    lift_type_id = table.Column<int>(type: "int", nullable: true),
                    capacity = table.Column<int>(type: "int", nullable: true),
                    resort_id = table.Column<int>(type: "int", nullable: true),
                    is_functional = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))"),
                    state_machine = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__lift__3213E83F0CC826DF", x => x.id);
                    table.ForeignKey(
                        name: "FK__lift__lift_type___34C8D9D1",
                        column: x => x.lift_type_id,
                        principalTable: "lift_type",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__lift__resort_id__35BCFE0A",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "point_of_interest",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    category_id = table.Column<int>(type: "int", nullable: true),
                    location_x = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    location_y = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    resort_id = table.Column<int>(type: "int", nullable: true),
                    description = table.Column<string>(type: "varchar(1000)", unicode: false, maxLength: 1000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__point_of__3213E83FB040CD86", x => x.id);
                    table.ForeignKey(
                        name: "FK__point_of___categ__5165187F",
                        column: x => x.category_id,
                        principalTable: "poi_category",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__point_of___resor__52593CB8",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "ticket_type",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    full_day = table.Column<bool>(type: "bit", nullable: false),
                    price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    ticket_type_seniority_id = table.Column<int>(type: "int", nullable: true),
                    resort_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket_t__3213E83F8918DEA6", x => x.id);
                    table.ForeignKey(
                        name: "FK_ticket_type_resort",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK_ticket_type_ticket_type_seniority",
                        column: x => x.ticket_type_seniority_id,
                        principalTable: "ticket_type_seniority",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "trail",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    difficulty_id = table.Column<int>(type: "int", nullable: true),
                    length = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    resort_id = table.Column<int>(type: "int", nullable: true),
                    is_functional = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__trail__3213E83FB5BAFCDF", x => x.id);
                    table.ForeignKey(
                        name: "FK__trail__difficult__2B3F6F97",
                        column: x => x.difficulty_id,
                        principalTable: "trail_difficulty",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__trail__resort_id__2C3393D0",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    email = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    password = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    registration_date = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    last_login_date = table.Column<DateTime>(type: "datetime", nullable: true),
                    user_role_id = table.Column<int>(type: "int", nullable: true),
                    user_details_id = table.Column<int>(type: "int", nullable: true),
                    is_verified = table.Column<bool>(type: "bit", nullable: true, defaultValueSql: "((0))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user__3213E83FDCF4DEF2", x => x.id);
                    table.ForeignKey(
                        name: "FK__user__user_detai__48CFD27E",
                        column: x => x.user_details_id,
                        principalTable: "user_details",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__user__user_role___47DBAE45",
                        column: x => x.user_role_id,
                        principalTable: "user_role",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "lift_location",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    lift_id = table.Column<int>(type: "int", nullable: true),
                    location_x = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    location_y = table.Column<decimal>(type: "decimal(10,6)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__lift_loc__3213E83F658B649E", x => x.id);
                    table.ForeignKey(
                        name: "FK__lift_loca__lift___3C69FB99",
                        column: x => x.lift_id,
                        principalTable: "lift",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "lift_maintenance",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    maintenance_start = table.Column<DateTime>(type: "datetime", nullable: true),
                    maintenance_end = table.Column<DateTime>(type: "datetime", nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    lift_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__lift_mai__3213E83F1677EEE9", x => x.id);
                    table.ForeignKey(
                        name: "FK__lift_main__lift___398D8EEE",
                        column: x => x.lift_id,
                        principalTable: "lift",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "ticket",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ticket_type_id = table.Column<int>(type: "int", nullable: false),
                    total_price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    description = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    valid_from = table.Column<DateTime>(type: "date", nullable: false),
                    valid_to = table.Column<DateTime>(type: "date", nullable: false),
                    active = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket__3213E83FADDC681A", x => x.id);
                    table.ForeignKey(
                        name: "FK__ticket__ticket_t__2B0A656D",
                        column: x => x.ticket_type_id,
                        principalTable: "ticket_type",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "trail_location",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    trail_id = table.Column<int>(type: "int", nullable: true),
                    location_x = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    location_y = table.Column<decimal>(type: "decimal(10,6)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__trail_lo__3213E83F2E8E656F", x => x.id);
                    table.ForeignKey(
                        name: "FK__trail_loc__trail__3F466844",
                        column: x => x.trail_id,
                        principalTable: "trail",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "trail_maintenance",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    maintenance_start = table.Column<DateTime>(type: "datetime", nullable: true),
                    maintenance_end = table.Column<DateTime>(type: "datetime", nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    trail_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__trail_ma__3213E83F335D1040", x => x.id);
                    table.ForeignKey(
                        name: "FK__trail_mai__trail__300424B4",
                        column: x => x.trail_id,
                        principalTable: "trail",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "ski_accident",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: true),
                    trail_id = table.Column<int>(type: "int", nullable: true),
                    people_involved = table.Column<int>(type: "int", nullable: true),
                    is_reporter_injured = table.Column<bool>(type: "bit", nullable: true, defaultValueSql: "((0))"),
                    is_active = table.Column<bool>(type: "bit", nullable: true, defaultValueSql: "((1))"),
                    location_x = table.Column<decimal>(type: "decimal(10,6)", nullable: false),
                    location_y = table.Column<decimal>(type: "decimal(10,6)", nullable: false),
                    timestamp = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    description = table.Column<string>(type: "varchar(1000)", unicode: false, maxLength: 1000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ski_acci__3213E83FBC915BFB", x => x.id);
                    table.ForeignKey(
                        name: "FK__ski_accid__trail__5629CD9C",
                        column: x => x.trail_id,
                        principalTable: "trail",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__ski_accid__user___5535A963",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "user_poi_interaction",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    poi_id = table.Column<int>(type: "int", nullable: false),
                    interaction_type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    interaction_timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user_poi_interaction__3213E83F8DDADEE6", x => x.id);
                    table.ForeignKey(
                        name: "FK__user_poi_interaction__poi_id__267ABA7A",
                        column: x => x.poi_id,
                        principalTable: "point_of_interest",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__user_poi_interaction__user_id__267ABA7A",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "user_resort",
                columns: table => new
                {
                    user_id = table.Column<int>(type: "int", nullable: false),
                    resort_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user_res__D2DFBAD28F0E6CB8", x => new { x.user_id, x.resort_id });
                    table.ForeignKey(
                        name: "FK__user_reso__resor__4CA06362",
                        column: x => x.resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__user_reso__user___4BAC3F29",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "user_verification",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    verification_code = table.Column<string>(type: "varchar(256)", unicode: false, maxLength: 256, nullable: false),
                    email = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    user_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__user_ver__3213E83DB5BAFCDC", x => x.id);
                    table.ForeignKey(
                        name: "FK__user_ver__user_id__2C3393D0",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ticket_purchase",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    ticket_id = table.Column<int>(type: "int", nullable: false),
                    purchase_date = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    quantity = table.Column<int>(type: "int", nullable: false),
                    total_price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    stripe_payment_intent_id = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket_p__3213E83FF58BF17D", x => x.id);
                    table.ForeignKey(
                        name: "FK__ticket_pu__ticke__32AB8735",
                        column: x => x.ticket_id,
                        principalTable: "ticket",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__ticket_pu__user___31B762FC",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id");
                });

            migrationBuilder.InsertData(
                table: "lift_type",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { 1, "Sjedeznica" },
                    { 2, "Gondola" },
                    { 3, "Sidro" },
                    { 4, "Pokretna staza" },
                    { 5, "Tanjir" },
                    { 6, "Rukohvat" }
                });

            migrationBuilder.InsertData(
                table: "poi_category",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { 1, "Ski kasa" },
                    { 2, "Ski skola" },
                    { 3, "Ski Rental" },
                    { 4, "Hitna" },
                    { 5, "WC" },
                    { 6, "Parking" },
                    { 7, "Restoran" },
                    { 8, "Kafic" }
                });

            migrationBuilder.InsertData(
                table: "resort",
                columns: new[] { "id", "elevation", "location", "name", "ski_work_hours" },
                values: new object[,]
                {
                    { 1, 1500, "Sarajevo", "Jahorina", "9 AM - 5 PM" },
                    { 2, 1500, "Travnik", "Vlasic", "9 AM - 5 PM" }
                });

            migrationBuilder.InsertData(
                table: "trail_difficulty",
                columns: new[] { "id", "color", "name" },
                values: new object[,]
                {
                    { 1, "Green", "Pocetnicke staza" },
                    { 2, "Blue", "Staze za srednje vjestine" },
                    { 3, "Crvena", "Napredne staza" },
                    { 4, "Black", "Ekspertne staze" }
                });

            migrationBuilder.InsertData(
                table: "user_role",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { 1, "Admin" },
                    { 2, "Employee" },
                    { 3, "User" }
                });

            migrationBuilder.InsertData(
                table: "point_of_interest",
                columns: new[] { "id", "category_id", "description", "location_x", "location_y", "name", "resort_id" },
                values: new object[] { 1, 7, "Restaurant 1", 45.123456m, 14.123456m, "Restaurant 1", 1 });

            migrationBuilder.InsertData(
                table: "user",
                columns: new[] { "id", "email", "is_verified", "last_login_date", "password", "registration_date", "user_details_id", "user_role_id" },
                values: new object[,]
                {
                    { 1, "employee@email.com", true, new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7035), "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7093), null, 2 },
                    { 2, "admin@email.com", true, new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7097), "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7099), null, 1 },
                    { 3, "user@email.com", true, new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7102), "$2a$11$9gH.VB9K9HpmzPuSufzZD.f/LWqqqaXcO9TLn9NrzqQJa7XEZAlNG", new DateTime(2024, 8, 24, 1, 43, 13, 10, DateTimeKind.Local).AddTicks(7103), null, 3 }
                });

            migrationBuilder.InsertData(
                table: "user_poi_interaction",
                columns: new[] { "id", "interaction_timestamp", "interaction_type", "poi_id", "user_id" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 8, 23, 23, 43, 13, 10, DateTimeKind.Utc).AddTicks(7118), "view", 1, 3 },
                    { 2, new DateTime(2024, 8, 23, 23, 43, 13, 10, DateTimeKind.Utc).AddTicks(7119), "view", 1, 3 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_daily_weather_resort_id",
                table: "daily_weather",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_lift_lift_type_id",
                table: "lift",
                column: "lift_type_id");

            migrationBuilder.CreateIndex(
                name: "IX_lift_resort_id",
                table: "lift",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_lift_location_lift_id",
                table: "lift_location",
                column: "lift_id");

            migrationBuilder.CreateIndex(
                name: "IX_lift_maintenance_lift_id",
                table: "lift_maintenance",
                column: "lift_id");

            migrationBuilder.CreateIndex(
                name: "IX_point_of_interest_category_id",
                table: "point_of_interest",
                column: "category_id");

            migrationBuilder.CreateIndex(
                name: "IX_point_of_interest_resort_id",
                table: "point_of_interest",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_ski_accident_trail_id",
                table: "ski_accident",
                column: "trail_id");

            migrationBuilder.CreateIndex(
                name: "IX_ski_accident_user_id",
                table: "ski_accident",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_ticket_type_id",
                table: "ticket",
                column: "ticket_type_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_ticket_id",
                table: "ticket_purchase",
                column: "ticket_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_user_id",
                table: "ticket_purchase",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_type_resort_id",
                table: "ticket_type",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_type_ticket_type_seniority_id",
                table: "ticket_type",
                column: "ticket_type_seniority_id");

            migrationBuilder.CreateIndex(
                name: "IX_trail_difficulty_id",
                table: "trail",
                column: "difficulty_id");

            migrationBuilder.CreateIndex(
                name: "IX_trail_resort_id",
                table: "trail",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_trail_location_trail_id",
                table: "trail_location",
                column: "trail_id");

            migrationBuilder.CreateIndex(
                name: "IX_trail_maintenance_trail_id",
                table: "trail_maintenance",
                column: "trail_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_user_details_id",
                table: "user",
                column: "user_details_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_user_role_id",
                table: "user",
                column: "user_role_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_poi_interaction_poi_id",
                table: "user_poi_interaction",
                column: "poi_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_poi_interaction_user_id",
                table: "user_poi_interaction",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_resort_resort_id",
                table: "user_resort",
                column: "resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_verification_user_id",
                table: "user_verification",
                column: "user_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "daily_weather");

            migrationBuilder.DropTable(
                name: "lift_location");

            migrationBuilder.DropTable(
                name: "lift_maintenance");

            migrationBuilder.DropTable(
                name: "ski_accident");

            migrationBuilder.DropTable(
                name: "ticket_purchase");

            migrationBuilder.DropTable(
                name: "trail_location");

            migrationBuilder.DropTable(
                name: "trail_maintenance");

            migrationBuilder.DropTable(
                name: "user_poi_interaction");

            migrationBuilder.DropTable(
                name: "user_resort");

            migrationBuilder.DropTable(
                name: "user_verification");

            migrationBuilder.DropTable(
                name: "lift");

            migrationBuilder.DropTable(
                name: "ticket");

            migrationBuilder.DropTable(
                name: "trail");

            migrationBuilder.DropTable(
                name: "point_of_interest");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.DropTable(
                name: "lift_type");

            migrationBuilder.DropTable(
                name: "ticket_type");

            migrationBuilder.DropTable(
                name: "trail_difficulty");

            migrationBuilder.DropTable(
                name: "poi_category");

            migrationBuilder.DropTable(
                name: "user_details");

            migrationBuilder.DropTable(
                name: "user_role");

            migrationBuilder.DropTable(
                name: "resort");

            migrationBuilder.DropTable(
                name: "ticket_type_seniority");
        }
    }
}
