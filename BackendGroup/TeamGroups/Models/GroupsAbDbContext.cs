using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace TeamGroups.Models;

public partial class GroupsAbDbContext : DbContext
{
    public GroupsAbDbContext()
    {
    }

    public GroupsAbDbContext(DbContextOptions<GroupsAbDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Player> Players { get; set; }

    public virtual DbSet<Team> Teams { get; set; }

    public virtual DbSet<TestTable> TestTables { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Player>(entity =>
        {
            entity.HasKey(e => e.PlayerId).HasName("PK__Player__4A4E74A8A8B67DA9");

            entity.ToTable("Player");

            entity.Property(e => e.PlayerId).HasColumnName("PlayerID");
            entity.Property(e => e.FkTeamId).HasColumnName("FkTeamID");
            entity.Property(e => e.PersonalNumber).HasMaxLength(12);
            entity.Property(e => e.PlayerName).HasMaxLength(50);

            entity.HasOne(d => d.FkTeam).WithMany(p => p.Players)
                .HasForeignKey(d => d.FkTeamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Player__FkTeamID__4222D4EF");
        });

        modelBuilder.Entity<Team>(entity =>
        {
            entity.HasKey(e => e.TeamId).HasName("PK__Team__123AE7B9D6F13F4E");

            entity.ToTable("Team");

            entity.HasIndex(e => e.TeamName, "UQ__Team__4E21CAAC280D3B21").IsUnique();

            entity.Property(e => e.TeamId).HasColumnName("TeamID");
            entity.Property(e => e.TeamName).HasMaxLength(35);
        });

        modelBuilder.Entity<TestTable>(entity =>
        {
            entity.HasKey(e => e.TestId).HasName("PK__TestTabl__8CC33160ED5A3DE5");

            entity.ToTable("TestTable");

            entity.Property(e => e.Pname)
                .HasMaxLength(20)
                .HasColumnName("PName");
            entity.Property(e => e.Tname)
                .HasMaxLength(22)
                .HasColumnName("TName");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
