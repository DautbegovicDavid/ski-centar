using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace skiCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class resortSpecificTickets : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
    name: "ticket_purchase");

            migrationBuilder.DropTable(
                name: "payment_status");

            migrationBuilder.DropTable(
                name: "ticket");

            migrationBuilder.DropTable(
                name: "ticket_type");

            migrationBuilder.DropTable(
                name: "ticket_type_seniority");
            migrationBuilder.AlterColumn<string>(
                name: "state_machine",
                table: "lift",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

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
                name: "ticket_type",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    full_day = table.Column<bool>(type: "bit", nullable: false),
                    price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    ticket_type_seniority_id = table.Column<int>(type: "int", nullable: true),
                    ticket_type_resort_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket_t__3213E83F8918DEA6", x => x.id);
                    table.ForeignKey(
                        name: "FK_ticket_type_resort",
                        column: x => x.ticket_type_resort_id,
                        principalTable: "resort",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK_ticket_type_ticket_type_seniority",
                        column: x => x.ticket_type_seniority_id,
                        principalTable: "ticket_type_seniority",
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
                    stripe_payment_intent_id = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    payment_status_id = table.Column<int>(type: "int", nullable: false, defaultValueSql: "((1))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ticket_p__3213E83FF58BF17D", x => x.id);
                    table.ForeignKey(
                        name: "FK__ticket_pu__payme__339FAB6E",
                        column: x => x.payment_status_id,
                        principalTable: "payment_status",
                        principalColumn: "id");
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

            migrationBuilder.CreateIndex(
                name: "IX_ticket_ticket_type_id",
                table: "ticket",
                column: "ticket_type_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_payment_status_id",
                table: "ticket_purchase",
                column: "payment_status_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_ticket_id",
                table: "ticket_purchase",
                column: "ticket_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_purchase_user_id",
                table: "ticket_purchase",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_type_ticket_type_resort_id",
                table: "ticket_type",
                column: "ticket_type_resort_id");

            migrationBuilder.CreateIndex(
                name: "IX_ticket_type_ticket_type_seniority_id",
                table: "ticket_type",
                column: "ticket_type_seniority_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ticket_purchase");

            migrationBuilder.DropTable(
                name: "payment_status");

            migrationBuilder.DropTable(
                name: "ticket");

            migrationBuilder.DropTable(
                name: "ticket_type");

            migrationBuilder.DropTable(
                name: "ticket_type_seniority");

            migrationBuilder.AlterColumn<string>(
                name: "state_machine",
                table: "lift",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100,
                oldNullable: true);
        }
    }
}
