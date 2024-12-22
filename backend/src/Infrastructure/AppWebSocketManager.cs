using System.Net.WebSockets;
using System.Text;
using System.Threading;
using System.Text.Json;

namespace backend.src.Infrastructure;

public class AppWebSocketManager
{
    private readonly List<WebSocket> _webSockets = new List<WebSocket>();

    public async Task HandleConnection(WebSocket webSocket)
    {
        _webSockets.Add(webSocket);

        var buffer = new byte[1024 * 4];
        while (webSocket.State == WebSocketState.Open)
        {
            var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
            if (result.MessageType == WebSocketMessageType.Close)
            {
                await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closed by client", CancellationToken.None);
                _webSockets.Remove(webSocket);
            }
        }
    }

    public async Task UpdateTaskStatisticsToClients(int completed, int noCompleted, int deleted)
    {
        var jsonMessage = JsonSerializer.Serialize(new { completed = completed, noCompleted = noCompleted, deleted = deleted });

        var buffer = Encoding.UTF8.GetBytes(jsonMessage);

        var segment = new ArraySegment<byte>(buffer);

        foreach (var webSocket in _webSockets)
        {
            if (webSocket.State == WebSocketState.Open)
            {
                await webSocket.SendAsync(segment, WebSocketMessageType.Text, true, CancellationToken.None);
            }
        }
    }
}
