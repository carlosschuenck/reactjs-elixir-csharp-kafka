using System;
using System.Collections.Generic;
using RabbitMQ.Client;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using UserManagerApi.Models;
using UserManagerApi.Services;

namespace UserManagerApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpGet]
        public List<User> findAll()
        {
        return _userService.FindAll();
        }
      
        [HttpPost]
        public User save([FromBody] User user)
        {
        return _userService.Save(user);
        }
      
        [HttpPut]
        public User update([FromBody] User user)
        {
        return _userService.Update(user);
        }
      
        [HttpDelete("{id}")]
        public void Delete([FromRoute] int id)
        {
        _userService.Delete(id);
        }

        [HttpGet("/kafka/{userId}")]
        public async Task<string> Kafka([FromRoute] int userId)
        {
            var json = JsonSerializer.Serialize(new User(userId, "fake name"));


            var factory = new ConnectionFactory() { HostName = "localhost" };
            using (var connection = factory.CreateConnection())
            using (var channel = connection.CreateModel())
            {
                channel.QueueDeclare(queue: "hello",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                string message = "C# PRODUCER";
                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: "",
                                     routingKey: "hello",
                                     basicProperties: null,
                                     body: body);
            }

            return "funcionando...";
        }
    }
}
