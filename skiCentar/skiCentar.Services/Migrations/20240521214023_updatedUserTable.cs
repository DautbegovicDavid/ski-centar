using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class updatedUserTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.AddColumn<bool>(
                name: "is_verified",
                table: "user",
                type: "bit",
                nullable: true,
                defaultValueSql: "((1))");
        }

        /// <inheritdoc />
    }
}
