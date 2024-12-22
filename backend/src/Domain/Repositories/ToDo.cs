using backend.src.Domain.Entities;   
using backend.src.Domain.DTOS;   

namespace backend.src.Domain.Repositories;

public interface IToDoRepository
{
    Task<IEnumerable<ToDo>> GetAll();
    Task<ToDo> Register(ToDo todo);
    Task<ToDo> CompletedToDo(int id);
    Task<ToDo> DeletedToDo(int id);
    Task<ToDoCounts> GetStatistics();
}