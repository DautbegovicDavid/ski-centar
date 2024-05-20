using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class updatedLiftTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "state_machine",
                table: "lift",
                type: "nvarchar(100)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "state_machine",
                table: "lift");
        }
    }
}
