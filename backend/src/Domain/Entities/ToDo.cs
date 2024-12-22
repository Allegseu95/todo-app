namespace backend.src.Domain.Entities;

public class ToDo
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public bool Completed { get; set; }
    public bool Deleted { get; set; }
}