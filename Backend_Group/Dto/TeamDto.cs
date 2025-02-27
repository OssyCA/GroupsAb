namespace TeamGroups.Dto
{
    public class TeamDto
    {
        public int TeamId { get; set; }
        public string TeamName { get; set; } = string.Empty;
        public List<PlayerDto> Players { get; set; } = new(); 
    }
}
