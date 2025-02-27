namespace TeamGroups.Dto
{
    public class PlayerDto
    {
        public int PlayerId { get; set; }
        public string PersonalNumber { get; set; } = string.Empty;
        public string PlayerName { get; set; } = string.Empty;
        public int? Age { get; set; }
        public int FkTeamId { get; set; }
        public string FkTeam { get; set; } = string.Empty;
    }
}
