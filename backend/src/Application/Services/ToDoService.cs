using backend.src.Domain.Entities;  
using backend.src.Domain.DTOS;  
using backend.src.Domain.Repositories;  
using backend.src.Application.Interfaces;

namespace backend.src.Application.Services;

public class ToDoService : IToDoService
{
    private readonly IToDoRepository _toDoRepository;

    public ToDoService(IToDoRepository repository)
    {
        _toDoRepository = repository;
    }

    public async Task<IEnumerable<ToDo>> GetAll()
    {
        return await _toDoRepository.GetAll();
    }

    public async Task<ToDo> Register(ToDo todo)
    {
        return await _toDoRepository.Register(todo);
    }

    public async Task<ToDo> CompletedToDo(int id)
    {
        return await _toDoRepository.CompletedToDo(id);
    }

    public async Task<ToDo> DeletedToDo(int id)
    {
        return await _toDoRepository.DeletedToDo(id);
    }

    public async Task<ToDoCounts> GetStatistics()
    {
        return await _toDoRepository.GetStatistics();
    }

}
