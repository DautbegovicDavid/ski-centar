using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class ticketTypeFkResortRename : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ticket_type_resort_id",
                table: "ticket_type",
                newName: "resort_id");

            migrationBuilder.RenameIndex(
                name: "IX_ticket_type_ticket_type_resort_id",
                table: "ticket_type",
                newName: "IX_ticket_type_resort_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "resort_id",
                table: "ticket_type",
                newName: "ticket_type_resort_id");

            migrationBuilder.RenameIndex(
                name: "IX_ticket_type_resort_id",
                table: "ticket_type",
                newName: "IX_ticket_type_ticket_type_resort_id");
        }
    }
}
