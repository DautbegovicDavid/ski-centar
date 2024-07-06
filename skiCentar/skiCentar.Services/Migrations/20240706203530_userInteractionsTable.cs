using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class userInteractionsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.CreateIndex(
                name: "IX_user_poi_interaction_poi_id",
                table: "user_poi_interaction",
                column: "poi_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_poi_interaction_user_id",
                table: "user_poi_interaction",
                column: "user_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user_poi_interaction");
        }
    }
}
