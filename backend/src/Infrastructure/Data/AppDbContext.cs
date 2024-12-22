using Microsoft.EntityFrameworkCore;

using backend.src.Domain.Entities;
using backend.src.Infrastructure.Configurations;

namespace backend.src.Infrastructure.Data;

public class AppDbContext  : DbContext
{
    public AppDbContext (DbContextOptions<AppDbContext > options)
        : base(options)
    {
    }  

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfiguration(new ToDoConfiguration());
    }

    public virtual DbSet<ToDo> ToDos { get; set; }
}