using Xyz.Api.Models;
using Xyz.Api.Controllers;

namespace Xyz.UnitTests;

public class MessageTest
{
    [Fact]
    public void ShouldReturnMessage()
    {
      var messageController = new MessageController();
      var result = messageController.Get();
      Assert.Equal("sdfasdfasdfasdfasdf", result.Message);
      Assert.True(result.Timestamp > 0, "Timestamp should be set!");
    }
}
