using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserManagerApi.Data;
using UserManagerApi.Models;

namespace UserManagerApi.Services
{
    public class UserService : IUserService
    {
        private DataContext _context = null;
        
        public UserService(DataContext context)
        {
            this._context = context;
        }

        public void Delete(int id)
        {
            var user = new User { Id = id };
            _context.User.Remove(user);
            _context.SaveChanges();
        }

        public List<User> FindAll()
        {
            return _context.User.ToList();
        }

        public User Save(User user)
        {
            User saved = _context.Add(user).Entity;
            _context.SaveChanges();
            return saved;
        }

        public User Update(User user)
        {
            _context.Entry(new User()).CurrentValues.SetValues(user);
            _context.SaveChanges();
            return user;
        }
    }
}
