using Microsoft.EntityFrameworkCore;
using TeamGroups.Dto;
using TeamGroups.Models;

namespace TeamGroups.Endpoints
{
    public class TeamEndpoints
    {
        public static void MapTeamEndpoints(WebApplication app)
        {
            app.MapGet("/Teams", async (GroupsAbDbContext context) =>
            {
                var teams = await context.Teams
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
                    .ToListAsync();

                return Results.Ok(teams);
            });
        }
    }
}
