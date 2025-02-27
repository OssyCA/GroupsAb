using Microsoft.EntityFrameworkCore;
using TeamGroups.Dto;
using TeamGroups.Models;

namespace TeamGroups.Endpoints
{
    public class PlayerEndpoints
    {
        public static void MapPlayerEndpoints(WebApplication app)
        {
            app.MapGet("/Players", async (GroupsAbDbContext context) =>
            {
                var dtoPlayers = await context.Players
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
                .ToListAsync();

                return Results.Ok(dtoPlayers);
            });

            app.MapPost("/Players", async (GroupsAbDbContext context, PlayerDto playerDto) =>
            {
                var player = new Player
                {
                    PersonalNumber = playerDto.PersonalNumber,
                    PlayerName = playerDto.PlayerName,
                    Age = playerDto.Age,
                    FkTeamId = playerDto.FkTeamId
                };
                context.Players.Add(player);
                await context.SaveChangesAsync();
                return Results.Created($"/Players/{player.PlayerId}", player);
            });
        }
    }
}
