using backend.src.Domain.Entities;  
using backend.src.Domain.DTOS;  

namespace backend.src.Application.Interfaces;

public interface IToDoService
{
    Task<IEnumerable<ToDo>> GetAll();
    Task<ToDo> Register(ToDo todo);
    Task<ToDo> CompletedToDo(int id);
    Task<ToDo> DeletedToDo(int id);
    Task<ToDoCounts> GetStatistics();
}