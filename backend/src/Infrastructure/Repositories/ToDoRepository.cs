using backend.src.Domain.Entities;
using backend.src.Domain.DTOS; 
using backend.src.Domain.Repositories;
using backend.src.Infrastructure.Data;

using Microsoft.EntityFrameworkCore;

namespace backend.src.Infrastructure.Repositories;

public class ToDoRepository : IToDoRepository
    {
        private readonly AppDbContext _context;

        public ToDoRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ToDo>> GetAll()
        {
            return await _context.ToDos.ToListAsync();
        }

        public async Task<ToDo> Register(ToDo todo)
        {
            await _context.ToDos.AddAsync(todo);
            await _context.SaveChangesAsync();
            return todo;
        }

        public async Task<ToDo> CompletedToDo (int id)
        {
            var todo = await _context.ToDos.FindAsync(id);

            if (todo != null)
            {
                todo.Completed = !todo.Completed;
                await _context.SaveChangesAsync();
            }
            return todo;
        }

        public async Task<ToDo> DeletedToDo (int id)
        {
            var todo = await _context.ToDos.FindAsync(id);

            if (todo != null)
            {
                todo.Deleted = true;
                await _context.SaveChangesAsync();
            }
            return todo;
        }

        public async Task<ToDoCounts> GetStatistics()
        {
            var todos = await _context.ToDos.ToListAsync();

            var completed = todos.Count(todo => todo.Completed && !todo.Deleted);

            var noCompleted = todos.Count(todo => !todo.Completed && !todo.Deleted);

            var deleted = todos.Count(todo => todo.Deleted);

            return new ToDoCounts(completed, noCompleted, deleted);
        }
    }