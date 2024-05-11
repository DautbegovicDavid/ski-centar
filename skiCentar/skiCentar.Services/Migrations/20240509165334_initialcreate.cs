using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

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

            migrationBuilder.InsertData(
                table: "lift_type",
                columns: new[] { "name" },
                values: new object[,]
                {
                    { "Sjedeznica" },
                    { "Gondola" },
                    { "Sidro" },
                    { "Pokretna staza" },
                    { "Tanjir" },
                    { "Rukohvat" }
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

            migrationBuilder.InsertData(
                table: "trail_difficulty",
                columns: new[] { "name", "color" },
                values: new object[,]
                {
                    { "Beginner", "Green" },
                    { "Intermediate", "Blue" },
                    { "Advanced", "Black" }
                });

            migrationBuilder.CreateTable(
                name: "user_details",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    last_name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
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

            migrationBuilder.InsertData(
              table: "user_role",
              columns: new[] { "name" },
              values: new object[,]
              {
                    { "Admin" },
                    { "Uposlenik" },
                    { "Korinsik" }
              });

            migrationBuilder.CreateTable(
                name: "daily_weather",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    date = table.Column<DateTime>(type: "date", nullable: true),
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
                    is_functional = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))")
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
                name: "trail",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    difficulty_id = table.Column<int>(type: "int", nullable: true),
                    length = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
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
                    user_details_id = table.Column<int>(type: "int", nullable: true)
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
                    location_x = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    location_y = table.Column<decimal>(type: "decimal(10,6)", nullable: true),
                    timestamp = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    description = table.Column<string>(type: "varchar(1000)", unicode: false, maxLength: 1000, nullable: false)
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
                name: "IX_user_resort_resort_id",
                table: "user_resort",
                column: "resort_id");
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
                name: "point_of_interest");

            migrationBuilder.DropTable(
                name: "ski_accident");

            migrationBuilder.DropTable(
                name: "trail_location");

            migrationBuilder.DropTable(
                name: "trail_maintenance");

            migrationBuilder.DropTable(
                name: "user_resort");

            migrationBuilder.DropTable(
                name: "lift");

            migrationBuilder.DropTable(
                name: "poi_category");

            migrationBuilder.DropTable(
                name: "trail");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.DropTable(
                name: "lift_type");

            migrationBuilder.DropTable(
                name: "trail_difficulty");

            migrationBuilder.DropTable(
                name: "resort");

            migrationBuilder.DropTable(
                name: "user_details");

            migrationBuilder.DropTable(
                name: "user_role");
        }
    }
}
