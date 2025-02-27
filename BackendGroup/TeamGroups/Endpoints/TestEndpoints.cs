using TeamGroups.Models;

namespace TeamGroups.Endpoints
{
    public class TestEndpoints
    {
        public static void MapTestEndpoints(WebApplication app)
        {
            app.MapPost("/Tests", async (GroupsAbDbContext context, TestTable testTable) =>
            {
                context.TestTables.Add(testTable);
                await context.SaveChangesAsync();
                return Results.Created($"/Tests/{testTable.TestId}", testTable);
            });
            app.MapGet("/Tests", (GroupsAbDbContext context) =>
            {
                var testTables = context.TestTables.ToList();
                return Results.Ok(testTables);
            });
        }
    }
}
