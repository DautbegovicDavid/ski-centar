using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class removePaymentStatusTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__ticket_pu__payme__339FAB6E",
                table: "ticket_purchase");

            migrationBuilder.DropTable(
                name: "payment_status");

            migrationBuilder.DropIndex(
                name: "IX_ticket_purchase_payment_status_id",
                table: "ticket_purchase");

            migrationBuilder.RenameColumn(
                name: "payment_status_id",
                table: "ticket_purchase",
                newName: "PaymentStatusId");

            migrationBuilder.AlterColumn<int>(
                name: "PaymentStatusId",
                table: "ticket_purchase",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValueSql: "((1))");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PaymentStatusId",
                table: "ticket_purchase",
                newName: "payment_status_id");

            migrationBuilder.AlterColumn<int>(
                name: "payment_status_id",
                table: "ticket_purchase",
                type: "int",
                nullable: false,
                defaultValueSql: "((1))",
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateTable(
                name: "payment_status",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    status = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__payment___3213E83F5EC46707", x => x.id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_payment_status_id",
                table: "ticket_purchase",
                column: "payment_status_id");

            migrationBuilder.AddForeignKey(
                name: "FK__ticket_pu__payme__339FAB6E",
                table: "ticket_purchase",
                column: "payment_status_id",
                principalTable: "payment_status",
                principalColumn: "id");
        }
    }
}
