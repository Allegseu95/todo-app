using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using backend.src.Domain.Entities;

namespace backend.src.Infrastructure.Configurations;

public class ToDoConfiguration : IEntityTypeConfiguration<ToDo>
{
    public void Configure(EntityTypeBuilder<ToDo> entity)
    {
        entity.HasKey(p => p.Id);

        entity.Property(p => p.Name)
            .IsRequired(true);

        entity.Property(p => p.Completed)
            .IsRequired(true);

        entity.Property(p => p.Deleted)
            .IsRequired(true);
    }
}