using Mapster;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using skiCentar.API.Filters;
using skiCentar.Services;
using skiCentar.Services.Database;
using skiCentar.Services.LiftStateMachine;
using Stripe;
using System.Text;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddTransient<IResortService, ResortService>();
builder.Services.AddTransient<ILiftService, LiftService>();
builder.Services.AddTransient<ILiftTypeService, LiftTypeService>();
builder.Services.AddTransient<IUserRoleService, UserRoleService>();
builder.Services.AddTransient<ITrailService, TrailService>();
builder.Services.AddTransient<ITrailDifficultyService, TrailDifficultyService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IAuthenticationService, AuthenticationService>();
builder.Services.AddTransient<IPointOfInterestCategoryService, PointOfInterestCategoryService>();
builder.Services.AddTransient<IPointOfInterestService, PointOfInterestService>();
builder.Services.AddTransient<IDailyWeatherService, DailyWeatherService>();
builder.Services.AddTransient<ITicketTypeSeniorityService, TicketTypeSeniorityService>();
builder.Services.AddTransient<ITicketTypeService, TicketTypeService>();
builder.Services.AddTransient<IUserDetailService, UserDetailService>();
builder.Services.AddTransient<ITicketService, TicketService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();
builder.Services.AddTransient<ISkiAccidentService, SkiAccidentService>();
builder.Services.AddTransient<IUserPoiInteractionService, UserPoiInteractionService>();
builder.Services.AddTransient<ITicketPurchaseService, TicketPurchaseService>();

// State machine
builder.Services.AddTransient<BaseLiftState>();
builder.Services.AddTransient<InitialLiftState>();
builder.Services.AddTransient<DraftLiftState>();
builder.Services.AddTransient<ActiveLiftState>();
builder.Services.AddTransient<HiddenLiftState>();

// Register WeatherService and FirebaseService 
builder.Services.AddHttpClient<WeatherService>();
builder.Services.AddHttpClient<FirebaseService>();
builder.Services.AddTransient<RecommendationsService>();

// RabbitMQ
builder.Services.AddScoped<IRabbitMQService, RabbitMQService>();

// Stripe configuration
var stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY") ?? builder.Configuration["Stripe:SecretKey"];
StripeConfiguration.ApiKey = stripeSecretKey;

// Add services to the container
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
    };
});

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ExceptionFilter>();
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "My API", Version = "v1" });

    // Configure JWT Authentication for Swagger
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                },
                Scheme = "oauth2",
                Name = "Bearer",
                In = ParameterLocation.Header
            },
            new List<string>()
        }
    });
});

var connectionString = Environment.GetEnvironmentVariable("DB_CONNECTION") ?? builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<SkiCenterContext>(options =>
    options.UseSqlServer(connectionString)
);

builder.Services.AddMapster();
var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
    });
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<SkiCenterContext>();
    dataContext.Database.Migrate();
}

app.Run();
