using skiCentar.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IProizvodiService, ProizvodiService>();
//builder.Services.AddTransient<ProizvodiService, DummyProizvodiService>();
//builder.Services.AddTransient<IProizvodiService, DummyProizvodiService>();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

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

app.Run();
