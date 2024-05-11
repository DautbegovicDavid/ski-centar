using Mapster;
using Microsoft.EntityFrameworkCore;
using skiCentar.Services;
using skiCentar.Services.Database;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IResortService, ResortService>();

builder.Services.AddTransient<IProizvodiService, ProizvodiService>();
builder.Services.AddTransient<ILiftService, LiftService>();
builder.Services.AddTransient<ILiftTypeService, LiftTypeService>();


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<SkiCenterContext>(options =>
    options.UseSqlServer(connectionString)
);

builder.Services.AddMapster();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<SkiCenterContext>();
    //dataContext.Database.EnsureCreated(); ne treba nam
    dataContext.Database.Migrate();
}

app.Run();
