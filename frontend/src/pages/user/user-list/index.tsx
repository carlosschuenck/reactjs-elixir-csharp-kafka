import { Avatar, createStyles, Grid, IconButton, makeStyles, Paper, Theme, Modal } from '@material-ui/core';
import { AddCircle, Delete, Search, Update } from '@material-ui/icons';
import React, { FunctionComponent, useEffect, useState } from 'react';
import { deleteUser, findAllUser } from '../../../services/user-service';
import { User } from '../type';
import { useHistory } from "react-router-dom";

const useStyles = makeStyles((theme: Theme) =>
  createStyles({
    root: {
     margin: 0,
    },
    paper: {
      height: 240,
      width: 200,
      padding: 10,
    },
    gridAlign: {
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center"
    },
    addGridAlign: {
      display: "flex",
      flexDirection: "row",
      justifyContent: "center",
      alignItems: "center",
      with: '100%',
      height: '100%'

    },
    avatar: {
      width: theme.spacing(20),
      height: theme.spacing(20),
      marginBottom: 5
    },
    modal: {
      position: 'absolute',
      width: 400,
      backgroundColor: theme.palette.background.paper,
      border: '2px solid #000',
      boxShadow: theme.shadows[5],
      padding: theme.spacing(2, 4, 3),
    },
  }),
);

const UserList: FunctionComponent = () => {
  const [users, setUser] = useState([{} as User])
  let history = useHistory();
  const classes = useStyles();

  useEffect(() => {
    init();
  }, []);

  const invokeDeleteAndRefesh = async (id: number | undefined) => {
    if(id) await deleteUser(id);
    await init();
  }

  async function init(){
    const list = (await findAllUser()).data;
    setUser([...list, {} as User])
  }

  const userCard = (user: User) => {
    return (
      <Grid  container className={classes.gridAlign}>
        <Grid item>
          <Avatar alt="Remy Sharp" className={classes.avatar} src="/images/avatar.png" />
        </Grid>
        <Grid item>
            {user.name?.length > 20 ?
              `${user.name.substring(0, 20)}...` : user.name
            }
        </Grid>
        <Grid item>
          <IconButton aria-label="search-task" onClick={() => { }}>
            <Search  fontSize="large" />
          </IconButton>
          <IconButton aria-label="update" onClick={() => { }}>
            <Update  fontSize="large" />
          </IconButton>
          <IconButton aria-label="delete" onClick={() => { invokeDeleteAndRefesh(user.id) }}>
            <Delete  fontSize="large" />
          </IconButton>
        </Grid>
      </Grid>
    )
  }

  const goToForm = () => {
    history.push("/usuario")
  }


  const addUserCard = () => {
    return (
      <Grid  container className={classes.addGridAlign}>
        <Grid item>
          <IconButton aria-label="search-task" onClick={goToForm}>
            <AddCircle  fontSize="large" />
          </IconButton>
        </Grid>
      </Grid>
    )
  }
 
  return (
      <Grid container spacing={6} className={classes.root}>
        {users.map((user, index) => (
          <Grid item key={index} >
              <Paper  elevation={3} className={classes.paper}>
                { user.id == null ? addUserCard() : userCard(user) }
              </Paper>
          </Grid>
        ))}
      </Grid>
  );
}

export default UserList;