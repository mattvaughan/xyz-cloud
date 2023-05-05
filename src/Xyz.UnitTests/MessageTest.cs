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
      Assert.Equal("Automate all the things!", result.Message);
      Assert.True(result.Timestamp > 0, "Timestamp should be set!");
    }
}
