using System;
using System.Collections.Generic;

namespace TeamGroups.Models;

public partial class Player
{
    public int PlayerId { get; set; }

    public string? PersonalNumber { get; set; }

    public string PlayerName { get; set; } = null!;

    public int? Age { get; set; }

    public int FkTeamId { get; set; }

    public virtual Team FkTeam { get; set; } = null!;
}
