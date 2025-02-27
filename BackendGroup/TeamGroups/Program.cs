
using Microsoft.EntityFrameworkCore;
using TeamGroups.Dto;
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

            app.MapGet("/Teams", (GroupsAbDbContext context) =>
            {
                var teams = context.Teams
                    .Include(t => t.Players)
                    .Select(t => new TeamDto()
                    {
                        TeamId = t.TeamId,
                        TeamName = t.TeamName,
                        Players = t.Players.Select(p => new PlayerDto
                        {
                            PlayerId = p.PlayerId,
                            PersonalNumber = p.PersonalNumber ?? "",
                            PlayerName = p.PlayerName,
                            Age = p.Age,
                            FkTeamId = p.FkTeamId,
                            FkTeam = t.TeamName
                        }).ToList()
                    })
                    .ToList();

                return Results.Ok(teams);
            });

            app.MapGet("/Players", (GroupsAbDbContext context) =>
            {
                var dtoPlayers = context.Players
                .Include(p => p.FkTeam) // Hämta team-information
                .Select(p => new PlayerDto
                {
                    PlayerId = p.PlayerId,
                    PersonalNumber = p.PersonalNumber ?? "",
                    PlayerName = p.PlayerName,
                    Age = p.Age,
                    FkTeamId = p.FkTeamId,
                    FkTeam = p.FkTeam.TeamName // Konvertera team-objektet till en string
                })
                .ToList();

                return Results.Ok(dtoPlayers);
            });

            app.MapPost("/Players", (GroupsAbDbContext context, PlayerDto playerDto) =>
            {
                var player = new Player
                {
                    PersonalNumber = playerDto.PersonalNumber,
                    PlayerName = playerDto.PlayerName,
                    Age = playerDto.Age,
                    FkTeamId = playerDto.FkTeamId
                };
                context.Players.Add(player);
                context.SaveChanges();
                return Results.Created($"/Players/{player.PlayerId}", player);
            });

            app.MapPost("/Tests", (GroupsAbDbContext context, TestTable testTable) =>
            {
                context.TestTables.Add(testTable);
                context.SaveChanges();
                return Results.Created($"/Tests/{testTable.TestId}", testTable);
            });
            app.MapGet("/Tests", (GroupsAbDbContext context) =>
            {
                var testTables = context.TestTables.ToList();
                return Results.Ok(testTables);
            });

            app.Run();
        }
    }
}
