using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class updateSkiAccidentTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "is_active",
                table: "ski_accident",
                type: "bit",
                nullable: true,
                defaultValueSql: "((1))");

            migrationBuilder.AddColumn<bool>(
                name: "is_reporter_injured",
                table: "ski_accident",
                type: "bit",
                nullable: true,
                defaultValueSql: "((0))");

            migrationBuilder.AddColumn<int>(
                name: "people_involved",
                table: "ski_accident",
                type: "int",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "is_active",
                table: "ski_accident");

            migrationBuilder.DropColumn(
                name: "is_reporter_injured",
                table: "ski_accident");

            migrationBuilder.DropColumn(
                name: "people_involved",
                table: "ski_accident");
        }
    }
}
