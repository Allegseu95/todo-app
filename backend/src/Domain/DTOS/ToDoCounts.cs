namespace backend.src.Domain.DTOS;

public class ToDoCounts
{
    public int Completed { get; set; }
    public int NoCompleted { get; set; }
    public int Deleted { get; set; }

    public ToDoCounts(int completed, int noCompleted, int deleted)
    {
        Completed = completed;
        NoCompleted = noCompleted;
        Deleted = deleted;
    }
}
