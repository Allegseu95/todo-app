using Microsoft.EntityFrameworkCore;
using System.Net.WebSockets;
using System.Text;

using backend.src.Infrastructure.Data;
using backend.src.Infrastructure.Repositories;
using backend.src.Infrastructure;
using backend.src.Application.Services; 
using backend.src.Application.Interfaces; 
using backend.src.Domain.Repositories;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql(connectionString));

builder.Services.AddScoped<IToDoRepository, ToDoRepository>();
builder.Services.AddScoped<IToDoService, ToDoService>();

builder.Services.AddOpenApi();

builder.Services.AddControllers();

builder.Services.AddSingleton<AppWebSocketManager>();

var app = builder.Build();

app.UseWebSockets();

app.Use(async (context, next) =>
{
    if (context.WebSockets.IsWebSocketRequest)
    {
        var webSocket = await context.WebSockets.AcceptWebSocketAsync();
        var webSocketManager = app.Services.GetRequiredService<AppWebSocketManager>();
        await webSocketManager.HandleConnection(webSocket);
    }
    else
    {
        await next();
    }
});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.MapControllers();

app.Run();
