# TeamGroups Project Documentation

## Table of Contents
1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Backend Architecture](#backend-architecture)
   - [Data Models](#data-models)
   - [DTOs (Data Transfer Objects)](#dtos-data-transfer-objects)
   - [API Endpoints](#api-endpoints)
   - [Database Context](#database-context)
4. [Frontend Implementation](#frontend-implementation)
   - [HTML Structure](#html-structure)
   - [JavaScript Functionality](#javascript-functionality)
   - [CSS Styling](#css-styling)
5. [Setup and Configuration](#setup-and-configuration)
   - [Prerequisites](#prerequisites)
   - [Database Connection](#database-connection)
   - [Running the Application](#running-the-application)
6. [API Reference](#api-reference)
7. [Common Troubleshooting](#common-troubleshooting)

## Overview

TeamGroups is a web application designed to manage teams and players. It provides functionality to view teams and their associated players, as well as testing functionality to add test data. The application uses a .NET 8 backend with Entity Framework Core 9 for data access and a simple HTML/CSS/JavaScript frontend.

## Project Structure

The project is organized into two main folders:

- **Backend_Group**: Contains the .NET application with API endpoints, data models, and database configuration
- **Frontend_Group**: Contains the web frontend with HTML, CSS, and JavaScript files

### Key Files Overview

#### Backend
- **Models/**: Entity classes representing database tables
- **Dto/**: Data Transfer Objects for API responses and requests
- **Endpoints/**: API endpoint definitions
- **Program.cs**: Application configuration and startup

#### Frontend
- **index.html**: Main page structure
- **style.css**: Styling for the application
- **main.js**: JavaScript for frontend functionality

## Backend Architecture

The backend is built using .NET 8 with a minimal API approach, structured around Entity Framework Core for database operations.

### Data Models

The data model consists of the following key entities:

#### Team
```csharp
public partial class Team
{
    public int TeamId { get; set; }
    public string TeamName { get; set; } = null!;
    public virtual ICollection<Player> Players { get; set; } = new List<Player>();
}
```

#### Player
```csharp
public partial class Player
{
    public int PlayerId { get; set; }
    public string? PersonalNumber { get; set; }
    public string PlayerName { get; set; } = null!;
    public int? Age { get; set; }
    public int FkTeamId { get; set; }
    public virtual Team FkTeam { get; set; } = null!;
}
```

#### TestTable
```csharp
public partial class TestTable
{
    public int TestId { get; set; }
    public string? Pname { get; set; }
    public string? Tname { get; set; }
}
```

### DTOs (Data Transfer Objects)

DTOs are used to transfer data between the API and clients without exposing internal implementation details:

#### TeamDto
```csharp
public class TeamDto
{
    public int TeamId { get; set; }
    public string TeamName { get; set; } = string.Empty;
    public List<PlayerDto> Players { get; set; } = new();
}
```

#### PlayerDto
```csharp
public class PlayerDto
{
    public int PlayerId { get; set; }
    public string PersonalNumber { get; set; } = string.Empty;
    public string PlayerName { get; set; } = string.Empty;
    public int? Age { get; set; }
    public int FkTeamId { get; set; }
    public string FkTeam { get; set; } = string.Empty;
}
```

### API Endpoints

The API exposes the following endpoints:

#### Team Endpoints
- **GET /Teams**: Retrieves all teams with their players

```csharp
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
```

#### Player Endpoints
- **GET /Players**: Retrieves all players with their team information
- **POST /Players**: Creates a new player

```csharp
app.MapGet("/Players", async (GroupsAbDbContext context) =>
{
    var dtoPlayers = await context.Players
    .Include(p => p.FkTeam)
    .Select(p => new PlayerDto
    {
        PlayerId = p.PlayerId,
        PersonalNumber = p.PersonalNumber ?? "",
        PlayerName = p.PlayerName,
        Age = p.Age,
        FkTeamId = p.FkTeamId,
        FkTeam = p.FkTeam.TeamName
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
```

#### Test Endpoints
- **GET /Tests**: Retrieves all test entries
- **POST /Tests**: Creates a new test entry

```csharp
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
```

### Database Context

The application uses Entity Framework Core with the `GroupsAbDbContext` class to interact with the database:

```csharp
public partial class GroupsAbDbContext : DbContext
{
    public GroupsAbDbContext(DbContextOptions<GroupsAbDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Player> Players { get; set; }
    public virtual DbSet<Team> Teams { get; set; }
    public virtual DbSet<TestTable> TestTables { get; set; }

    // Entity configuration in OnModelCreating method...
}
```

## Frontend Implementation

The frontend is a simple web interface that communicates with the API to display and manage teams and players.

### HTML Structure

The main page is structured with:
- Header with title
- Container with three sections:
  - Test POST form
  - Test data viewer
  - Teams viewer

### JavaScript Functionality

The main.js file contains three primary functions:

1. **GetTeams()**: Fetches teams and their players from the API and displays them
2. **GetTest()**: Fetches test data from the API and displays it
3. **Form Event Listener**: Handles form submission to add new test entries

```javascript
async function GetTeams() {
  try {
    const response = await fetch("https://localhost:7224/Teams");
    const data = await response.json();
    // Display logic...
  } catch (error) {
    console.log("Error: ", error);
  }
}

async function GetTest() {
  try {
    const response = await fetch("https://localhost:7224/Tests");
    const data = await response.json();
    // Display logic...
  } catch (error) {
    console.log("Error: ", error);
  }
}

// Form event listener for adding test entries
document
  .getElementById("addPlayerForm")
  .addEventListener("submit", async (e) => {
    e.preventDefault();
    // Form handling logic...
  });
```

### CSS Styling

The application has responsive styling with:
- Clean card-based layout
- Hover effects
- Mobile-friendly design with media queries
- Form styling

## Setup and Configuration

### Prerequisites

- .NET 8 SDK
- SQL Server (local or remote)
- Web browser

### Database Connection

1. Configure your database connection string in one of these locations:
   - User Secrets (development environment)
   - appsettings.json file

Example connection string format:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=YOUR_SERVER;Database=YOUR_DB;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

### Running the Application

#### Backend
1. Navigate to the Backend_Group directory
2. Run the application using the .NET CLI:
   ```
   dotnet run
   ```
   or open the solution in Visual Studio and run it from there.
3. The API will be available at https://localhost:7224 and http://localhost:5159

#### Frontend
1. Open the `index.html` file in a web browser
   - For development, you can use a local server like Live Server extension in VS Code
   - Make sure CORS is properly configured in the backend (it is in the current configuration)

## API Reference

### Teams

#### GET /Teams
- Returns all teams with their players
- Response: Array of TeamDto objects

### Players

#### GET /Players
- Returns all players with team information
- Response: Array of PlayerDto objects

#### POST /Players
- Creates a new player
- Request Body: PlayerDto object
- Response: Created player

### Tests

#### GET /Tests
- Returns all test entries
- Response: Array of TestTable objects

#### POST /Tests
- Creates a new test entry
- Request Body: TestTable object
- Response: Created test entry

## Common Troubleshooting

### API Connection Issues
- Verify that the backend API is running
- Check that the ports in your frontend code match the ports in the launchSettings.json file
- Ensure CORS is properly configured
- Check browser console for error messages

### Database Connection Issues
- Verify your connection string is correct
- Ensure SQL Server is running
- Check that the database exists and user has appropriate permissions
- For development, make sure user secrets are configured correctly

### Data Display Issues
- Use browser dev tools to inspect network traffic and responses
- Check for JavaScript errors in the console
- Verify that the data structure in API responses matches what the frontend expects
