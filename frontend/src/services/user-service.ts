import { User } from './../pages/user/type';
import { userApi } from "./axios-api";

export function findAllUser(){
  return userApi.get<User[]>("");
}

export function deleteUser(id: number){
  return userApi.delete(`/${id}`);
}

export function saveUser(user: User){
  return userApi.post("", user);
}