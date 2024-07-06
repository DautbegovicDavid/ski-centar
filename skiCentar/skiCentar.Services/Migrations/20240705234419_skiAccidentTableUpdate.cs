using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class skiAccidentTableUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<decimal>(
                name: "location_y",
                table: "ski_accident",
                type: "decimal(10,6)",
                nullable: false,
                defaultValue: 0m,
                oldClrType: typeof(decimal),
                oldType: "decimal(10,6)",
                oldNullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "location_x",
                table: "ski_accident",
                type: "decimal(10,6)",
                nullable: false,
                defaultValue: 0m,
                oldClrType: typeof(decimal),
                oldType: "decimal(10,6)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "description",
                table: "ski_accident",
                type: "varchar(1000)",
                unicode: false,
                maxLength: 1000,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "varchar(1000)",
                oldUnicode: false,
                oldMaxLength: 1000);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<decimal>(
                name: "location_y",
                table: "ski_accident",
                type: "decimal(10,6)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(10,6)");

            migrationBuilder.AlterColumn<decimal>(
                name: "location_x",
                table: "ski_accident",
                type: "decimal(10,6)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(10,6)");

            migrationBuilder.AlterColumn<string>(
                name: "description",
                table: "ski_accident",
                type: "varchar(1000)",
                unicode: false,
                maxLength: 1000,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "varchar(1000)",
                oldUnicode: false,
                oldMaxLength: 1000,
                oldNullable: true);
        }
    }
}
