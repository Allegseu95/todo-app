using Microsoft.AspNetCore.Mvc;

using backend.src.Domain.Entities;
using backend.src.Application.Interfaces;
using backend.src.Infrastructure;

namespace backend.src.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ToDoController : ControllerBase
{
    private readonly IToDoService _toDoService;
    private readonly AppWebSocketManager _webSocketManager;

    public ToDoController(IToDoService todoService,AppWebSocketManager webSocketManager)
    {
        _toDoService = todoService;
        _webSocketManager = webSocketManager;
    }
    
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var todos = await _toDoService.GetAll();
        
        return Ok(new { data = todos });
    }

    [HttpPost]
    public async Task<IActionResult> Register([FromBody] ToDo todo)
    {
        var newTodo = await _toDoService.Register(todo);

        var statitics = await _toDoService.GetStatistics();

        await _webSocketManager.UpdateTaskStatisticsToClients(statitics.Completed, statitics.NoCompleted, statitics.Deleted);

        return Ok(newTodo);
    }

    [HttpPut("complete/{id}")]
    public async Task<IActionResult> Complete(int id)
    {
        var completedTodo = await _toDoService.CompletedToDo(id);

        if (completedTodo == null)
        {
            return NotFound($"Tarea con ID {id} no encontrada.");
        }

        var statitics = await _toDoService.GetStatistics();

        await _webSocketManager.UpdateTaskStatisticsToClients(statitics.Completed, statitics.NoCompleted, statitics.Deleted);

        return Ok(completedTodo);
    }

    [HttpPut("delete/{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var deletedTodo = await _toDoService.DeletedToDo(id);

        if (deletedTodo == null)
        {
            return NotFound($"Tarea con ID {id} no encontrada.");
        }

        var statitics = await _toDoService.GetStatistics();

        await _webSocketManager.UpdateTaskStatisticsToClients(statitics.Completed, statitics.NoCompleted, statitics.Deleted);

        return Ok(deletedTodo);
    }

}

