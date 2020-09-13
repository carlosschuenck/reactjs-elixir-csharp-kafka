import axios from 'axios';


const userApi = axios.create({
  baseURL: 'http://localhost:5000/User'
});

const taskApi = axios.create({
  baseURL: 'http://localhost:5000/User'
});

export { userApi, taskApi}