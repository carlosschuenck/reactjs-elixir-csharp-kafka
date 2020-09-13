using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserManagerApi.Models;

namespace UserManagerApi.Services
{
    interface IUserService
    {
        public List<User> FindAll();
        public void Delete(int id);
        public User Save(User user);
        public User Update(User user);
    }
}
