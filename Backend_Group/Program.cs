
using Microsoft.EntityFrameworkCore;
using TeamGroups.Dto;
using TeamGroups.Endpoints;
using TeamGroups.Models;

namespace TeamGroups
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // add CORS policy to allow all origins to access the API
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAllOrigins",
                    policy =>
                    {
                        policy.AllowAnyOrigin()
                              .AllowAnyMethod()
                              .AllowAnyHeader();
                    });
            });
            // add user secrets in development environment
            if (builder.Environment.IsDevelopment()) 
            {
                builder.Configuration.AddUserSecrets<Program>(); 
            }



            builder.Services.AddAuthorization();

            // Swagger/OpenAPI
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddDbContext<GroupsAbDbContext>(option =>
            {
                option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();
            // add CORS policy
            app.UseCors("AllowAllOrigins");

            app.UseAuthorization();

            // Map the endpoints
            TeamEndpoints.MapTeamEndpoints(app);
            PlayerEndpoints.MapPlayerEndpoints(app);
            TestEndpoints.MapTestEndpoints(app);

            app.Run();
        }
    }
}
