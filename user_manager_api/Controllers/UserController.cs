using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Confluent.Kafka;
using Microsoft.AspNetCore.Http;
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
        private ProducerConfig _config;
        public UserController(UserService userService, ProducerConfig config)
        {
            _userService = userService;
            _config = config;
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
        [HttpGet("/kafka")]
        public async Task<string> Kafka([FromQuery] String message)
        {
            var json = JsonSerializer.Serialize(new User(1, message));
            using (var producer = new ProducerBuilder<Null, string>(_config).Build())
            {
                await producer.ProduceAsync("task_manager_topic", new Message<Null, string> { Value = json });
                producer.Flush(TimeSpan.FromSeconds(10));

            }
                return "funcionando...";
        }
    }
}
