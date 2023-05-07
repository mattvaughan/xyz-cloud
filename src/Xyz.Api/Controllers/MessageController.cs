using Microsoft.AspNetCore.Mvc;
using Xyz.Api.Models;

namespace Xyz.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class MessageController : ControllerBase
{
  public MessageController()
  {
  }

  [HttpGet(Name = "GetMessage")]
  public MessageModel Get()
  {
    var message = new MessageModel
    {
      Message = "sdfasdfasdfasdfasdf",
      Timestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds()
    };
    return message;
  }
}
